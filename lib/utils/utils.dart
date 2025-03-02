class Utils {
  static String formatToINR(num value) {
    final double valueInCrores = value / 10000000;

    if (valueInCrores >= 1) {
      if (valueInCrores == valueInCrores.toInt().toDouble()) {
        return "${valueInCrores.toInt()} Cr";
      } else {
        return "${valueInCrores.toStringAsFixed(1)} Cr";
      }
    } else if (valueInCrores >= 0.01) {
      final double valueInLakhs = value / 100000;
      if (valueInLakhs == valueInLakhs.toInt().toDouble()) {
        return "${valueInLakhs.toInt()} L";
      } else {
        return "${valueInLakhs.toStringAsFixed(1)} L";
      }
    } else {
      return "₹${value.toInt()}";
    }
  }
}
