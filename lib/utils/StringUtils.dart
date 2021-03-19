import 'dart:ui';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  Color getColor() {
    return changeStringHexToColor(this);
  }

  static Color changeStringHexToColor(String hex) {
    var value = hex.replaceAll("#", "");
    return Color(int.parse("0xff$value"));
  }
}