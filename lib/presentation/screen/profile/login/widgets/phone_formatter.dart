
import 'dart:math' as math;

import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  static const _groups = [2, 3, 2, 2];
  static const maxDigits = 9;

  static String format(String input) {
    var digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.length > maxDigits) digits = digits.substring(0, maxDigits);

    final parts = <String>[];
    var start = 0;
    for (final group in _groups) {
      if (start >= digits.length) break;
      final end = math.min(start + group, digits.length);
      parts.add(digits.substring(start, end));
      start = end;
    }
    return parts.join(' ');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = format(newValue.text);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}