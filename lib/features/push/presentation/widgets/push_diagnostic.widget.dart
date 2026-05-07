import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../controller/push.provider.dart';

/// Debug-only on-device push pipeline inspector. Surfaces every link
/// in the chain: notification permission → APNS handshake (iOS) →
/// FCM token → server-side row in `user_devices`. Lets the user
/// pinpoint which step is failing without needing Xcode console.
///
/// Wrap in `if (kDebugMode) const PushDiagnosticPanel()` from the
/// notification settings screen so it never ships to release.
class PushDiagnosticPanel extends ConsumerStatefulWidget {
  const PushDiagnosticPanel({super.key});

  @override
  ConsumerState<PushDiagnosticPanel> createState() =>
      _PushDiagnosticPanelState();
}

class _PushDiagnosticPanelState extends ConsumerState<PushDiagnosticPanel> {
  Future<_DiagnosticResult>? _check;
  bool _registering = false;
  String? _registerStatus;

  @override
  void initState() {
    super.initState();
    _check = _runCheck();
  }

  Future<_DiagnosticResult> _runCheck() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.getNotificationSettings();
    String? apns;
    if (!kIsWeb && Platform.isIOS) {
      try {
        apns = await messaging.getAPNSToken();
      } catch (e) {
        apns = '__error: $e';
      }
    }
    String? fcm;
    try {
      fcm = await messaging.getToken();
    } catch (e) {
      fcm = '__error: $e';
    }

    int serverRowCount = 0;
    String? serverRowPreview;
    String? serverError;
    try {
      final client = Supabase.instance.client;
      final uid = client.auth.currentUser?.id;
      if (uid == null) {
        serverError = 'no auth';
      } else {
        final rows = await client
            .from('user_devices')
            .select('token, platform, updated_at')
            .eq('user_id', uid);
        final list = rows as List;
        serverRowCount = list.length;
        if (list.isNotEmpty) {
          final tok = (list.first as Map<String, dynamic>)['token'] as String;
          serverRowPreview = tok.length > 12 ? tok.substring(0, 12) : tok;
        }
      }
    } catch (e) {
      serverError = e.toString();
    }

    return _DiagnosticResult(
      authorization: settings.authorizationStatus,
      alert: settings.alert,
      sound: settings.sound,
      apnsToken: apns,
      fcmToken: fcm,
      serverRowCount: serverRowCount,
      serverRowPreview: serverRowPreview,
      serverError: serverError,
    );
  }

  Future<void> _reregister() async {
    if (_registering) return;
    setState(() {
      _registering = true;
      _registerStatus = null;
    });
    try {
      final fcm = ref.read(fcmServiceProvider);
      // Make sure permission is requested at least once on iOS — if
      // the user dismissed the original prompt without acting, the
      // OS records that as denied and getToken silently fails.
      await fcm.requestPermission();
      await fcm.register();
      if (!mounted) return;
      setState(() {
        _registerStatus = 'Re-register triggered. Refresh below.';
        _check = _runCheck();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _registerStatus = 'Failed: $e');
    } finally {
      if (mounted) setState(() => _registering = false);
    }
  }

  void _refresh() {
    setState(() => _check = _runCheck());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bug_report_outlined, color: cs.primary, size: 20),
              SizedBox(width: context.w * 0.02),
              Text(
                'PUSH DIAGNOSTIC (debug only)',
                style: TextStyle(
                  fontSize: context.captionFont * 0.85,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Refresh',
                icon: const Icon(Icons.refresh, size: 20),
                onPressed: _refresh,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: context.s),
          FutureBuilder<_DiagnosticResult>(
            future: _check,
            builder: (_, snap) {
              if (!snap.hasData) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              final r = snap.data!;
              return _ResultBlock(result: r);
            },
          ),
          SizedBox(height: context.s),
          Row(
            children: [
              FilledButton.tonalIcon(
                onPressed: _registering ? null : _reregister,
                icon: const Icon(Icons.send, size: 16),
                label: Text(_registering ? 'Working…' : 'Re-register now'),
              ),
              SizedBox(width: context.w * 0.02),
              if (_registerStatus != null)
                Expanded(
                  child: Text(
                    _registerStatus!,
                    style: TextStyle(
                      fontSize: context.captionFont * 0.85,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: context.s),
          // Auth uid for cross-referencing with the live user_devices
          // query — saves a trip to the dashboard when debugging.
          Consumer(
            builder: (_, innerRef, _) {
              final uid = innerRef.watch(currentUserIdProvider) ?? '—';
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      'auth.uid: $uid',
                      style: TextStyle(
                        fontSize: context.captionFont * 0.8,
                        color: cs.outline,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Copy uid',
                    icon: const Icon(Icons.copy, size: 16),
                    onPressed: () =>
                        Clipboard.setData(ClipboardData(text: uid)),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ResultBlock extends StatelessWidget {
  const _ResultBlock({required this.result});
  final _DiagnosticResult result;

  @override
  Widget build(BuildContext context) {
    final isIos = !kIsWeb && Platform.isIOS;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Row(
          label: 'permission',
          status: switch (result.authorization) {
            AuthorizationStatus.authorized => _Status.ok,
            AuthorizationStatus.provisional => _Status.warn,
            AuthorizationStatus.notDetermined => _Status.warn,
            AuthorizationStatus.denied => _Status.bad,
          },
          value: result.authorization.name,
        ),
        if (isIos)
          _Row(
            label: 'APNS token',
            status: result.apnsToken == null
                ? _Status.bad
                : result.apnsToken!.startsWith('__error')
                ? _Status.bad
                : _Status.ok,
            value: result.apnsToken == null
                ? 'null — APNs handshake never landed'
                : result.apnsToken!.startsWith('__error')
                ? result.apnsToken!
                : 'present (len=${result.apnsToken!.length})',
          ),
        _Row(
          label: 'FCM token',
          status: result.fcmToken == null
              ? _Status.bad
              : result.fcmToken!.startsWith('__error')
              ? _Status.bad
              : _Status.ok,
          value: result.fcmToken == null
              ? 'null — Firebase did not mint a token'
              : result.fcmToken!.startsWith('__error')
              ? result.fcmToken!
              : '${result.fcmToken!.substring(0, 16)}… (len=${result.fcmToken!.length})',
        ),
        _Row(
          label: 'user_devices row',
          status: result.serverError != null
              ? _Status.bad
              : result.serverRowCount > 0
              ? _Status.ok
              : _Status.bad,
          value: result.serverError != null
              ? 'error: ${result.serverError}'
              : result.serverRowCount > 0
              ? '${result.serverRowCount} row(s) · '
                    '${result.serverRowPreview ?? '?'}…'
              : 'no row registered for this user',
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.status, required this.value});

  final String label;
  final _Status status;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = switch (status) {
      _Status.ok => Colors.green,
      _Status.warn => Colors.amber,
      _Status.bad => cs.error,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _Status { ok, warn, bad }

class _DiagnosticResult {
  const _DiagnosticResult({
    required this.authorization,
    required this.alert,
    required this.sound,
    required this.apnsToken,
    required this.fcmToken,
    required this.serverRowCount,
    required this.serverRowPreview,
    required this.serverError,
  });

  final AuthorizationStatus authorization;
  final AppleNotificationSetting alert;
  final AppleNotificationSetting sound;
  final String? apnsToken;
  final String? fcmToken;
  final int serverRowCount;
  final String? serverRowPreview;
  final String? serverError;
}
