String? textFieldValidator({String? value, String? errorText, String? label}) {
  if ((errorText ?? "").isNotEmpty) {
    return errorText;
  }
  if ((value ?? "").isEmpty) {
    return "${(label ?? "").isNotEmpty ? label : ""} tidak boleh kosong";
  }
  return null;
}
