part of 'dropdown_button2.dart';

/// Represents an item in a dropdown menu created by a [DropdownButton2].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class DropdownItem<T> extends DropdownMenuItem<T> {
  /// Creates a dropdown item.
  ///
  /// The [child] property must be set.
  const DropdownItem({
    required super.child,
    super.onTap,
    super.value,
    super.enabled,
    super.alignment,
    this.closeOnTap = true,
    super.key,
  });

  /// Whether the dropdown should close when the item is tapped.
  ///
  /// Defaults to true.
  final bool closeOnTap;
}

// The widget that is the button wrapping the menu items.
class _DropdownItemButton<T> extends StatefulWidget {
  const _DropdownItemButton({
    super.key,
    required this.route,
    required this.textDirection,
    required this.buttonRect,
    required this.constraints,
    required this.mediaQueryPadding,
    required this.itemIndex,
    required this.enableFeedback,
  });

  final _DropdownRoute<T> route;
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
  void _handleFocusChange(bool focused) {
    final bool inTraditionalMode;
    switch (FocusManager.instance.highlightMode) {
      case FocusHighlightMode.touch:
        inTraditionalMode = false;
        // TODO(Ahmed): Remove decorative breaks and add lint to it [flutter>=v3.10.0].
        break;
      case FocusHighlightMode.traditional:
        inTraditionalMode = true;
        break;
    }

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = widget.route.getMenuLimits(
        widget.buttonRect,
        widget.constraints.maxHeight,
        widget.mediaQueryPadding,
        widget.itemIndex,
      );
      widget.route.scrollController!.animateTo(
        menuLimits.scrollOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  void _handleOnTap() {
    final DropdownItem<T> dropdownItem = widget.route.items[widget.itemIndex].item!;

    dropdownItem.onTap?.call();

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

  MenuItemStyleData get menuItemStyle => widget.route.menuItemStyle;

  @override
  Widget build(BuildContext context) {
    final double menuCurveEnd = widget.route.dropdownStyle.openInterval.end;

    final DropdownItem<T> dropdownItem = widget.route.items[widget.itemIndex].item!;
    final double unit = 0.5 / (widget.route.items.length + 1.5);
    final double start = _clampDouble(menuCurveEnd + (widget.itemIndex + 1) * unit, 0.0, 1.0);
    final double end = _clampDouble(start + 1.5 * unit, 0.0, 1.0);
    final CurvedAnimation opacity =
        CurvedAnimation(parent: widget.route.animation!, curve: Interval(start, end));

    Widget child = Container(
      padding: (menuItemStyle.padding ?? _kMenuItemPadding).resolve(widget.textDirection),
      height: menuItemStyle.customHeights == null
          ? menuItemStyle.height
          : menuItemStyle.customHeights![widget.itemIndex],
      child: widget.route.items[widget.itemIndex],
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
        overlayColor: menuItemStyle.overlayColor,
        child: isSelectedItem
            ? menuItemStyle.selectedMenuItemBuilder?.call(context, child) ?? child
            : child,
      );
    }
    child = FadeTransition(opacity: opacity, child: child);
    if (kIsWeb && dropdownItem.enabled) {
      child = Shortcuts(
        shortcuts: _webShortcuts,
        child: child,
      );
    }
    return child;
  }
}

// This widget enables _DropdownRoute to look up the sizes of
// each menu item. These sizes are used to compute the offset of the selected
// item so that _DropdownRoutePage can align the vertical center of the
// selected item lines up with the vertical center of the dropdown button,
// as closely as possible.
class _MenuItem<T> extends SingleChildRenderObjectWidget {
  const _MenuItem({
    super.key,
    required this.onLayout,
    required this.item,
  }) : super(child: item);

  final ValueChanged<Size> onLayout;
  final DropdownItem<T>? item;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderProxyBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child]) : super(child);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}
