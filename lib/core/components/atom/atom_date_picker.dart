import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unggul_mobile/core/components/atom/atom_textfield.dart';
import 'package:unggul_mobile/core/util/util.dart';

class AtomDatePicker extends StatelessWidget {
  const AtomDatePicker({
    super.key,
    this.onChanged,
    this.labelText,
    this.initialValue,
    this.firstDate,
    this.lastDate,
  });

  final void Function(DateTime?)? onChanged;
  final DateTime? initialValue;
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController(
      text: formatDate(initialValue),
    );

    return AtomTextfield(
      controller: dateController,
      hint: labelText,
      suffixIcon: const Icon(CupertinoIcons.calendar_today),
      readOnly: true,
      validator: (v) {
        if ((v ?? "").isEmpty) {
          return "$labelText tidak boleh kosong";
        }
        return null;
      },
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: initialValue ?? DateTime.now(),
          firstDate:
              firstDate ??
              DateTime.now().subtract(const Duration(days: 365 * 5)),
          lastDate:
              lastDate ?? DateTime.now().add(const Duration(days: 365 * 5)),
          cancelText: "Batal",
          confirmText: "Pilih",
          locale: const Locale('id', 'ID'),
        ).then((date) {
          if (date != null) {
            dateController.text = formatDate(date);
            if (onChanged != null) onChanged!(date);
          }
          unFocus();
        });
      },
    );
  }
}
