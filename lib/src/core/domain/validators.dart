String? emptyStringValidator(
  String? value,
) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text!';
  }
  if (value.length < 2) {
    return 'Text is short!';
  }

  return null;
}

String? emptyPriceValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter Price!';
  }
  return null;
}
