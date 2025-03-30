part of 'dropdown_button2.dart';

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute({
    required this.items,
    required this.buttonRect,
    required this.buttonBorderRadius,
    required this.selectedIndex,
    required this.isNoSelectedItem,
    required this.onChanged,
    required this.capturedThemes,
    required this.style,
    required this.barrierDismissible,
    Color? barrierColor,
    this.barrierLabel,
    required this.barrierCoversButton,
    required this.parentFocusNode,
    required this.enableFeedback,
    required this.dropdownStyle,
    required this.menuItemStyle,
    required this.inputDecorationPadding,
    required this.searchData,
    this.dropdownSeparator,
  })  : barrierColor = barrierCoversButton ? barrierColor : null,
        _altBarrierColor = barrierColor;

  final List<DropdownItem<T>> items;
  final ValueNotifier<Rect?> buttonRect;
  final BorderRadius buttonBorderRadius;
  final int selectedIndex;
  final bool isNoSelectedItem;
  final ValueChanged<T?>? onChanged;
  final CapturedThemes capturedThemes;
  final TextStyle style;
  final FocusNode parentFocusNode;
  final bool enableFeedback;
  final DropdownStyleData dropdownStyle;
  final MenuItemStyleData menuItemStyle;
  final EdgeInsets? inputDecorationPadding;
  final DropdownSearchData<T>? searchData;
  final DropdownSeparator<T>? dropdownSeparator;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  /// This is used by [_CustomModalBarrier].
  final Color? _altBarrierColor;

  @override
  final String? barrierLabel;

  final bool barrierCoversButton;

  final FocusScopeNode _childNode = FocusScopeNode(debugLabel: 'Child');

  @override
  Widget buildPage(BuildContext context, _, __) {
    return FocusScope.withExternalFocusNode(
      focusScopeNode: _childNode,
      parentNode: parentFocusNode,
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          //Exclude BottomInset from maxHeight to avoid overlapping menu items
          //with keyboard when using searchable dropdown.
          //This will ensure menu is drawn in the actual available height.
          final padding = MediaQuery.paddingOf(context);
          final viewInsets = MediaQuery.viewInsetsOf(context);
          final BoxConstraints actualConstraints =
              constraints.copyWith(maxHeight: constraints.maxHeight - viewInsets.bottom);
          final EdgeInsets mediaQueryPadding =
              dropdownStyle.useSafeArea ? padding : EdgeInsets.zero;
          return ValueListenableBuilder<Rect?>(
            valueListenable: buttonRect,
            builder: (BuildContext context, Rect? rect, _) {
              final routePage = _DropdownRoutePage<T>(
                route: this,
                constraints: actualConstraints,
                mediaQueryPadding: mediaQueryPadding,
                buttonRect: rect!,
                selectedIndex: selectedIndex,
                capturedThemes: capturedThemes,
                style: style,
                enableFeedback: enableFeedback,
              );
              return barrierCoversButton
                  ? routePage
                  : _CustomModalBarrier(
                      barrierColor: _altBarrierColor,
                      animation: animation,
                      barrierCurve: barrierCurve,
                      buttonRect: rect,
                      buttonBorderRadius: buttonBorderRadius,
                      child: routePage,
                    );
            },
          );
        },
      ),
    );
  }

  void _dismiss() {
    if (isActive) {
      _childNode.dispose();
      navigator?.removeRoute(this);
    }
  }

  double _itemHeightWithSeparator(int itemIndex) {
    final itemHeight = items[itemIndex].height;
    final separatorHeight = dropdownSeparator?.height ?? 0;
    return itemIndex != 0 ? itemHeight + separatorHeight : itemHeight;
  }

  double _calculateHeightUntilIndex(
    int index, {
    bool Function(DropdownItem<T> item)? itemPredicate,
  }) {
    var itemsHeight = 0.0;
    for (int i = 0; i < index; i++) {
      if (itemPredicate == null || itemPredicate(items[i])) {
        itemsHeight += _itemHeightWithSeparator(i);
      }
    }
    return itemsHeight;
  }

  double getItemOffset(int index) {
    final double paddingTop = dropdownStyle.padding != null
        ? dropdownStyle.padding!.resolve(null).top
        : kMaterialListPadding.top;
    double offset = paddingTop;

    if (items.isNotEmpty && index > 0) {
      if (searchData?.searchController?.text case final searchText?) {
        final searchMatchFn = searchData?.searchMatchFn ?? _defaultSearchMatchFn();
        final selectedItemExist = searchMatchFn(items[index], searchText);
        if (selectedItemExist) {
          offset += _getSearchItemsHeight(index, searchText);
        }
      } else {
        offset += _calculateHeightUntilIndex(index);
      }
    }

    return offset;
  }

  double _getSearchItemsHeight(int index, String searchText) {
    final searchMatchFn = searchData?.searchMatchFn ?? _defaultSearchMatchFn();
    return _calculateHeightUntilIndex(
      index,
      itemPredicate: (item) => searchMatchFn(item, searchText),
    );
  }

  // Returns the vertical extent of the menu and the initial scrollOffset
  // for the ListView that contains the menu items.
  _MenuLimits getMenuLimits(
    Rect buttonRect,
    double availableHeight,
    EdgeInsets mediaQueryPadding,
    int index,
  ) {
    double maxHeight = getMenuAvailableHeight(availableHeight, mediaQueryPadding);
    // If a preferred MaxHeight is set by the user, use it instead of the available maxHeight.
    final double? preferredMaxHeight = dropdownStyle.maxHeight;
    if (preferredMaxHeight != null) {
      maxHeight = math.min(maxHeight, preferredMaxHeight);
    }

    double actualMenuHeight = dropdownStyle.padding?.vertical ?? kMaterialListPadding.vertical;
    final double innerWidgetHeight = searchData?.searchBarWidgetHeight ?? 0.0;
    actualMenuHeight += innerWidgetHeight;
    if (items.isNotEmpty) {
      final searchText = searchData?.searchController?.text;
      actualMenuHeight += searchText != null
          ? _getSearchItemsHeight(items.length, searchText)
          : _calculateHeightUntilIndex(items.length);
    }

    // Use actualMenuHeight if it's less than maxHeight.
    // Otherwise, maxHeight will be used, as if there are too many elements in
    // the menu, we need to shrink it down so it is at most the maxHeight.
    final double menuHeight = math.min(maxHeight, actualMenuHeight);

    // The computed top and bottom of the menu
    double menuTop = dropdownStyle.isOverButton
        ? buttonRect.top - dropdownStyle.offset.dy
        : buttonRect.bottom - dropdownStyle.offset.dy;
    double menuBottom = menuTop + menuHeight;

    // If the computed top or bottom of the menu are outside of the range
    // specified, we need to bring them into range.
    // `mediaQueryPadding` should be considered (equals to 0.0 if useSafeArea is false).
    final double topLimit = mediaQueryPadding.top;
    final double bottomLimit = availableHeight - mediaQueryPadding.bottom;
    if (menuTop < topLimit) {
      menuTop = topLimit;
      menuBottom = menuTop + menuHeight;
    } else if (menuBottom > bottomLimit) {
      menuBottom = bottomLimit;
      menuTop = menuBottom - menuHeight;
    }

    double scrollOffset = 0;
    // If all of the menu items will not fit within maxHeight then
    // compute the scroll offset that will line the selected menu item up
    // with the select item. This is only done when the menu is first
    // shown - subsequently we leave the scroll offset where the user left it.
    if (actualMenuHeight > maxHeight) {
      //menuHeight & actualMenuHeight without innerWidget's Height
      final double menuNetHeight = menuHeight - innerWidgetHeight;
      final double actualMenuNetHeight = actualMenuHeight - innerWidgetHeight;
      // The offset should be zero if the selected item is in view at the beginning
      // of the menu. Otherwise, the scroll offset should center the item if possible.
      final double selectedItemOffset = getItemOffset(index);
      scrollOffset = math.max(
        0.0,
        selectedItemOffset - (menuNetHeight / 2) + (items[index].height / 2),
      );
      // If the selected item's scroll offset is greater than the maximum scroll offset,
      // set it instead to the maximum allowed scroll offset.
      final double maxScrollOffset = actualMenuNetHeight - menuNetHeight;
      scrollOffset = math.min(scrollOffset, maxScrollOffset);
    }

    assert((menuBottom - menuTop - menuHeight).abs() < precisionErrorTolerance);
    return _MenuLimits(menuTop, menuBottom, menuHeight, scrollOffset);
  }

  // The maximum height of a simple menu should be one or more rows less than
  // the view height. This ensures a tappable area outside of the simple menu
  // with which to dismiss the menu.
  //   -- https://material.io/design/components/menus.html#usage
  double getMenuAvailableHeight(
    double availableHeight,
    EdgeInsets mediaQueryPadding,
  ) {
    return math.max(
      0.0,
      availableHeight - mediaQueryPadding.vertical - _kMenuItemHeight,
    );
  }
}

