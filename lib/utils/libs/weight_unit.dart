class WeightUnit {
  static double kiloToTon(double value) {
    return value / 1000;
  }

  static double tonToKilo(String value) {
    return double.parse(value) * 1000;
  }
}
