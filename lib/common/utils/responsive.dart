import 'package:flutter/widgets.dart';

extension ResponsiveContext on BuildContext {
  double get h => MediaQuery.of(this).size.height;
  double get w => MediaQuery.of(this).size.width;

  // Spacing
  double get xs => h * 0.005;
  double get s => h * 0.01;
  double get m => h * 0.02;
  double get l => h * 0.03;
  double get xl => h * 0.04;
  double get xxl => h * 0.06;

  // Padding
  double get paddingH => w * 0.05;
  double get paddingV => h * 0.03;

  // Fonts
  double get displayFont => w * 0.11;
  double get titleFont => w * 0.07;
  double get headingFont => w * 0.05;
  double get bodyFont => w * 0.04;
  double get captionFont => w * 0.035;
}

const tabularFigures = <FontFeature>[FontFeature.tabularFigures()];
