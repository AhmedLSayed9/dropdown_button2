part of 'dropdown_button2.dart';

/// Represents an item in a dropdown menu created by a [DropdownButton2].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class DropdownItem<T> extends _DropdownMenuItemContainer {
  /// Creates a dropdown item.
  ///
  /// The [child] property must be set.
  const DropdownItem({
    required super.child,
    super.height,
    super.intrinsicHeight,
    super.alignment,
    this.onTap,
    this.value,
    this.enabled = true,
    this.closeOnTap = true,
    super.key,
  });

  /// Called when the dropdown menu item is tapped.
  final VoidCallback? onTap;

  /// The value to return if the user selects this menu item.
  ///
  /// Eventually returned in a call to [DropdownButton.onChanged].
  final T? value;

  /// Whether or not a user can select this menu item.
  ///
  /// Defaults to `true`.
  final bool enabled;

  /// Whether the dropdown should close when the item is tapped.
  ///
  /// Defaults to true.
  final bool closeOnTap;

  /// Creates a copy of this DropdownItem but with the given fields replaced with the new values.
  DropdownItem<T> copyWith({
    Widget? child,
    double? height,
    bool? intrinsicHeight,
    void Function()? onTap,
    T? value,
    bool? enabled,
    AlignmentGeometry? alignment,
    bool? closeOnTap,
  }) {
    return DropdownItem<T>(
      height: height ?? this.height,
      intrinsicHeight: intrinsicHeight ?? this.intrinsicHeight,
      onTap: onTap ?? this.onTap,
      value: value ?? this.value,
      enabled: enabled ?? this.enabled,
      alignment: alignment ?? this.alignment,
      closeOnTap: closeOnTap ?? this.closeOnTap,
      child: child ?? this.child,
    );
  }
}

// The container widget for a menu item created by a [DropdownButton2]. It
// provides the default configuration for [DropdownMenuItem]s, as well as a
// [DropdownButton]'s hint and disabledHint widgets.
class _DropdownMenuItemContainer extends StatelessWidget {
  /// Creates an item for a dropdown menu.
  ///
  /// The [child] argument is required.
  const _DropdownMenuItemContainer({
    super.key,
    this.alignment = AlignmentDirectional.centerStart,
    required this.child,
    this.height = _kMenuItemHeight,
    this.intrinsicHeight = false,
  });

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// Defines how the item is positioned within the container.
  ///
  /// Defaults to [AlignmentDirectional.centerStart].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The height of the menu item, default value is [kMinInteractiveDimension]
  final double height;

  /// If set to true, then this item's height will vary according to its
  /// intrinsic height instead of using [height] property.
  ///
  /// It is highly recommended to keep this value as false when dealing with
  /// a significantly large items list in order to optimize performance.
  ///
  /// Note: If set to true and there isn't enough vertical room for the menu, there's
  /// no way to know the item's intrinsic height in-advance to properly scroll to
  /// the selected item. Instead, the provided [height] value will be used, which means
  /// the menu's initial scroll offset may not properly scroll to the selected item.
  final bool intrinsicHeight;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: SizedBox(
        height: intrinsicHeight ? null : height,
        child: Align(alignment: alignment, child: child),
      ),
    );
  }
}

// The widget that is the button wrapping the menu items.
class _DropdownItemButton<T> extends StatefulWidget {
  const _DropdownItemButton({
    super.key,
    required this.route,
    required this.scrollController,
    required this.textDirection,
    required this.buttonRect,
    required this.constraints,
    required this.mediaQueryPadding,
    required this.itemIndex,
    required this.enableFeedback,
  });

  final _DropdownRoute<T> route;
  final ScrollController scrollController;
  final TextDirection? textDirection;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final EdgeInsets mediaQueryPadding;
  final int itemIndex;
  final bool enableFeedback;

  @override
  _DropdownItemButtonState<T> createState() => _DropdownItemButtonState<T>();
}

