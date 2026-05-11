/// Drops `.00` for whole-euro amounts, keeps cents when present.
/// `12 → "12"`, `12.5 → "12.50"`, `12.99 → "12.99"`.
String formatPrice(double value) {
  if (value == value.truncateToDouble()) return value.toStringAsFixed(0);
  return value.toStringAsFixed(2);
}
