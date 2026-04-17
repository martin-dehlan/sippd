import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String fallbackText;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.avatarUrl,
    required this.fallbackText,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        shape: BoxShape.circle,
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
