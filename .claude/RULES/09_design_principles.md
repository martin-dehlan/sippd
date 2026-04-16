# 09 - Design Principles

## TL;DR

```
ANTI-AI-SLOP:
NO: Gradients, glassmorphism, heavy shadows, 3+ card levels, >2 buttons/screen
YES: Theme colors only, clear hierarchy, generous spacing, minimal elevation

MANDATORY:
- Colors: Theme.of(context).colorScheme — minimize manual color assignments
- Spacing: ONLY MediaQuery (NO fixed numbers)
- Widgets: Separate classes (NO _build methods)
- Buttons: max 2 per screen (primary + secondary)
```

## Pre-Flight Checklist

- [ ] Colors from `colorScheme` only
- [ ] No gradients/glassmorphism
- [ ] MediaQuery for all spacing
- [ ] Max 2 button types per screen
- [ ] Clear hierarchy (title > subtitle > details)
- [ ] Separate Widget classes (no `_build*` methods)

---

## ANTI-AI-SLOP RULES (ABSOLUTE)

### FORBIDDEN
```dart
gradient: LinearGradient(...)           // NEVER
BackdropFilter(filter: ImageFilter...)  // NEVER
BorderRadius.circular(30)              // Max: width * 0.03
BoxShadow(blurRadius: 50)             // Max blur: 10
Widget _buildHeader() { ... }          // Extract to class
Color(0xFF123456)                      // Use colorScheme
Colors.blue                            // Use colorScheme
```

### REQUIRED
```dart
final cs = Theme.of(context).colorScheme;
color: cs.surface                      // Theme colors
elevation: 0                           // Minimal elevation
SizedBox(height: h * 0.03)            // MediaQuery spacing
class MyHeader extends StatelessWidget // Separate widgets
```

---

## Color System

```dart
final cs = Theme.of(context).colorScheme;

// Text
cs.onSurface          // primary text (default — don't set manually)
cs.onSurfaceVariant   // secondary text
cs.outline            // tertiary / hint text

// Surfaces
cs.surface            // cards, sheets
cs.surfaceContainer   // slightly elevated

// Borders
cs.outlineVariant     // subtle borders

// Actions
cs.primary            // CTAs, accent
cs.error              // errors
```

---

## Spacing System (MediaQuery ONLY)

```dart
final h = MediaQuery.of(context).size.height;
final w = MediaQuery.of(context).size.width;

xs: h * 0.005  // ~4px
s:  h * 0.01   // ~8px
m:  h * 0.02   // ~16px
l:  h * 0.03   // ~24px
xl: h * 0.04   // ~32px
```

---

## Widget Architecture

```dart
// NEVER
Widget _buildHeader() { ... }

// ALWAYS
class MyHeader extends StatelessWidget { ... }
```

---

## File Size Limits

```
Widget: 300 lines max
Controller: 400 lines max
Service/Repo: 300 lines max
```