class _DropdownRoutePage<T> extends StatefulWidget {
  const _DropdownRoutePage({
    super.key,
    required this.route,
    required this.constraints,
    required this.mediaQueryPadding,
    required this.buttonRect,
    required this.selectedIndex,
    this.elevation = 8,
    required this.capturedThemes,
    this.style,
    required this.enableFeedback,
  });

  final _DropdownRoute<T> route;
  final BoxConstraints constraints;
  final EdgeInsets mediaQueryPadding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final CapturedThemes capturedThemes;
  final TextStyle? style;
  final bool enableFeedback;

  @override
  State<_DropdownRoutePage<T>> createState() => _DropdownRoutePageState<T>();
}

class _DropdownRoutePageState<T> extends State<_DropdownRoutePage<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Computing the initialScrollOffset now, before the items have been laid
    // out. This only works if the item heights are effectively fixed, i.e. either
    // DropdownButton.itemHeight is specified or DropdownButton.itemHeight is null
    // and all of the items' intrinsic heights are less than _kMenuItemHeight.
    // Otherwise the initialScrollOffset is just a rough approximation based on
    // treating the items as if their heights were all equal to _kMenuItemHeight.
    final _MenuLimits menuLimits = widget.route.getMenuLimits(
      widget.buttonRect,
      widget.constraints.maxHeight,
      widget.mediaQueryPadding,
      widget.selectedIndex,
    );
    _scrollController = ScrollController(initialScrollOffset: menuLimits.scrollOffset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));

    final TextDirection? textDirection = Directionality.maybeOf(context);
    final Widget menu = _DropdownMenu<T>(
      route: widget.route,
      scrollController: _scrollController,
      textDirection: textDirection,
      buttonRect: widget.buttonRect,
      constraints: widget.constraints,
      mediaQueryPadding: widget.mediaQueryPadding,
      enableFeedback: widget.enableFeedback,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _DropdownMenuRouteLayout<T>(
              route: widget.route,
              textDirection: textDirection,
              buttonRect: widget.buttonRect,
              availableHeight: widget.constraints.maxHeight,
              mediaQueryPadding: widget.mediaQueryPadding,
            ),
            child: widget.capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    required this.route,
    required this.buttonRect,
    required this.availableHeight,
    required this.mediaQueryPadding,
    required this.textDirection,
  });

  final _DropdownRoute<T> route;
  final Rect buttonRect;
  final double availableHeight;
  final EdgeInsets mediaQueryPadding;
  final TextDirection? textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = route.getMenuAvailableHeight(availableHeight, mediaQueryPadding);
    final double? preferredMaxHeight = route.dropdownStyle.maxHeight;
    if (preferredMaxHeight != null && preferredMaxHeight <= maxHeight) {
      maxHeight = preferredMaxHeight;
    }
    // The width of a menu should be at most the view width. This ensures that
    // the menu does not extend past the left and right edges of the screen.
    final double? menuWidth = route.dropdownStyle.width;
    final double width = math.min(constraints.maxWidth, menuWidth ?? buttonRect.width);
    return BoxConstraints(
      minWidth: width,
      maxWidth: width,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final _MenuLimits menuLimits = route.getMenuLimits(
      buttonRect,
      availableHeight,
      mediaQueryPadding,
      route.selectedIndex,
    );

    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        // If the button was entirely on-screen, then verify
        // that the menu is also on-screen.
        // If the button was a bit off-screen, then, oh well.
        assert(menuLimits.top >= 0.0);
        assert(menuLimits.top + menuLimits.height <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);

    final Offset offset = route.dropdownStyle.offset;
    final double left = switch (route.dropdownStyle.direction) {
      DropdownDirection.textDirection => switch (textDirection!) {
          TextDirection.rtl => clampDouble(
              buttonRect.right - childSize.width + offset.dx,
              0.0,
              size.width - childSize.width,
            ),
          TextDirection.ltr => clampDouble(
              buttonRect.left + offset.dx,
              0.0,
              size.width - childSize.width,
            ),
        },
      DropdownDirection.right => clampDouble(
          buttonRect.left + offset.dx,
          0.0,
          size.width - childSize.width,
        ),
      DropdownDirection.left => clampDouble(
          buttonRect.right - childSize.width + offset.dx,
          0.0,
          size.width - childSize.width,
        ),
      DropdownDirection.center => clampDouble(
          (size.width - childSize.width) / 2 + offset.dx,
          0.0,
          size.width - childSize.width,
        ),
    };

    return Offset(left, menuLimits.top);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect || textDirection != oldDelegate.textDirection;
  }
}

