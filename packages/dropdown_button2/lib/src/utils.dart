part of 'dropdown_button2.dart';

void _uniqueValueAssert<T>(
  List<DropdownItem<T>>? items,
  ValueListenable<T?>? valueListenable,
  ValueListenable<List<T>>? multiValueListenable,
) {
  if (items == null || items.isEmpty) {
    return;
  }

  String assertMessage(T value) {
    return "There should be exactly one item with [DropdownButton]'s value: "
        '$value. \n'
        'Either zero or 2 or more [DropdownItem]s were detected '
        'with the same value';
  }

  assert(
    valueListenable?.value == null ||
        items.where((DropdownItem<T> item) {
              return item.value == valueListenable!.value;
            }).length ==
            1,
    assertMessage(valueListenable!.value as T),
  );

  final currentMultiValue = multiValueListenable?.value.lastOrNull;
  assert(
    currentMultiValue == null ||
        items.where((DropdownItem<T> item) {
              return item.value == currentMultiValue;
            }).length ==
            1,
    assertMessage(currentMultiValue),
  );
}

extension _InputDecorationExtension on InputDecoration {
  InputDecoration updateSurroundingElements({
    required Widget? error,
    required String? errorText,
    // TODO(Ahmed): Add this when it's supported by the min version of the package [Flutter>=3.22.0].
    required String? helperText,
  }) {
    return InputDecoration(
      icon: icon,
      iconColor: iconColor,
      label: label,
      labelText: labelText,
      labelStyle: labelStyle,
      floatingLabelStyle: floatingLabelStyle,
      //helper: helper,
      helperText: helperText,
      helperStyle: helperStyle,
      helperMaxLines: helperMaxLines,
      hintText: hintText,
      hintStyle: hintStyle,
      hintTextDirection: hintTextDirection,
      hintMaxLines: hintMaxLines,
      hintFadeDuration: hintFadeDuration,
      error: error,
      errorText: errorText,
      errorStyle: errorStyle,
      errorMaxLines: errorMaxLines,
      floatingLabelBehavior: floatingLabelBehavior,
      floatingLabelAlignment: floatingLabelAlignment,
      isCollapsed: isCollapsed,
      isDense: isDense,
      contentPadding: contentPadding,
      prefixIcon: prefixIcon,
      prefix: prefix,
      prefixText: prefixText,
      prefixStyle: prefixStyle,
      prefixIconColor: prefixIconColor,
      prefixIconConstraints: prefixIconConstraints,
      suffixIcon: suffixIcon,
      suffix: suffix,
      suffixText: suffixText,
      suffixStyle: suffixStyle,
      suffixIconColor: suffixIconColor,
      suffixIconConstraints: suffixIconConstraints,
      counter: counter,
      counterText: counterText,
      counterStyle: counterStyle,
      filled: filled,
      fillColor: fillColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      errorBorder: errorBorder,
      focusedBorder: focusedBorder,
      focusedErrorBorder: focusedErrorBorder,
      disabledBorder: disabledBorder,
      enabledBorder: enabledBorder,
      border: border,
      enabled: enabled,
      semanticCounterText: semanticCounterText,
      alignLabelWithHint: alignLabelWithHint,
      constraints: constraints,
    );
  }
}
