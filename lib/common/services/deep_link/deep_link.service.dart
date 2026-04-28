import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

/// Resolved representation of an incoming deep link.
sealed class DeepLinkTarget {
  const DeepLinkTarget();
}

class DeepLinkGroupInvite extends DeepLinkTarget {
  final String inviteCode;
  const DeepLinkGroupInvite(this.inviteCode);
}

class DeepLinkTasting extends DeepLinkTarget {
  final String tastingId;
  const DeepLinkTasting(this.tastingId);
}

class DeepLinkFriend extends DeepLinkTarget {
  final String friendId;
  const DeepLinkFriend(this.friendId);
}

/// Listens for incoming `io.sippd://...` URIs and emits typed targets.
/// Auth callback URIs (`login-callback`) are ignored here — Supabase SDK
/// handles those itself.
class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  final StreamController<DeepLinkTarget> _controller =
      StreamController<DeepLinkTarget>.broadcast();
  StreamSubscription<Uri>? _sub;

  Stream<DeepLinkTarget> get stream => _controller.stream;

  Future<void> init() async {
    try {
      final initial = await _appLinks.getInitialLink();
      if (initial != null) _emit(initial);
    } catch (e) {
      debugPrint('DeepLink initial: $e');
    }
    _sub = _appLinks.uriLinkStream.listen(
      _emit,
      onError: (e) => debugPrint('DeepLink stream error: $e'),
    );
  }

  void _emit(Uri uri) {
    debugPrint('DeepLink in: $uri');
    final t = _parse(uri);
    if (t != null) _controller.add(t);
  }

  DeepLinkTarget? _parse(Uri uri) {
    // Auth callback is handled by supabase_flutter. Skip.
    if (uri.scheme == 'io.sippd' && uri.host == 'login-callback') return null;

    final String kind;
    final List<String> segments;

    if (uri.scheme == 'io.sippd') {
      // io.sippd://tasting/<id>  →  host = 'tasting', path = '/<id>'
      kind = uri.host;
      segments = uri.pathSegments;
    } else if ((uri.scheme == 'https' || uri.scheme == 'http') &&
        (uri.host == 'sippd.xyz' || uri.host == 'sippd.app')) {
      // https://sippd.xyz/tasting/<id>  →  segments = ['tasting', '<id>']
      if (uri.pathSegments.isEmpty) return null;
      kind = uri.pathSegments.first;
      segments = uri.pathSegments.skip(1).toList();
    } else {
      return null;
    }

    String? at(int i) => segments.length > i ? segments[i] : null;

    switch (kind) {
      case 'group':
        final code = at(0) ?? uri.queryParameters['code'];
        if (_isValidInviteCode(code)) return DeepLinkGroupInvite(code!);
        return null;
      case 'tasting':
        final id = at(0) ?? uri.queryParameters['id'];
        if (_isValidUuid(id)) return DeepLinkTasting(id!);
        return null;
      case 'friend':
        final id = at(0) ?? uri.queryParameters['id'];
        if (_isValidUuid(id)) return DeepLinkFriend(id!);
        return null;
    }
    return null;
  }

  static final _uuidRe = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-'
    r'[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );
  static final _inviteCodeRe = RegExp(r'^[A-Za-z0-9_-]{1,32}$');

  bool _isValidUuid(String? s) => s != null && _uuidRe.hasMatch(s);
  bool _isValidInviteCode(String? s) =>
      s != null && _inviteCodeRe.hasMatch(s);

  Future<void> dispose() async {
    await _sub?.cancel();
    await _controller.close();
  }

  // Encoder helpers so the rest of the app doesn't hard-code the scheme.
  static String groupInviteUri(String code) => 'io.sippd://group/$code';
  static String tastingUri(String id) => 'io.sippd://tasting/$id';
  static String friendUri(String id) => 'io.sippd://friend/$id';

  // HTTPS shareable URLs — chat apps (WhatsApp, iMessage) linkify these,
  // custom schemes they don't. Landing page on sippd.xyz redirects into app.
  static String tastingHttpsUri(String id) =>
      'https://sippd.xyz/tasting/$id';
  static String groupInviteHttpsUri(String code) =>
      'https://sippd.xyz/group/$code';
  static String friendHttpsUri(String id) =>
      'https://sippd.xyz/friend/$id';

  // Compact wire format for SharedPreferences storage when a deep link
  // arrives before the user is ready to consume it. Keep human-readable so
  // the next session can debug the stash if it gets stuck.
  static String serializeTarget(DeepLinkTarget t) => switch (t) {
        DeepLinkGroupInvite(:final inviteCode) => 'group:$inviteCode',
        DeepLinkTasting(:final tastingId) => 'tasting:$tastingId',
        DeepLinkFriend(:final friendId) => 'friend:$friendId',
      };

  static DeepLinkTarget? deserializeTarget(String s) {
    final i = s.indexOf(':');
    if (i <= 0 || i == s.length - 1) return null;
    final kind = s.substring(0, i);
    final id = s.substring(i + 1);
    return switch (kind) {
      'group' => _inviteCodeRe.hasMatch(id) ? DeepLinkGroupInvite(id) : null,
      'tasting' => _uuidRe.hasMatch(id) ? DeepLinkTasting(id) : null,
      'friend' => _uuidRe.hasMatch(id) ? DeepLinkFriend(id) : null,
      _ => null,
    };
  }
}
