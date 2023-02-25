part of 'dropdown_button2.dart';

class ButtonStyleData {
  const ButtonStyleData({
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.buttonSplashColor,
    this.buttonHighlightColor,
    this.buttonOverlayColor,
  });

  /// The height of the button.
  final double? buttonHeight;

  /// The width of the button
  final double? buttonWidth;

  /// The inner padding of the Button
  final EdgeInsetsGeometry? buttonPadding;

  /// The decoration of the Button
  final BoxDecoration? buttonDecoration;

  /// The elevation of the Button
  final int? buttonElevation;

  /// The splash color of the button's InkWell
  final Color? buttonSplashColor;

  /// The highlight color of the button's InkWell
  final Color? buttonHighlightColor;

  /// The overlay color of the button's Inkwell
  final MaterialStateProperty<Color?>? buttonOverlayColor;
}

class IconStyleData {
  const IconStyleData({
    this.icon = const Icon(Icons.arrow_drop_down),
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24,
    this.openMenuIcon,
  });

  /// The widget to use for the drop-down button's icon.
  ///
  /// Defaults to an [Icon] with the [Icons.arrow_drop_down] glyph.
  final Widget icon;

  /// The color of any [Icon] descendant of [icon] if this button is disabled,
  /// i.e. if [onChanged] is null.
  ///
  /// Defaults to [MaterialColor.shade400] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white10] when it is [Brightness.dark]
  final Color? iconDisabledColor;

  /// The color of any [Icon] descendant of [icon] if this button is enabled,
  /// i.e. if [onChanged] is defined.
  ///
  /// Defaults to [MaterialColor.shade700] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white70] when it is [Brightness.dark]
  final Color? iconEnabledColor;

  /// The size to use for the drop-down button's icon.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Shows different icon when dropdown menu is open
  final Widget? openMenuIcon;
}
