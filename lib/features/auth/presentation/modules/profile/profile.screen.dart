import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../profile/controller/profile.provider.dart';
import '../../../../profile/presentation/widgets/profile_avatar.widget.dart';
import '../../../../wines/controller/wine.provider.dart';
import '../../../controller/auth.provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final cs = Theme.of(context).colorScheme;
    final user = authState.valueOrNull;
    final profile = ref.watch(currentProfileProvider).valueOrNull;
    final winesAsync = ref.watch(wineControllerProvider);

    final headlineName = profile?.username ??
        profile?.displayName ??
        user?.userMetadata?['display_name'] as String? ??
        user?.email?.split('@').first ??
        'Guest';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          children: [
            SizedBox(height: context.m),
            Text('Profile',
                style: TextStyle(
                    fontSize: context.titleFont,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5)),
            SizedBox(height: context.l),

            // Avatar + info
            Center(
              child: Column(
                children: [
                  user != null
                      ? ProfileAvatar(
                          avatarUrl: profile?.avatarUrl,
                          fallbackText: headlineName,
                          size: context.w * 0.22,
                        )
                      : Container(
                          width: context.w * 0.22,
                          height: context.w * 0.22,
                          decoration: BoxDecoration(
                            color: cs.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.person,
                              size: context.w * 0.1, color: cs.primary),
                        ),
                  SizedBox(height: context.m),
                  Text(
                    profile?.username != null
                        ? '@$headlineName'
                        : headlineName,
                    style: TextStyle(
                        fontSize: context.headingFont,
                        fontWeight: FontWeight.bold),
                  ),
                  if (user?.email != null) ...[
                    SizedBox(height: context.xs),
                    Text(user!.email!,
                        style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant)),
                  ],
                ],
              ),
            ),
            SizedBox(height: context.l),

            // Stats
            winesAsync.when(
              data: (wines) => Row(
                children: [
                  Expanded(
                      child: _StatCard(
                          label: 'Wines', value: wines.length.toString())),
                  SizedBox(width: context.w * 0.03),
                  Expanded(
                      child: _StatCard(
                          label: 'Avg Rating',
                          value: wines.isEmpty
                              ? '-'
                              : (wines
                                          .map((w) => w.rating)
                                          .reduce((a, b) => a + b) /
                                      wines.length)
                                  .toStringAsFixed(1))),
                  SizedBox(width: context.w * 0.03),
                  Expanded(
                      child: _StatCard(
                          label: 'Countries',
                          value: wines
                              .where((w) => w.country != null)
                              .map((w) => w.country)
                              .toSet()
                              .length
                              .toString())),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            SizedBox(height: context.xl),

            // Menu items
            if (user != null)
              _MenuItem(
                icon: Icons.edit_outlined,
                label: 'Edit profile',
                onTap: () => context.push(AppRoutes.profileEdit),
              ),
            _MenuItem(
              icon: Icons.people_outline,
              label: 'Friends',
              onTap: () => context.push(AppRoutes.friends),
            ),
            SizedBox(height: context.l),
            Divider(color: cs.outlineVariant, height: 1),
            SizedBox(height: context.l),

            // Sign in/out
            if (user != null)
              _MenuItem(
                icon: Icons.logout,
                label: 'Sign Out',
                isDestructive: true,
                onTap: () async {
                  await ref.read(authControllerProvider.notifier).signOut();
                  if (context.mounted) context.go(AppRoutes.login);
                },
              )
            else
              _MenuItem(
                icon: Icons.login,
                label: 'Sign In',
                onTap: () => context.go(AppRoutes.login),
              ),

            SizedBox(height: context.xl),

            // App info
            Center(
              child: Text(
                'Sippd v1.0.0',
                style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    color: cs.outline),
              ),
            ),
            SizedBox(height: context.l),
          ],
        ),
      ),
    );
  }

}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: context.m, horizontal: context.w * 0.02),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: context.headingFont,
                  fontWeight: FontWeight.bold,
                  color: cs.primary)),
          SizedBox(height: context.xs),
          Text(label,
              style: TextStyle(
                  fontSize: context.captionFont * 0.85,
                  color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = isDestructive ? cs.error : cs.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: context.m, horizontal: context.w * 0.04),
        margin: EdgeInsets.only(bottom: context.xs),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? cs.error : cs.primary,
                size: context.w * 0.05),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w500,
                      color: color)),
            ),
            Icon(Icons.chevron_right,
                size: context.w * 0.05, color: cs.outline),
          ],
        ),
      ),
    );
  }
}
