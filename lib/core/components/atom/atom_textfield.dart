import 'package:flutter/material.dart';

class AtomTextfield extends StatelessWidget {
  const AtomTextfield({
    super.key,
    this.hint,
    this.initialValue,
    this.obscureText = false,
    this.margin,
    this.controller,
    this.minLines,
    this.maxLength,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.prefixText,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  final String? hint;
  final String? initialValue;
  final bool obscureText;
  final EdgeInsets? margin;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? prefixText;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        initialValue: initialValue,
        validator: validator,
        minLines: minLines,
        maxLines: minLines ?? 1,
        keyboardType: keyboardType,
        maxLength: maxLength,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,
          prefixText: prefixText,
        ),
      ),
    );
  }
}
