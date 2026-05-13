import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../profile/controller/profile.provider.dart';
import '../../../../profile/presentation/widgets/language_picker.widget.dart';
import '../../../../profile/presentation/widgets/profile_avatar.widget.dart';
import '../../../../push/controller/push.provider.dart';
import '../../../../taste_match/presentation/widgets/wine_personality_hero.widget.dart';
import '../../../../wines/controller/wine.provider.dart';
import '../../../controller/auth.provider.dart';
import '../email_confirmation/email_confirmation.screen.dart';

const _privacyUrl = 'https://sippd.xyz/privacy';
const _termsUrl = 'https://sippd.xyz/terms';
const _supportEmail = 'support@sippd.xyz';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authControllerProvider);
    final cs = Theme.of(context).colorScheme;
    final user = authState.valueOrNull;
    final profile = ref.watch(currentProfileProvider).valueOrNull;

    final headlineName =
        profile?.username ??
        profile?.displayName ??
        user?.userMetadata?['display_name'] as String? ??
        user?.email?.split('@').first ??
        l10n.authProfileGuest;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          children: [
            SizedBox(height: context.xl * 1.5),

            // Avatar + info
            Center(
              child: Column(
                children: [
                  user != null
                      ? ProfileAvatar(
                          avatarUrl: profile?.avatarUrl,
                          fallbackText: headlineName,
                          iconKey: profile?.tasteEmoji,
                          size: context.w * 0.26,
                          showRing: true,
                          showEditBadge: true,
                          onTap: () => context.push(AppRoutes.profileEdit),
                        )
                      : Container(
                          width: context.w * 0.26,
                          height: context.w * 0.26,
                          decoration: BoxDecoration(
                            color: cs.primaryContainer,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: cs.primary.withValues(alpha: 0.45),
                              width: context.w * 0.26 * 0.025,
                            ),
                          ),
                          child: Icon(
                            PhosphorIconsRegular.user,
                            size: context.w * 0.1,
                            color: cs.primary,
                          ),
                        ),
                  SizedBox(height: context.m),
                  Text(
                    profile?.username != null ? '@$headlineName' : headlineName,
                    style: TextStyle(
                      fontSize: context.headingFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.l),

            // Identity zone — wine personality + traits.
            // Numerical stats live on the dedicated stats screen.
            if (user != null) ...[
              WinePersonalityHero(userId: user.id, showShareCta: true),
              SizedBox(height: context.s),
              _ViewStatsLink(),
              SizedBox(height: context.l),
            ],

            // ACCOUNT
            if (user != null) ...[
              _SectionLabel(l10n.authProfileSectionAccount),
              _MenuItem(
                icon: PhosphorIconsRegular.pencilSimple,
                label: l10n.authProfileEditProfile,
                onTap: () => context.push(AppRoutes.profileEdit),
              ),
              _MenuItem(
                icon: PhosphorIconsRegular.users,
                label: l10n.authProfileFriends,
                onTap: () => context.push(AppRoutes.friends),
              ),
              _MenuItem(
                icon: PhosphorIconsRegular.bell,
                label: l10n.authProfileNotifications,
                onTap: () => context.push(AppRoutes.profileNotifications),
              ),
              _MenuItem(
                icon: PhosphorIconsRegular.translate,
                label: l10n.profileTileLanguageLabel,
                onTap: () => showLanguagePickerSheet(context),
              ),
              _MenuItem(
                icon: PhosphorIconsRegular.stack,
                label: l10n.authProfileCleanupDuplicates,
                onTap: () => context.push(AppRoutes.wineCleanup),
              ),
              _MenuItem(
                icon: PhosphorIconsRegular.sparkle,
                label: l10n.authProfileSubscription,
                onTap: () => context.push(AppRoutes.subscription),
              ),
              if (_isEmailUser(user))
                _MenuItem(
                  icon: PhosphorIconsRegular.lockKey,
                  label: l10n.authProfileChangePassword,
                  onTap: () => _changePassword(context, ref, user.email!),
                ),
              SizedBox(height: context.l),
            ],

            // SUPPORT
            _SectionLabel(l10n.authProfileSectionSupport),
            _MenuItem(
              icon: PhosphorIconsRegular.envelope,
              label: l10n.authProfileContactUs,
              onTap: () => _launch(
                context,
                'mailto:$_supportEmail?subject=Sippd%20Support',
              ),
            ),
            _MenuItem(
              icon: PhosphorIconsRegular.star,
              label: l10n.authProfileRateSippd,
              onTap: () => _launch(context, 'https://apps.apple.com/app/sippd'),
            ),
            SizedBox(height: context.l),

            // LEGAL
            _SectionLabel(l10n.authProfileSectionLegal),
            _MenuItem(
              icon: PhosphorIconsRegular.shieldCheck,
              label: l10n.authProfilePrivacyPolicy,
              onTap: () => _launch(context, _privacyUrl),
            ),
            _MenuItem(
              icon: PhosphorIconsRegular.fileText,
              label: l10n.authProfileTermsOfService,
              onTap: () => _launch(context, _termsUrl),
            ),
            SizedBox(height: context.xl),

            // DANGER ZONE / auth actions
            if (user != null) ...[
              _DangerButton(
                icon: PhosphorIconsRegular.signOut,
                label: l10n.authProfileSignOut,
                onTap: () async {
                  // Drop this device's FCM registration before the session
                  // dies — otherwise pushes for this account continue to land
                  // on a logged-out device.
                  try {
                    await ref
                        .read(fcmServiceProvider)
                        .unregisterCurrentDevice();
                  } catch (_) {
                    /* best-effort */
                  }
                  // Wipe cached wine/memory data so the next account on this
                  // device can't briefly see the previous user's rows.
                  try {
                    await ref.read(appDatabaseProvider).clearAll();
                  } catch (_) {
                    /* best-effort */
                  }
                  await ref.read(authControllerProvider.notifier).signOut();
                  if (context.mounted) context.go(AppRoutes.login);
                },
              ),
              SizedBox(height: context.m),
              Center(
                child: TextButton(
                  onPressed: () => _confirmDelete(context, ref),
                  child: Text(
                    l10n.authProfileDeleteAccount,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      fontWeight: FontWeight.w500,
                      color: cs.error.withValues(alpha: 0.7),
                      decoration: TextDecoration.underline,
                      decorationColor: cs.error.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
            ] else
              _MenuItem(
                icon: PhosphorIconsRegular.signIn,
                label: l10n.authProfileSignIn,
                onTap: () => context.go(AppRoutes.login),
              ),

            SizedBox(height: context.l),
          ],
        ),
      ),
    );
  }
}

bool _isEmailUser(User user) {
  if (user.email == null) return false;
  final identities = user.identities;
  if (identities == null || identities.isEmpty) return true;
  return identities.any((i) => i.provider == 'email');
}

Future<void> _changePassword(
  BuildContext context,
  WidgetRef ref,
  String email,
) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.authProfileChangePasswordDialogTitle),
      content: Text(l10n.authProfileChangePasswordDialogBody(email)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(l10n.authProfileCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(l10n.authProfileSendLink),
        ),
      ],
    ),
  );
  if (confirmed != true) return;

  try {
    await ref.read(authControllerProvider.notifier).resetPassword(email);
    if (!context.mounted) return;
    context.push(
      AppRoutes.emailConfirmation,
      extra: {
        'email': email,
        'purpose': EmailConfirmationPurpose.resetPassword,
      },
    );
  } catch (e) {
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.authProfileSendLinkFailedTitle),
        content: Text(
          describeAppError(e, fallback: l10n.authProfileSendLinkFailedFallback),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.authProfileOk),
          ),
        ],
      ),
    );
  }
}

