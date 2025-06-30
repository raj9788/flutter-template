import 'package:flutter/material.dart';

class WidgetThemes {
  static ButtonStyle elevatedButtonStyle({
    Color? foregroundColor,
    Color? backgroundColor,
  }) {
    return ElevatedButton.styleFrom(
      foregroundColor: foregroundColor ?? Colors.white,
      backgroundColor: backgroundColor ?? Colors.black,
    );
  }
}
