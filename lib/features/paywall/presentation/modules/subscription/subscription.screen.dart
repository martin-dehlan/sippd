import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/paywall.provider.dart';
import '../../../data/services/paywall.service.dart';
import '../../widgets/paywall_body.widget.dart';
import '../../widgets/paywall_pitch.dart';

/// Already-Pro and free-plan management surface. Mirrors the iOS Settings
/// → Subscriptions pattern: a status hero, a benefits recap, and a grouped
/// list of management actions that deep-link to the store-native cancel
/// page (no in-app cancel button — Apple/Google require billing changes
/// to happen in their own UI).
class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Force a fresh fetch on mount: cached entitlement state is often
    // stale after the user cancels or after a sub expires (the SDK's
    // update listener doesn't always fire for expiry).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paywallProvider).refresh();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Returning from Play Store cancel/manage flow → entitlement may
    // have changed server-side. Force a refresh so the UI reflects it.
    if (state == AppLifecycleState.resumed) {
      ref.read(paywallProvider).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final info = ref.watch(currentCustomerInfoProvider);
    final isPro = ref.watch(isProProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            isPro ? PhosphorIconsRegular.arrowLeft : PhosphorIconsRegular.x,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Pro users see this as a management screen → title makes sense.
        // Free users see the paywall pitch directly → title would compete
        // with the hero + Playfair headline below, so drop it.
        title: isPro
            ? Text(
                'Subscription',
                style: TextStyle(
                  fontSize: context.bodyFont * 1.05,
                  fontWeight: FontWeight.w700,
                ),
              )
            : null,
      ),
      body: SafeArea(
        top: false,
        child: _SubscriptionContent(info: info),
      ),
    );
  }
}

class _SubscriptionContent extends ConsumerWidget {
  const _SubscriptionContent({required this.info});

  final CustomerInfo? info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProProvider);
    final entitlement = info?.entitlements.active[proEntitlementId];

    if (isPro) {
      return _ProManagementContent(info: info, entitlement: entitlement);
    }
    return const _FreeUpsellContent();
  }
}

/// Free-tier view: render the same animated paywall body the standalone
/// /paywall route uses, embedded directly so the user can subscribe in
/// place. CustomerInfo updates via stream → screen rebuilds into the
/// management view automatically on success, no manual nav needed.
class _FreeUpsellContent extends StatelessWidget {
  const _FreeUpsellContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        context.paddingH,
        0,
        context.paddingH,
        context.l,
      ),
      child: const PaywallBody(
        triggerSource: 'subscription_screen',
        showHero: true,
        eyebrow: kProPitchEyebrow,
        headline: kProPitchHeadline,
        subhead: kProPitchSubhead,
        benefits: kProPitchBenefits,
        primaryLabel: 'Continue',
      ),
    );
  }
}

/// Pro-tier view. `entitlement` is null when isPro is forced via the
/// FORCE_PRO test flag — the screen renders a "test mode" status and
/// hides the rows that don't apply (change/cancel plan).
class _ProManagementContent extends ConsumerWidget {
  const _ProManagementContent({required this.info, required this.entitlement});

  final CustomerInfo? info;
  final EntitlementInfo? entitlement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLifetime = entitlement != null && _isLifetimeProduct(entitlement!);
    final isTestMode = entitlement == null;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        context.paddingH,
        context.s,
        context.paddingH,
        context.l,
      ),
      children: [
        _StatusCard(entitlement: entitlement),
        SizedBox(height: context.l),
        const _Section(
          title: 'Included in Pro',
          children: [_BenefitsBlock()],
        ),
        SizedBox(height: context.l),
        _Section(
          title: 'Manage',
          children: [
            if (!isLifetime && !isTestMode)
              _SectionRow(
                label: 'Change plan',
                trailing: _TrailingIcon(PhosphorIconsRegular.arrowSquareOut),
                onTap: () => _openManagement(context, info),
              ),
            _SectionRow(
              label: 'Restore purchases',
              trailing: _TrailingIcon(
                PhosphorIconsRegular.clockCounterClockwise,
              ),
              onTap: () => _restore(context, ref),
            ),
            if (!isLifetime && !isTestMode)
              _SectionRow(
                label: 'Cancel subscription',
                destructive: true,
                trailing: _TrailingIcon(PhosphorIconsRegular.arrowSquareOut),
                onTap: () => _openManagement(context, info),
              ),
          ],
        ),
        SizedBox(height: context.xl),
        const _Disclosure(),
      ],
    );
  }
}

