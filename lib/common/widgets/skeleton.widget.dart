import 'package:flutter/material.dart';

/// Identity wrapper kept as a single hook in case we ever want to apply
/// a shared visual treatment to a group of [SkeletonBox]es. Static —
/// no animation, so it reads as "no data" not "loading". Color muting
/// lives in [SkeletonBox] via `surfaceContainerHighest`; an extra
/// Opacity here would push naked-bg placeholders into invisibility.
class Skeleton extends StatelessWidget {
  final Widget child;
  const Skeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}

/// Leaf placeholder rectangle used inside a [Skeleton] to mock the size
/// and shape of a real piece of content.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final double? radius;
  final BoxShape shape;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.radius,
    this.shape = BoxShape.rectangle,
  });

  const SkeletonBox.circle({super.key, required double size})
    : width = size,
      height = size,
      radius = null,
      shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        shape: shape,
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(radius ?? 6),
      ),
    );
  }
}
