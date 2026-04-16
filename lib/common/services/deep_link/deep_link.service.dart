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
    if (uri.scheme != 'io.sippd') return null;
    // Auth callback is handled by supabase_flutter. Skip.
    if (uri.host == 'login-callback') return null;

    final first = uri.host;
    final segments = uri.pathSegments;

    // Accept both `io.sippd://group/{code}` and `io.sippd://group?code=...`
    String? at(int i) => segments.length > i ? segments[i] : null;

    switch (first) {
      case 'group':
        final code = at(0) ?? uri.queryParameters['code'];
        if (code != null && code.isNotEmpty) {
          return DeepLinkGroupInvite(code);
        }
        return null;
      case 'tasting':
        final id = at(0) ?? uri.queryParameters['id'];
        if (id != null && id.isNotEmpty) return DeepLinkTasting(id);
        return null;
      case 'friend':
        final id = at(0) ?? uri.queryParameters['id'];
        if (id != null && id.isNotEmpty) return DeepLinkFriend(id);
        return null;
    }
    return null;
  }

  Future<void> dispose() async {
    await _sub?.cancel();
    await _controller.close();
  }

  // Encoder helpers so the rest of the app doesn't hard-code the scheme.
  static String groupInviteUri(String code) => 'io.sippd://group/$code';
  static String tastingUri(String id) => 'io.sippd://tasting/$id';
  static String friendUri(String id) => 'io.sippd://friend/$id';
}
