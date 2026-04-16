import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/friend_profile.entity.dart';

class FriendAvatar extends StatelessWidget {
  final FriendProfileEntity profile;
  final double size;

  const FriendAvatar({
    super.key,
    required this.profile,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = profile.avatarUrl;

    if (avatar != null && avatar.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatar,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (_, __) => _initialsFallback(context, size),
          errorWidget: (_, __, ___) => _initialsFallback(context, size),
        ),
      );
    }
    return _initialsFallback(context, size);
  }

  Widget _initialsFallback(BuildContext context, double size) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _initials(),
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
      ),
    );
  }

  String _initials() {
    final name = profile.displayName ?? profile.username ?? '?';
    if (name.length < 2) return name.toUpperCase();
    return name.substring(0, 2).toUpperCase();
  }
}