Future<void> _launch(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context).authProfileCouldNotOpen(url),
        ),
      ),
    );
  }
}

Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => const _ConfirmDeleteDialog(),
  );
  if (confirmed != true) return;

  try {
    await ref.read(profileControllerProvider.notifier).deleteAccount();
    // Router auto-redirects to /login on auth state change; no manual go().
  } catch (e) {
    if (context.mounted) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            describeAppError(e, fallback: l10n.authProfileDeleteFailedFallback),
          ),
        ),
      );
    }
  }
}

class _ConfirmDeleteDialog extends StatefulWidget {
  const _ConfirmDeleteDialog();

  @override
  State<_ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<_ConfirmDeleteDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final canDelete = _controller.text.trim() == 'DELETE';
    return AlertDialog(
      title: Text(l10n.authProfileDeleteDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.authProfileDeleteDialogBody),
          SizedBox(height: context.m),
          Text(l10n.authProfileDeleteTypeConfirm),
          SizedBox(height: context.s),
          TextField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            maxLength: 10,
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: l10n.authProfileDeleteHint,
              counterText: '',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.authProfileCancel),
        ),
        TextButton(
          onPressed: canDelete ? () => Navigator.pop(context, true) : null,
          style: TextButton.styleFrom(foregroundColor: cs.error),
          child: Text(l10n.authProfileDelete),
        ),
      ],
    );
  }
}

class _ViewStatsLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(AppRoutes.wineStats),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.s),
        child: Row(
          children: [
            Text(
              l10n.authProfileViewFullStats,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
            SizedBox(width: context.w * 0.015),
            Icon(
              PhosphorIconsRegular.arrowRight,
              size: context.bodyFont * 0.95,
              color: cs.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02, bottom: context.s),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: context.captionFont * 0.85,
          fontWeight: FontWeight.w600,
          color: cs.onSurfaceVariant,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.m,
          horizontal: context.w * 0.04,
        ),
        margin: EdgeInsets.only(bottom: context.xs),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Icon(icon, color: cs.primary, size: context.w * 0.05),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
              ),
            ),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: context.w * 0.05,
              color: cs.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _DangerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DangerButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fg = cs.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.m,
          horizontal: context.w * 0.04,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(color: cs.outlineVariant, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: fg, size: context.w * 0.05),
            SizedBox(width: context.w * 0.025),
            Text(
              label,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
