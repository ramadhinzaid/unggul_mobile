import 'package:flutter/material.dart';

class AtomDropdown<T> extends StatelessWidget {
  const AtomDropdown({
    super.key,
    this.label,
    this.errorText,
    this.initialValue,
    this.margin,
    required this.items,
    this.onSelected,
    this.controller,
  });

  final TextEditingController? controller;
  final String? label;
  final String? errorText;
  final T? initialValue;
  final EdgeInsets? margin;
  final List<DropdownMenuEntry<T?>> items;
  final void Function(T?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 16),
      child: DropdownMenu<T?>(
        controller: controller,
        errorText: errorText,
        initialSelection: initialValue,
        width: double.maxFinite,
        label: Text("Pilih $label"),
        dropdownMenuEntries: items,
        onSelected: onSelected,
      ),
    );
  }
}
