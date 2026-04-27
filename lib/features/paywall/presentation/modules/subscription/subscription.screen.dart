import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/paywall.provider.dart';
import '../../../data/services/paywall.service.dart';

/// Already-Pro and free-plan management surface. Mirrors the iOS Settings
/// → Subscriptions pattern: a status card, deep link to the store-native
/// management page, restore, and a plain-text "how to cancel" so the exit
/// is symmetric with the entry.
class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final infoAsync = ref.watch(customerInfoStreamProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Subscription',
          style: TextStyle(
            fontSize: context.bodyFont * 1.05,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: infoAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(
            child: Padding(
              padding: EdgeInsets.all(context.paddingH),
              child: Text(
                'Could not load subscription info.',
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
            ),
          ),
          data: (info) => _SubscriptionContent(info: info),
        ),
      ),
    );
  }
}

class _SubscriptionContent extends ConsumerWidget {
  const _SubscriptionContent({required this.info});

  final CustomerInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entitlement = info.entitlements.active[proEntitlementId];
    final isPro = entitlement != null;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      children: [
        SizedBox(height: context.m),
        if (isPro)
          _ProStatusCard(entitlement: entitlement)
        else
          const _FreePlanCard(),
        SizedBox(height: context.l),
        if (isPro) ...[
          _MenuTile(
            icon: PhosphorIconsRegular.arrowSquareOut,
            label: 'Manage subscription',
            subtitle: 'Opens in the App Store or Play Store',
            onTap: () => _openManagement(context, info),
          ),
          _MenuTile(
            icon: PhosphorIconsRegular.clockCounterClockwise,
            label: 'Restore purchases',
            onTap: () => _restore(context, ref),
          ),
          _MenuTile(
            icon: PhosphorIconsRegular.question,
            label: 'How to cancel',
            onTap: () => _showCancelHelp(context),
          ),
        ] else ...[
          SizedBox(
            width: double.infinity,
            height: context.h * 0.06,
            child: FilledButton(
              onPressed: () => context.push(
                AppRoutes.paywall,
                extra: const {'source': 'subscription_screen'},
              ),
              style: FilledButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                ),
              ),
              child: Text(
                'See Pro plans',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: context.m),
          _MenuTile(
            icon: PhosphorIconsRegular.clockCounterClockwise,
            label: 'Restore purchases',
            onTap: () => _restore(context, ref),
          ),
        ],
        SizedBox(height: context.xl),
        const _Disclosure(),
        SizedBox(height: context.l),
      ],
    );
  }
}

class _ProStatusCard extends StatelessWidget {
  const _ProStatusCard({required this.entitlement});

  final EntitlementInfo entitlement;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final renewalLine = _renewalLine(entitlement);
    final inTrial = entitlement.periodType == PeriodType.trial;

    return Container(
      padding: EdgeInsets.all(context.w * 0.05),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIconsRegular.sparkle,
                color: cs.primary,
                size: context.w * 0.06,
              ),
              SizedBox(width: context.w * 0.025),
              Text(
                'Sippd Pro',
                style: TextStyle(
                  fontSize: context.bodyFont * 1.1,
                  fontWeight: FontWeight.w800,
                  color: cs.onPrimaryContainer,
                  letterSpacing: -0.3,
                ),
              ),
              if (inTrial) ...[
                SizedBox(width: context.w * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w * 0.02,
                    vertical: context.w * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(context.w * 0.04),
                  ),
                  child: Text(
                    'TRIAL',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.8,
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: context.s),
          Text(
            renewalLine,
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              color: cs.onPrimaryContainer.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  String _renewalLine(EntitlementInfo e) {
    if (e.willRenew == false && e.expirationDate != null) {
      final date = DateTime.tryParse(e.expirationDate!);
      if (date != null) return 'Ends ${_fmt(date)} — won\'t renew.';
    }
    if (e.expirationDate == null) {
      return 'Lifetime access — yours forever.';
    }
    final date = DateTime.tryParse(e.expirationDate!);
    if (date == null) return 'Active.';
    final verb = e.periodType == PeriodType.trial ? 'Trial ends' : 'Renews';
    return '$verb ${_fmt(date)}.';
  }

  String _fmt(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

class _FreePlanCard extends StatelessWidget {
  const _FreePlanCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.w * 0.05),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'On the Free plan',
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            'Upgrade to unlock unlimited groups, deep stats and more.',
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: context.w * 0.04,
              color: cs.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _Disclosure extends StatelessWidget {
  const _Disclosure();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w * 0.05),
        child: Text(
          'Subscriptions are billed by Apple or Google. '
          'Manage there to cancel.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.captionFont * 0.9,
            color: cs.outline,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

Future<void> _openManagement(BuildContext context, CustomerInfo info) async {
  final url = info.managementURL;
  final fallback = Theme.of(context).platform == TargetPlatform.iOS
      ? 'https://apps.apple.com/account/subscriptions'
      : 'https://play.google.com/store/account/subscriptions';
  final target = url ?? fallback;
  final uri = Uri.parse(target);
  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open subscription settings.')),
    );
  }
}

Future<void> _restore(BuildContext context, WidgetRef ref) async {
  ref
      .read(analyticsProvider)
      .capture(
        'paywall_restore_tap',
        properties: const {'source': 'subscription_screen'},
      );
  try {
    final info = await ref.read(paywallProvider).restore();
    if (!context.mounted) return;
    final restored = info.entitlements.active.containsKey(proEntitlementId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          restored
              ? 'Welcome back to Sippd Pro!'
              : 'No active subscription found.',
        ),
      ),
    );
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not restore purchases.')),
    );
  }
}

void _showCancelHelp(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  final isIos = Theme.of(context).platform == TargetPlatform.iOS;
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: cs.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.l,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How to cancel',
              style: TextStyle(
                fontSize: context.bodyFont * 1.15,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.m),
            Text(
              isIos
                  ? '1. Tap "Manage subscription" above.\n'
                        '2. The App Store opens with your subscriptions list.\n'
                        '3. Tap Sippd Pro, then "Cancel Subscription".'
                  : '1. Tap "Manage subscription" above.\n'
                        '2. Google Play opens with your subscriptions list.\n'
                        '3. Tap Sippd Pro, then "Cancel subscription".',
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                color: cs.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            SizedBox(height: context.l),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'Close',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
