import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String fallbackText;
  final double size;
  final bool showEditBadge;
  final bool showRing;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    required this.avatarUrl,
    required this.fallbackText,
    required this.size,
    this.showEditBadge = false,
    this.showRing = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ringWidth = size * 0.025;
    final badgeSize = size * 0.28;

    final avatar = Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        shape: BoxShape.circle,
        border: showRing
            ? Border.all(
                color: cs.primary.withValues(alpha: 0.45),
                width: ringWidth,
              )
            : null,
      ),
      child: avatarUrl != null && avatarUrl!.isNotEmpty
          ? Image.network(
              avatarUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _Initials(
                text: fallbackText,
                size: size,
              ),
            )
          : _Initials(text: fallbackText, size: size),
    );

    final content = showEditBadge
        ? SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                avatar,
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: badgeSize,
                    height: badgeSize,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: cs.surface,
                        width: ringWidth,
                      ),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: badgeSize * 0.5,
                      color: cs.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          )
        : avatar;

    if (onTap == null) return content;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}

class _Initials extends StatelessWidget {
  final String text;
  final double size;

  const _Initials({required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final clean = text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    final initials = clean.length < 2
        ? clean.toUpperCase()
        : clean.substring(0, 2).toUpperCase();

    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.38,
          fontWeight: FontWeight.bold,
          color: cs.primary,
        ),
      ),
    );
  }
}
