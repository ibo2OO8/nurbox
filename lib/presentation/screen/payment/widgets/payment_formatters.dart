import 'dart:math';
import 'package:flutter/services.dart';

class GroupedDigitsFormatter extends TextInputFormatter {
  GroupedDigitsFormatter(this.groups, this.separator)
      : maxDigits = groups.fold(0, (a, b) => a + b);

  final List<int> groups;
  final String separator;
  final int maxDigits;

  static final card = GroupedDigitsFormatter([4, 4, 4, 4], ' ');
  static final expiry = GroupedDigitsFormatter([2, 2], '/');
  static final phone = GroupedDigitsFormatter([2, 3, 2, 2], ' ');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var d = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (d.length > maxDigits) d = d.substring(0, maxDigits);
    final sb = StringBuffer();
    var i = 0;
    for (final g in groups) {
      if (i >= d.length) break;
      final end = min(i + g, d.length);
      if (i > 0) sb.write(separator);
      sb.write(d.substring(i, end));
      i = end;
    }
    final text = sb.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