// We box the return value so that the return value can be null. Otherwise,
// canceling the route (which returns null) would get confused with actually
// returning a real null value.
@immutable
class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T? result;

  @override
  bool operator ==(Object other) {
    return other is _DropdownRouteResult<T> && other.result == result;
  }

  @override
  int get hashCode => result.hashCode;
}

/// This barrier doesn't cover the dropdown button.
/// It's used instead of the route barrier when `barrierCoversButton` is set to false.
class _CustomModalBarrier extends StatefulWidget {
  const _CustomModalBarrier({
    required this.barrierColor,
    required this.animation,
    required this.barrierCurve,
    required this.buttonRect,
    required this.buttonBorderRadius,
    required this.child,
  });

  final Color? barrierColor;
  final Animation<double>? animation;
  final Curve barrierCurve;
  final Rect buttonRect;
  final BorderRadius buttonBorderRadius;
  final Widget child;

  @override
  State<_CustomModalBarrier> createState() => _CustomModalBarrierState();
}

class _CustomModalBarrierState extends State<_CustomModalBarrier> {
  late final Animation<Color?> color;

  @override
  void initState() {
    super.initState();
    color = widget.animation!.drive(
      ColorTween(
        // TODO(Ahmed): Use `.withValues(alpha: 0.0)`
        // when it's supported by the min version of the package [Flutter>=3.27.0]
        // ignore: deprecated_member_use
        begin: widget.barrierColor?.withOpacity(0.0),
        end: widget.barrierColor,
      ).chain(CurveTween(curve: widget.barrierCurve)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: color,
          builder: (BuildContext context, Color? value, Widget? child) {
            return CustomPaint(
              painter: _DropdownBarrierPainter(
                barrierColor: value,
                buttonRect: widget.buttonRect,
                buttonBorderRadius: widget.buttonBorderRadius,
                pageSize: size,
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _DropdownBarrierPainter extends CustomPainter {
  const _DropdownBarrierPainter({
    required this.barrierColor,
    required this.buttonRect,
    required this.buttonBorderRadius,
    required this.pageSize,
  });

  final Color? barrierColor;
  final Rect buttonRect;
  final BorderRadius buttonBorderRadius;
  final Size pageSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (barrierColor != null) {
      final Rect rect = Rect.fromLTRB(
        -buttonRect.left,
        -buttonRect.top,
        pageSize.width,
        pageSize.height,
      );

      canvas.saveLayer(rect, Paint());
      canvas.drawRect(rect, Paint()..color = barrierColor!);

      final RRect buttonRRect = RRect.fromRectAndCorners(
        buttonRect,
        topLeft: buttonBorderRadius.topLeft,
        topRight: buttonBorderRadius.topRight,
        bottomLeft: buttonBorderRadius.bottomLeft,
        bottomRight: buttonBorderRadius.bottomRight,
      );

      canvas.drawRRect(buttonRRect, Paint()..blendMode = BlendMode.clear);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_DropdownBarrierPainter oldPainter) {
    return oldPainter.barrierColor != barrierColor ||
        oldPainter.buttonRect != buttonRect ||
        oldPainter.buttonBorderRadius != buttonBorderRadius;
  }
}
