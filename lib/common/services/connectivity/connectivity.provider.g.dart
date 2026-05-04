// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isOnlineHash() => r'4dba3cd611abffd329580d087dce9b5fd9facc4d';

/// Synchronous accessor for the common case. Defaults to `true` while
/// the first probe resolves — iOS simulator's connectivity_plus
/// occasionally reports `none` despite an active WiFi connection,
/// which used to strand the user on an offline error screen on cold
/// start. The 8s [kNetTimeout] surfaces real offline cases via the
/// individual network call, so an optimistic default is safer than
/// trusting the radio probe alone.
///
/// Copied from [isOnline].
@ProviderFor(isOnline)
final isOnlineProvider = AutoDisposeProvider<bool>.internal(
  isOnline,
  name: r'isOnlineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isOnlineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsOnlineRef = AutoDisposeProviderRef<bool>;
String _$connectivityStateHash() => r'70ae3027b3547bb64419a6c293143f8342f63e2f';

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
///
/// Copied from [ConnectivityState].
@ProviderFor(ConnectivityState)
final connectivityStateProvider =
    AsyncNotifierProvider<ConnectivityState, bool>.internal(
      ConnectivityState.new,
      name: r'connectivityStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ConnectivityState = AsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
