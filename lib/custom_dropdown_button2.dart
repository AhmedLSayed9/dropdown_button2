import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton2 extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final Decoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight, itemWidth;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight;
  final EdgeInsetsGeometry? dropdownPadding;
  final BorderRadius? dropdownBorderRadius;
  final BoxBorder? dropdownBorder;
  final int? dropdownElevation;
  final Color? dropdownColor;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;

  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemWidth,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownPadding,
    this.dropdownBorderRadius,
    this.dropdownBorder,
    this.dropdownElevation,
    this.dropdownColor,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        //To avoid long text overflowing.
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        value: value,
        items: dropdownItems
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    alignment: valueAlignment,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ))
            .toList(),
        onChanged: onChanged,
        icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
        iconSize: iconSize ?? 12,
        iconEnabledColor: iconEnabledColor,
        iconDisabledColor: iconDisabledColor,
        buttonHeight: buttonHeight ?? 40,
        buttonWidth: buttonWidth ?? 140,
        buttonPadding:
            buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: buttonDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black45,
              ),
              color: Theme.of(context).canvasColor,
            ).copyWith(
              boxShadow: kElevationToShadow[buttonElevation ?? 0],
            ),
        itemHeight: itemHeight ?? 40,
        itemWidth: itemWidth ?? 140,
        itemPadding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: dropdownHeight ?? 240,
        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownPadding: dropdownPadding,
        dropdownBorderRadius: dropdownBorderRadius ?? BorderRadius.circular(14),
        dropdownBorder: dropdownBorder,
        //Default has no border.
        dropdownColor: dropdownColor ?? Theme.of(context).canvasColor,
        elevation: dropdownElevation ?? 8,
        scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: scrollbarThickness,
        scrollbarAlwaysShow: scrollbarAlwaysShow,
        offset: offset,
        //Null or Offset(0, 0) will open just under the button. You can edit as you want.
        showAboveButton: false, //Default is false to show menu below button
      ),
    );
  }
}