class _DropdownItemButtonState<T> extends State<_DropdownItemButton<T>> {
  late CurvedAnimation _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _setOpacityAnimation();
  }

  @override
  void didUpdateWidget(_DropdownItemButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemIndex != widget.itemIndex ||
        oldWidget.route.animation != widget.route.animation ||
        oldWidget.route.selectedIndex != widget.route.selectedIndex ||
        widget.route.items.length != oldWidget.route.items.length ||
        widget.route.dropdownStyle.openInterval.end !=
            oldWidget.route.dropdownStyle.openInterval.end) {
      _opacityAnimation.dispose();
      _setOpacityAnimation();
    }
  }

  @override
  void dispose() {
    _opacityAnimation.dispose();
    super.dispose();
  }

  void _setOpacityAnimation() {
    final double menuCurveEnd = widget.route.dropdownStyle.openInterval.end;
    final double unit = 0.5 / (widget.route.items.length + 1.5);
    final double start = clampDouble(menuCurveEnd + (widget.itemIndex + 1) * unit, 0.0, 1.0);
    final double end = clampDouble(start + 1.5 * unit, 0.0, 1.0);
    _opacityAnimation = CurvedAnimation(
      parent: widget.route.animation!,
      curve: Interval(start, end),
    );
  }

  void _handleFocusChange(bool focused) {
    final bool inTraditionalMode = switch (FocusManager.instance.highlightMode) {
      FocusHighlightMode.touch => false,
      FocusHighlightMode.traditional => true,
    };

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = widget.route.getMenuLimits(
        widget.buttonRect,
        widget.constraints.maxHeight,
        widget.mediaQueryPadding,
        widget.itemIndex,
      );
      widget.scrollController.animateTo(
        menuLimits.scrollOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  void _handleOnTap() {
    final DropdownItem<T> dropdownItem = widget.route.items[widget.itemIndex];

    dropdownItem.onTap?.call();
    widget.route.onChanged?.call(dropdownItem.value);

    if (dropdownItem.closeOnTap) {
      Navigator.pop(
        context,
        _DropdownRouteResult<T>(dropdownItem.value),
      );
    }
  }

  static const Map<ShortcutActivator, Intent> _webShortcuts = <ShortcutActivator, Intent>{
    // On the web, up/down don't change focus, *except* in a <select>
    // element, which is what a dropdown emulates.
    SingleActivator(LogicalKeyboardKey.arrowDown): DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp): DirectionalFocusIntent(TraversalDirection.up),
  };

  MenuItemStyleData get _menuItemStyle => widget.route.menuItemStyle;
  EdgeInsets? get _inputDecorationPadding => widget.route.inputDecorationPadding;
  bool get _useDecorationHPadding => _menuItemStyle.useDecorationHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    final DropdownItem<T> dropdownItem = widget.route.items[widget.itemIndex];

    final menuItemPadding =
        _menuItemStyle.padding?.resolve(widget.textDirection) ?? _kMenuItemPadding;

    Widget child = Padding(
      padding: menuItemPadding.copyWith(
        left: _useDecorationHPadding ? _inputDecorationPadding?.left : null,
        right: _useDecorationHPadding ? _inputDecorationPadding?.right : null,
      ),
      child: dropdownItem,
    );
    // An [InkWell] is added to the item only if it is enabled
    // isNoSelectedItem to avoid first item highlight when no item selected
    if (dropdownItem.enabled) {
      final bool isSelectedItem =
          !widget.route.isNoSelectedItem && widget.itemIndex == widget.route.selectedIndex;
      child = InkWell(
        autofocus: isSelectedItem,
        enableFeedback: widget.enableFeedback,
        onTap: _handleOnTap,
        onFocusChange: _handleFocusChange,
        borderRadius: _menuItemStyle.borderRadius,
        overlayColor: _menuItemStyle.overlayColor,
        child: isSelectedItem
            ? _menuItemStyle.selectedMenuItemBuilder?.call(context, child) ?? child
            : child,
      );
    }
    child = FadeTransition(opacity: _opacityAnimation, child: child);
    if (kIsWeb && dropdownItem.enabled) {
      child = Shortcuts(
        shortcuts: _webShortcuts,
        child: child,
      );
    }
    return child;
  }
}
