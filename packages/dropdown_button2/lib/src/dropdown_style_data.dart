part of 'dropdown_button2.dart';

/// A class to configure the theme of the dropdown menu.
class DropdownStyleData {
  /// Creates a DropdownStyleData.
  const DropdownStyleData({
    this.maxHeight,
    this.width,
    this.padding,
    this.scrollPadding,
    this.decoration,
    this.elevation = 8,
    this.direction = DropdownDirection.textDirection,
    this.offset = Offset.zero,
    this.isOverButton = false,
    this.useSafeArea = true,
    @Deprecated('Use useRootNavigator instead.') this.isFullScreen,
    this.useRootNavigator = false,
    this.scrollbarTheme,
    this.openInterval = const Interval(0.25, 0.5),
    this.dropdownBuilder,
  });

  /// The maximum height of the dropdown menu
  ///
  /// The maximum height of the menu must be at least one row shorter than
  /// the height of the app's view. This ensures that a tappable area
  /// outside of the simple menu is present so the user can dismiss the menu.
  ///
  /// If this property is set above the maximum allowable height threshold
  /// mentioned above, then the menu defaults to being padded at the top
  /// and bottom of the menu by at one menu item's height.
  final double? maxHeight;

  /// The width of the dropdown menu
  ///
  /// If it is not provided, the width of the menu is the width of the dropdown button.
  final double? width;

  /// The inner padding of the dropdown menu
  ///
  /// The horizontal padding will be added to the button's padding as well, ensuring that
  /// the menu width and button width adapt seamlessly to the maximum width of the items.
  final EdgeInsetsGeometry? padding;

  /// The inner padding of the dropdown menu including the scrollbar
  ///
  /// The horizontal padding will be added to the button's padding as well, ensuring that
  /// the menu width and button width adapt seamlessly to the maximum width of the items.
  final EdgeInsetsGeometry? scrollPadding;

  /// The decoration of the dropdown menu
  final BoxDecoration? decoration;

  /// The z-coordinate at which to place the menu when open.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12,
  /// 16, and 24. See [kElevationToShadow].
  ///
  /// Defaults to 8, the appropriate elevation for dropdown buttons.
  final int elevation;

  /// The direction of the dropdown menu in relation to the button.
  ///
  /// Default is [DropdownDirection.textDirection]
  final DropdownDirection direction;

  /// Changes the position of the dropdown menu
  final Offset offset;

  /// Opens the dropdown menu over the button instead of below it
  final bool isOverButton;

  /// Determine if the dropdown menu should only display in safe areas of the screen.
  /// It is true by default, which means the dropdown menu will not overlap
  /// operating system areas.
  final bool useSafeArea;

  /// Opens the dropdown menu in fullscreen mode (Above AppBar & TabBar)
  ///
  /// Deprecated in favor of [useRootNavigator].
  @Deprecated('Use useRootNavigator instead.')
  final bool? isFullScreen;

  /// Determine whether to open the dropdown menu using the root Navigator or not.
  /// If it's set to to true, dropdown menu will be pushed above all subsequent
  /// instances of the root navigator such as AppBar/TabBar. By default, it is false.
  final bool useRootNavigator;

  /// Configures the theme of the menu's scrollbar
  final ScrollbarThemeData? scrollbarTheme;

  /// The animation curve used for opening the dropdown menu (forward direction)
  final Interval openInterval;

  /// A builder to customize the dropdown menu.
  ///
  /// Example:
  /// ```dart
  /// dropdownBuilder: (ctx, child) {
  ///   return ClipRRect(
  ///     clipBehavior: Clip.antiAlias,
  ///     child: BackdropFilter(
  ///       filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  ///       child: child,
  ///     ),
  ///   );
  /// },
  /// ```
  final DropdownBuilder? dropdownBuilder;

  /// Create a clone of the current [DropdownStyleData] but with the provided
  /// parameters overridden.
  DropdownStyleData copyWith({
    double? maxHeight,
    double? width,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? scrollPadding,
    BoxDecoration? decoration,
    int? elevation,
    DropdownDirection? direction,
    Offset? offset,
    bool? isOverButton,
    bool? useSafeArea,
    bool? isFullScreen,
    bool? useRootNavigator,
    ScrollbarThemeData? scrollbarTheme,
    Interval? openInterval,
    DropdownBuilder? dropdownBuilder,
  }) {
    return DropdownStyleData(
      maxHeight: maxHeight ?? this.maxHeight,
      width: width ?? this.width,
      padding: padding ?? this.padding,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      decoration: decoration ?? this.decoration,
      elevation: elevation ?? this.elevation,
      direction: direction ?? this.direction,
      offset: offset ?? this.offset,
      isOverButton: isOverButton ?? this.isOverButton,
      useSafeArea: useSafeArea ?? this.useSafeArea,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      useRootNavigator: useRootNavigator ?? this.useRootNavigator,
      scrollbarTheme: scrollbarTheme ?? this.scrollbarTheme,
      openInterval: openInterval ?? this.openInterval,
      dropdownBuilder: dropdownBuilder ?? this.dropdownBuilder,
    );
  }
}

