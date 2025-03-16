part of 'dropdown_button2.dart';

class _ButtonStyleDataBase {
  const _ButtonStyleDataBase({
    required this.height,
    required this.width,
    required this.padding,
    required this.decoration,
    required this.foregroundDecoration,
    required this.elevation,
  });

  /// The height of the button
  final double? height;

  /// The width of the button
  final double? width;

  /// The inner padding of the Button
  final EdgeInsetsGeometry? padding;

  /// The decoration of the Button
  final BoxDecoration? decoration;

  /// The decoration to paint in front of the Button
  final BoxDecoration? foregroundDecoration;

  /// The elevation of the Button
  final int? elevation;
}

/// A class to configure the theme of the button.
class ButtonStyleData extends _ButtonStyleDataBase {
  /// Creates a ButtonStyleData.
  /// It's a class to configure the theme of the button.
  const ButtonStyleData({
    super.height,
    super.width,
    super.padding,
    super.decoration,
    super.foregroundDecoration,
    super.elevation,
    this.overlayColor,
  });

  /// Defines the ink response focus, hover, and splash colors.
  ///
  /// This default null property can be used as an alternative to
  /// [focusColor], [hoverColor], [highlightColor], and
  /// [splashColor]. If non-null, it is resolved against one of
  /// [WidgetState.focused], [WidgetState.hovered], and
  /// [WidgetState.pressed]. It's convenient to use when the parent
  /// widget can pass along its own WidgetStateProperty value for
  /// the overlay color.
  ///
  /// [WidgetState.pressed] triggers a ripple (an ink splash), per
  /// the current Material Design spec. The [overlayColor] doesn't map
  /// a state to [highlightColor] because a separate highlight is not
  /// used by the current design guidelines. See
  /// https://material.io/design/interaction/states.html#pressed
  ///
  /// If the overlay color is null or resolves to null, then [focusColor],
  /// [hoverColor], [splashColor] and their defaults are used instead.
  ///
  /// See also:
  ///
  ///  * The Material Design specification for overlay colors and how they
  ///    match a component's state:
  ///    <https://material.io/design/interaction/states.html#anatomy>.
  final WidgetStateProperty<Color?>? overlayColor;

  /// Create a clone of the current [ButtonStyleData] but with the provided
  /// parameters overridden.
  ButtonStyleData copyWith({
    double? height,
    double? width,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
    BoxDecoration? foregroundDecoration,
    int? elevation,
    WidgetStateProperty<Color?>? overlayColor,
  }) {
    return ButtonStyleData(
      height: height ?? this.height,
      width: width ?? this.width,
      padding: padding ?? this.padding,
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      elevation: elevation ?? this.elevation,
      overlayColor: overlayColor ?? this.overlayColor,
    );
  }
}

/// A class to configure the theme of the button when using DropdownButtonFormField2.
///
/// Note: To configure the button's overlay colors when using DropdownButtonFormField2,
/// use [InputDecoration] with `filled: true`. This works similarly to TextField.
///
/// i.e:
/// ```dart
/// decoration: InputDecoration(
///   filled: true,
///   fillColor: Colors.green,
///   hoverColor: Colors.red,
///   focusColor: Colors.blue,
/// ),
/// // Or
/// decoration: InputDecoration(
///   filled: true,
///   fillColor: WidgetStateColor.fromMap({
///     WidgetState.hovered: Colors.red,
///     WidgetState.focused: Colors.blue,
///     WidgetState.any: Colors.green,
///   }),
/// ),
/// ```
class FormFieldButtonStyleData extends _ButtonStyleDataBase {
  /// Creates a FormFieldButtonStyleData.
  /// It's a class to configure the theme of the button when using DropdownButtonFormField2.
  const FormFieldButtonStyleData({
    super.height,
    super.width,
    super.padding,
    super.decoration,
    super.foregroundDecoration,
    super.elevation,
  });

  /// Create a clone of the current [FormFieldButtonStyleData] but with the provided
  /// parameters overridden.
  FormFieldButtonStyleData copyWith({
    double? height,
    double? width,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
    BoxDecoration? foregroundDecoration,
    int? elevation,
  }) {
    return FormFieldButtonStyleData(
      height: height ?? this.height,
      width: width ?? this.width,
      padding: padding ?? this.padding,
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      elevation: elevation ?? this.elevation,
    );
  }

  ButtonStyleData get _toButtonStyleData {
    return ButtonStyleData(
      height: height ?? height,
      width: width ?? width,
      padding: padding ?? padding,
      decoration: decoration ?? decoration,
      foregroundDecoration: foregroundDecoration ?? foregroundDecoration,
      elevation: elevation ?? elevation,
    );
  }
}

/// A class to configure the theme of the button's icon.
class IconStyleData {
  /// Creates an IconStyleData.
  /// It's a class to configure the theme of the button's icon.
  const IconStyleData({
    this.icon = const Icon(Icons.arrow_drop_down),
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24,
    this.openMenuIcon,
  });

  /// The widget to use for the drop-down button's suffix icon.
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

  /// Create a clone of the current [IconStyleData] but with the provided
  /// parameters overridden.
  IconStyleData copyWith({
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double? iconSize,
    Widget? openMenuIcon,
  }) {
    return IconStyleData(
      icon: icon ?? this.icon,
      iconDisabledColor: iconDisabledColor ?? this.iconDisabledColor,
      iconEnabledColor: iconEnabledColor ?? this.iconEnabledColor,
      iconSize: iconSize ?? this.iconSize,
      openMenuIcon: openMenuIcon ?? this.openMenuIcon,
    );
  }
}
