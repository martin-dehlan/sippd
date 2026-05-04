import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../errors/app_error.dart';

part 'connectivity.provider.g.dart';

/// Default ceiling on any network call we explicitly time-bound. Long
/// enough for slow mobile, short enough to surface an error before the
/// user gives up. Use via [FutureNetTimeout.withNetTimeout].
const Duration kNetTimeout = Duration(seconds: 8);

/// Live device connectivity stream resolved on first build via
/// `checkConnectivity` so the very first frame already has the right
/// value — no optimistic "true" race window where a screen could fire
/// a Supabase call we'd otherwise short-circuit.
///
/// Most callers want [isOnlineProvider] (sync bool); use this provider
/// directly only when you need the AsyncValue.
///
/// This signal only sees the radio: a captive portal or DNS-poisoned
/// WiFi will read as online. The 8s [kNetTimeout] catches the rest.
@Riverpod(keepAlive: true)
class ConnectivityState extends _$ConnectivityState {
  StreamSubscription<List<ConnectivityResult>>? _sub;

  @override
  Future<bool> build() async {
    final conn = Connectivity();
    _sub = conn.onConnectivityChanged.listen((r) {
      state = AsyncData(_hasInterface(r));
    });
    ref.onDispose(() => _sub?.cancel());
    final initial = await conn.checkConnectivity();
    return _hasInterface(initial);
  }

  bool _hasInterface(List<ConnectivityResult> results) {
    if (results.isEmpty) return false;
    return results.any((r) => r != ConnectivityResult.none);
  }
}

/// Synchronous accessor for the common case. Returns `false` while the
/// first probe resolves — we'd rather show offline UI for one frame
/// than fire a doomed request. Watch this in widgets and providers
/// instead of [connectivityStateProvider] directly when you don't
/// need the AsyncValue.
@riverpod
bool isOnline(IsOnlineRef ref) {
  return ref.watch(connectivityStateProvider).valueOrNull ?? false;
}

extension RefNetwork on Ref {
  /// Throws [AppError.offline] when the device has no network. Use at
  /// the top of any provider that *must* hit the network. Watches the
  /// provider so the caller auto-rebuilds when connectivity returns.
  void requireOnline() {
    if (!watch(isOnlineProvider)) throw const AppError.offline();
  }
}

extension FutureNetTimeout<T> on Future<T> {
  /// Wraps the future with [kNetTimeout] (or [duration]). Use on every
  /// remote call so a stalled token refresh / captive portal can't
  /// strand the UI on a spinner.
  Future<T> withNetTimeout([Duration? duration]) =>
      timeout(duration ?? kNetTimeout);
}
