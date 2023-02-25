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