/// A class to configure the theme of the dropdown menu items.
class MenuItemStyleData {
  /// Creates a MenuItemStyleData.
  const MenuItemStyleData({
    this.padding,
    this.useDecorationHorizontalPadding = false,
    this.borderRadius,
    this.overlayColor,
    this.selectedMenuItemBuilder,
  });

  /// The padding applied to each menu item.
  ///
  /// The horizontal padding will be added to the button's padding as well, ensuring that
  /// the menu width and button width adapt seamlessly to the maximum width of the items.
  final EdgeInsetsGeometry? padding;

  /// Whether to use the horizontal padding from `decoration.contentPadding`
  /// instead of `padding`, applicable only when using `DropdownButtonFormField2`.
  ///
  /// If `true`, the horizontal padding defined in `decoration.contentPadding`
  /// will be applied, ensuring consistency with the form field's padding.
  final bool useDecorationHorizontalPadding;

  /// The border radius of the menu item.
  final BorderRadius? borderRadius;

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

  /// A builder to customize the selected menu item.
  ///
  /// If this callback is null, the selected menu item will be displayed as other [items].
  ///
  /// You should return the child from the builder wrapped with the widget that
  /// customize your item, i.e:
  /// ```dart
  /// selectedMenuItemBuilder: (ctx, child) {
  ///   return Container(
  ///     color: Colors.blue,
  ///     child: child,
  ///   );
  /// },
  /// ```
  final SelectedMenuItemBuilder? selectedMenuItemBuilder;

  /// Create a clone of the current [MenuItemStyleData] but with the provided
  /// parameters overridden.
  MenuItemStyleData copyWith({
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    WidgetStateProperty<Color?>? overlayColor,
    SelectedMenuItemBuilder? selectedMenuItemBuilder,
  }) {
    return MenuItemStyleData(
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      overlayColor: overlayColor ?? this.overlayColor,
      selectedMenuItemBuilder: selectedMenuItemBuilder ?? this.selectedMenuItemBuilder,
    );
  }
}

/// A class to configure searchable dropdowns.
class DropdownSearchData<T> {
  /// Creates a DropdownSearchData.
  const DropdownSearchData({
    this.searchController,
    this.searchBarWidget,
    this.searchBarWidgetHeight,
    this.noResultsWidget,
    this.searchMatchFn,
  }) : assert(
          (searchBarWidget == null) == (searchBarWidgetHeight == null),
          'searchBarWidgetHeight should not be null when using searchBarWidget\n'
          'This is necessary to properly determine menu limits and scroll offset',
        );

  /// The TextEditingController used for searchable dropdowns. If this is null,
  /// then it'll perform as a normal dropdown without searching feature.
  final TextEditingController? searchController;

  /// The widget to use for searchable dropdowns, such as search bar.
  /// It will be shown at the top of the dropdown menu.
  final Widget? searchBarWidget;

  /// The height of the searchBarWidget if used.
  final double? searchBarWidgetHeight;

  /// The widget to show when the search results are empty.
  final Widget? noResultsWidget;

  /// The match function used for searchable dropdowns. If this is null,
  /// then _defaultSearchMatchFn will be used.
  ///
  /// ```dart
  /// _defaultSearchMatchFn = (item, searchValue) =>
  ///   item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
  /// ```
  final SearchMatchFn<T>? searchMatchFn;

  /// Create a clone of the current [DropdownSearchData] but with the provided
  /// parameters overridden.
  DropdownSearchData<T> copyWith({
    TextEditingController? searchController,
    Widget? searchBarWidget,
    double? searchBarWidgetHeight,
    Widget? noResultsWidget,
    SearchMatchFn<T>? searchMatchFn,
  }) {
    return DropdownSearchData<T>(
      searchController: searchController ?? this.searchController,
      searchBarWidget: searchBarWidget ?? this.searchBarWidget,
      searchBarWidgetHeight: searchBarWidgetHeight ?? this.searchBarWidgetHeight,
      noResultsWidget: noResultsWidget ?? this.noResultsWidget,
      searchMatchFn: searchMatchFn ?? this.searchMatchFn,
    );
  }
}