/// Hero status card. Adapts the chip + status line to the four real
/// states (active, trial, ending, lifetime) and the synthetic
/// "test mode" state used when isPro is forced via env-define.
class _StatusCard extends ConsumerWidget {
  const _StatusCard({required this.entitlement});

  final EntitlementInfo? entitlement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final state = _resolveState(entitlement);
    final planName = _planNameFor(entitlement);
    final price = _priceFor(ref, entitlement);
    final billedVia = _billedViaFor(entitlement);

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
                size: context.w * 0.055,
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
              const Spacer(),
              _StatusChip(state: state),
            ],
          ),
          SizedBox(height: context.m),
          Text(
            planName,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w700,
              color: cs.onPrimaryContainer,
            ),
          ),
          if (price != null) ...[
            SizedBox(height: context.xs * 0.6),
            Text(
              price,
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                color: cs.onPrimaryContainer.withValues(alpha: 0.85),
              ),
            ),
          ],
          SizedBox(height: context.m),
          Container(
            height: 1,
            color: cs.onPrimaryContainer.withValues(alpha: 0.12),
          ),
          SizedBox(height: context.m),
          _StatusLine(text: _statusLineFor(state, entitlement)),
          if (billedVia != null) ...[
            SizedBox(height: context.xs),
            _StatusLine(text: 'Billed via $billedVia'),
          ],
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.state});

  final _SubState state;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (label, fg, bg) = switch (state) {
      _SubState.active => ('ACTIVE', cs.onPrimary, cs.primary),
      _SubState.trial => ('TRIAL', cs.onPrimary, cs.primary),
      _SubState.ending => (
        'ENDING',
        cs.onErrorContainer,
        cs.errorContainer,
      ),
      _SubState.lifetime => ('LIFETIME', cs.onPrimary, cs.primary),
      _SubState.test => ('TEST MODE', cs.onSurface, cs.surfaceContainer),
    };
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.025,
        vertical: context.w * 0.008,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.captionFont * 0.78,
          color: fg,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: context.bodyFont * 0.93,
        color: cs.onPrimaryContainer.withValues(alpha: 0.85),
        height: 1.4,
      ),
    );
  }
}

