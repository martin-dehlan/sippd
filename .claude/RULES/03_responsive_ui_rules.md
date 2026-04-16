# Responsive UI Rules

**TL;DR:** Zero fixed spacing or font sizes. All sizing is derived from `MediaQuery` height/width at build time. Use the `ResponsiveContext` extension from `lib/common/utils/responsive.dart`.

---

## The Core Rule

**NEVER use fixed pixel values for spacing or font sizes.**

```dart
// WRONG
SizedBox(height: 16)
Text('Cabernet', style: TextStyle(fontSize: 18))
Padding(padding: EdgeInsets.all(12))

// RIGHT
SizedBox(height: context.spaceM)
Text('Cabernet', style: TextStyle(fontSize: context.fontM))
Padding(padding: EdgeInsets.all(context.spaceS))
```

---

## Standard Spacing Formulas

All derived from `MediaQuery.of(context).size.height` (h):

| Token | Formula | ~375pt result |
|---|---|---|
| `spaceXs` | `h * 0.005` | ~1.9pt |
| `spaceS` | `h * 0.01` | ~3.7pt |
| `spaceM` | `h * 0.02` | ~7.5pt |
| `spaceL` | `h * 0.03` | ~11.2pt |
| `spaceXl` | `h * 0.04` | ~15pt |
| `spaceXxl` | `h * 0.06` | ~22.5pt |

## Standard Font Size Formulas

Derived from `MediaQuery.of(context).size.width` (w):

| Token | Formula | ~375pt result |
|---|---|---|
| `fontXs` | `w * 0.025` | ~9.4pt |
| `fontS` | `w * 0.032` | ~12pt |
| `fontM` | `w * 0.040` | ~15pt |
| `fontL` | `w * 0.050` | ~18.75pt |
| `fontXl` | `w * 0.065` | ~24.4pt |
| `fontXxl` | `w * 0.080` | ~30pt |

---

## ResponsiveContext Extension

File: `lib/common/utils/responsive.dart`

```dart
import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenHeight => screenSize.height;
  double get screenWidth => screenSize.width;

  // Spacing (height-based)
  double get spaceXs  => screenHeight * 0.005;
  double get spaceS   => screenHeight * 0.01;
  double get spaceM   => screenHeight * 0.02;
  double get spaceL   => screenHeight * 0.03;
  double get spaceXl  => screenHeight * 0.04;
  double get spaceXxl => screenHeight * 0.06;

  // Font sizes (width-based)
  double get fontXs  => screenWidth * 0.025;
  double get fontS   => screenWidth * 0.032;
  double get fontM   => screenWidth * 0.040;
  double get fontL   => screenWidth * 0.050;
  double get fontXl  => screenWidth * 0.065;
  double get fontXxl => screenWidth * 0.080;

  // Utility
  double get horizontalPadding => screenWidth * 0.05;
  double get cardBorderRadius  => screenWidth * 0.03;
  bool get isSmallScreen => screenHeight < 700;
}
```

---

## Usage Examples

```dart
// Spacing
Column(
  children: [
    SizedBox(height: context.spaceM),
    WineCard(wine: wine),
    SizedBox(height: context.spaceS),
    Text(wine.vintage.toString()),
  ],
)

// Padding
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: context.horizontalPadding,
    vertical: context.spaceM,
  ),
  child: ...,
)

// Font sizes
Text(
  wine.name,
  style: TextStyle(
    fontSize: context.fontL,
    fontWeight: FontWeight.bold,
  ),
)

Text(
  wine.winery,
  style: TextStyle(fontSize: context.fontS),
)

// Border radius
ClipRRect(
  borderRadius: BorderRadius.circular(context.cardBorderRadius),
  child: Image.network(wine.imageUrl),
)
```

---

## Anti-Patterns

```dart
// NO — const spacing
const SizedBox(height: 16)
const SizedBox(width: 8)

// NO — fixed EdgeInsets
EdgeInsets.all(12)
EdgeInsets.symmetric(horizontal: 16, vertical: 8)

// NO — fixed font size
TextStyle(fontSize: 14)
TextStyle(fontSize: 20, fontWeight: FontWeight.bold)

// NO — hardcoded container size
Container(height: 200, width: 150)

// YES — responsive container
Container(
  height: context.screenHeight * 0.25,
  width: context.screenWidth * 0.4,
)
```

---

## Notes

- `context` must be available — never compute responsive values outside `build()` or a widget method that has access to `BuildContext`.
- For images and cards with aspect ratios, prefer `AspectRatio` widget over fixed height.
- Avoid `MediaQuery` inside deeply nested builders when `context` from a parent scope is already captured — pass values down instead.
