// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inAppReviewHash() => r'e4a81de941378fc21b9690e55d12aad3923b492c';

/// See also [inAppReview].
@ProviderFor(inAppReview)
final inAppReviewProvider = AutoDisposeProvider<InAppReview>.internal(
  inAppReview,
  name: r'inAppReviewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inAppReviewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InAppReviewRef = AutoDisposeProviderRef<InAppReview>;
String _$reviewPromptControllerHash() =>
    r'd58293d3a1106e72ce6dba5848941f2db0049c9f';

/// Owns the "ask for a store review" lifecycle: a SharedPreferences-gated
/// soft ask (custom overlay) that, on a positive response, hands off to the
/// native StoreKit / Play in-app review sheet.
///
/// Copied from [ReviewPromptController].
@ProviderFor(ReviewPromptController)
final reviewPromptControllerProvider =
    AutoDisposeNotifierProvider<ReviewPromptController, void>.internal(
      ReviewPromptController.new,
      name: r'reviewPromptControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$reviewPromptControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReviewPromptController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
