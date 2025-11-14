import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void unFocus() {
  if (FocusManager.instance.primaryFocus?.hasFocus == true) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

String formatDate(dynamic date, {String format = "dd MMMM yyyy"}) {
  if (date == null) return "";
  if (date is String && date.isNotEmpty) {
    date = DateTime.tryParse(date);
    if (date == null) return "";
  }
  return DateFormat(format, "id").format(date);
}

String formatCurrency(dynamic value, {String? symbol}) {
  if (value == null) return "";
  if (value is String && value.isNotEmpty) {
    value = double.tryParse(value);
    if (value == null) return "";
  }
  return NumberFormat.currency(
    locale: "id",
    symbol: symbol ?? "Rp ",
    decimalDigits: 0,
  ).format(value);
}