/// Section header + grouped container. Header is small-caps / letter-spaced
/// to match iOS Settings rhythm; container holds rows separated by
/// indented hairline dividers.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final visible = children.whereType<Widget>().toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.w * 0.04,
            bottom: context.s,
          ),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainer,
            borderRadius: BorderRadius.circular(context.w * 0.04),
          ),
          child: Column(
            children: [
              for (var i = 0; i < visible.length; i++) ...[
                if (i > 0)
                  Padding(
                    padding: EdgeInsets.only(left: context.w * 0.14),
                    child: Container(
                      height: 1,
                      color: cs.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                visible[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({
    required this.label,
    this.trailing,
    this.destructive = false,
    required this.onTap,
  });

  final String label;
  final Widget? trailing;
  final bool destructive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fg = destructive ? cs.error : cs.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.m,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

class _TrailingIcon extends StatelessWidget {
  const _TrailingIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Icon(icon, size: context.w * 0.045, color: cs.outline);
  }
}

/// Reuses the canonical Pro pitch benefits as informational rows so the
/// management view echoes what the user paid for, without a separate
/// copy that could drift from the paywall.
class _BenefitsBlock extends StatelessWidget {
  const _BenefitsBlock();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (var i = 0; i < kProPitchBenefits.length; i++) ...[
          if (i > 0)
            Padding(
              padding: EdgeInsets.only(left: context.w * 0.14),
              child: Container(
                height: 1,
                color: cs.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.04,
              vertical: context.m,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  kProPitchBenefits[i].icon,
                  size: context.w * 0.05,
                  color: cs.primary,
                ),
                SizedBox(width: context.w * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kProPitchBenefits[i].title,
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                      if (kProPitchBenefits[i].subtitle != null) ...[
                        SizedBox(height: context.xs * 0.4),
                        Text(
                          kProPitchBenefits[i].subtitle!,
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
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
          'Manage them in store settings.',
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

// ─── State derivation ─────────────────────────────────────────────────────

enum _SubState { active, trial, ending, lifetime, test }

/// True when the entitlement is backed by a one-time lifetime product.
/// Subscriptions can transiently report null expirationDate during cache
/// races or partial sandbox states, so we gate on productIdentifier
/// instead of just the date being null.
bool _isLifetimeProduct(EntitlementInfo e) =>
    e.productIdentifier.toLowerCase().contains('lifetime');

_SubState _resolveState(EntitlementInfo? e) {
  if (e == null) return _SubState.test;
  if (_isLifetimeProduct(e)) return _SubState.lifetime;
  if (e.willRenew == false) return _SubState.ending;
  if (e.periodType == PeriodType.trial) return _SubState.trial;
  return _SubState.active;
}

String _planNameFor(EntitlementInfo? e) {
  if (e == null) return 'Test mode';
  if (_isLifetimeProduct(e)) return 'Lifetime';
  final id = e.productIdentifier.toLowerCase();
  if (id.contains('year') || id.contains('annual')) return 'Annual';
  if (id.contains('month')) return 'Monthly';
  if (id.contains('week')) return 'Weekly';
  return 'Pro plan';
}

String? _priceFor(WidgetRef ref, EntitlementInfo? e) {
  if (e == null) return null;
  return _priceFromOfferings(ref, e.productIdentifier);
}

String? _priceFromOfferings(WidgetRef ref, String productId) {
  final offerings = ref.watch(paywallOfferingsProvider).valueOrNull;
  final packages = offerings?.current?.availablePackages ?? const <Package>[];
  for (final pkg in packages) {
    if (pkg.storeProduct.identifier == productId) {
      final price = pkg.storeProduct.priceString;
      final period = _periodSuffix(pkg.packageType);
      return period == null ? price : '$price $period';
    }
  }
  return null;
}

String? _periodSuffix(PackageType type) => switch (type) {
  PackageType.annual => '/ year',
  PackageType.monthly => '/ month',
  PackageType.weekly => '/ week',
  PackageType.lifetime => 'one-time',
  _ => null,
};

String? _billedViaFor(EntitlementInfo? e) {
  if (e == null) return null;
  return switch (e.store) {
    Store.appStore => 'App Store',
    Store.playStore => 'Play Store',
    Store.stripe => 'Stripe',
    Store.amazon => 'Amazon',
    Store.macAppStore => 'Mac App Store',
    Store.promotional => 'Promo grant',
    _ => null,
  };
}

String _statusLineFor(_SubState state, EntitlementInfo? e) {
  if (e == null) return 'Pro features unlocked locally · no real subscription';
  switch (state) {
    case _SubState.lifetime:
      return 'Lifetime access — yours forever';
    case _SubState.ending:
      final date = _parseDate(e.expirationDate);
      if (date == null) return "Won't renew";
      return "Access until ${_fmtDate(date)} · won't renew";
    case _SubState.trial:
      final date = _parseDate(e.expirationDate);
      if (date == null) return 'Trial active';
      final days = date.difference(DateTime.now()).inDays;
      if (days <= 0) return 'Trial ends today';
      if (days == 1) return 'Trial ends tomorrow';
      return 'Trial ends in $days days';
    case _SubState.active:
      final date = _parseDate(e.expirationDate);
      if (date == null) return 'Active';
      return 'Renews ${_fmtDate(date)}';
    case _SubState.test:
      return 'Pro features unlocked locally';
  }
}

DateTime? _parseDate(String? raw) {
  if (raw == null) return null;
  return DateTime.tryParse(raw);
}

String _fmtDate(DateTime d) {
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

// ─── Side-effect helpers ──────────────────────────────────────────────────

Future<void> _openManagement(BuildContext context, CustomerInfo? info) async {
  final url = info?.managementURL;
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
