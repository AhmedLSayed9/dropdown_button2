part of 'dropdown_button2.dart';

SearchMatchFn<T> _defaultSearchMatchFn<T>() => (DropdownItem<T> item, String searchValue) =>
    item.value.toString().toLowerCase().contains(searchValue.toLowerCase());

class _MenuLimits {
  const _MenuLimits(this.top, this.bottom, this.height, this.scrollOffset);

  final double top;
  final double bottom;
  final double height;
  final double scrollOffset;
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    super.key,
    required this.route,
    required this.scrollController,
    required this.textDirection,
    required this.buttonRect,
    required this.constraints,
    required this.mediaQueryPadding,
    required this.enableFeedback,
  });

  final _DropdownRoute<T> route;
  final ScrollController scrollController;
  final TextDirection? textDirection;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final EdgeInsets mediaQueryPadding;
  final bool enableFeedback;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  late final CurvedAnimation _fadeOpacity;
  late final CurvedAnimation _resize;
  late List<Widget> _children;
  late SearchMatchFn<T> _searchMatchFn;

  List<DropdownItem<T>> get items => widget.route.items;

  DropdownStyleData get dropdownStyle => widget.route.dropdownStyle;

  DropdownSearchData<T>? get searchData => widget.route.searchData;

  _DropdownItemButton<T> dropdownItemButton(int index) => _DropdownItemButton<T>(
        route: widget.route,
        scrollController: widget.scrollController,
        textDirection: widget.textDirection,
        buttonRect: widget.buttonRect,
        constraints: widget.constraints,
        mediaQueryPadding: widget.mediaQueryPadding,
        itemIndex: index,
        enableFeedback: widget.enableFeedback,
      );

  @override
  void initState() {
    super.initState();
    // We need to hold these animations as state because of their curve
    // direction. When the route's animation reverses, if we were to recreate
    // the CurvedAnimation objects in build, we'd lose
    // CurvedAnimation._curveDirection.
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = CurvedAnimation(
      parent: widget.route.animation!,
      curve: dropdownStyle.openInterval,
      reverseCurve: const Threshold(0.0),
    );
    //If searchController is null, then it'll perform as a normal dropdown
    //and search functions will not be executed.
    final searchController = searchData?.searchController;
    if (searchController == null) {
      _children = <Widget>[
        for (int index = 0; index < items.length; ++index) dropdownItemButton(index),
      ];
    } else {
      _searchMatchFn = searchData?.searchMatchFn ?? _defaultSearchMatchFn();
      _children = _getSearchItems();
      // Add listener to searchController (if it's used) to update the shown items.
      searchController.addListener(_onSearchChange);
    }
  }

  void _onSearchChange() {
    _children = _getSearchItems();
    setState(() {});
  }

  List<Widget> _getSearchItems() {
    final String currentSearch = searchData!.searchController!.text;
    return <Widget>[
      for (int index = 0; index < items.length; ++index)
        if (_searchMatchFn(items[index], currentSearch)) dropdownItemButton(index),
    ];
  }

  @override
  void dispose() {
    _fadeOpacity.dispose();
    _resize.dispose();
    searchData?.searchController?.removeListener(_onSearchChange);
    super.dispose();
  }

  final _states = <WidgetState>{
    WidgetState.dragged,
    WidgetState.hovered,
  };

  bool get _isIOS => Theme.of(context).platform == TargetPlatform.iOS;

  ScrollbarThemeData? get _scrollbarTheme => dropdownStyle.scrollbarTheme;

  bool get _iOSThumbVisibility => _scrollbarTheme?.thumbVisibility?.resolve(_states) ?? true;

  bool get _hasIntrinsicHeight =>
      widget.route.items.any((item) => item.intrinsicHeight) ||
      (widget.route.dropdownSeparator != null && widget.route.dropdownSeparator!.intrinsicHeight);

  @override
  Widget build(BuildContext context) {
    // The menu is shown in three stages (unit timing in brackets):
    // [0s - 0.25s] - Fade in a rect-sized menu container with the selected item.
    // [0.25s - 0.5s] - Grow the otherwise empty menu container from the center
    //   until it's big enough for as many items as we're going to show.
    // [0.5s - 1.0s] Fade in the remaining visible items from top to bottom.
    //
    // When the menu is dismissed we just fade the entire thing out
    // in the first 0.25s.
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;

    final separator = widget.route.dropdownSeparator;

    final Widget dropdownMenu = Material(
      type: MaterialType.transparency,
      textStyle: route.style,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (searchData?.searchBarWidget != null) searchData!.searchBarWidget!,
          if (_children.isEmpty && searchData?.noResultsWidget != null)
            searchData!.noResultsWidget!
          else
            Flexible(
              // This Material wrapper is temporary until it's fixed by flutter at:
              // https://github.com/flutter/flutter/issues/86584
              // https://github.com/flutter/flutter/issues/73315
              child: Material(
                type: MaterialType.transparency,
                textStyle: route.style,
                child: Padding(
                  padding: dropdownStyle.scrollPadding ?? EdgeInsets.zero,
                  child: ScrollConfiguration(
                    // Dropdown menus should never overscroll or display an overscroll indicator.
                    // Scrollbars are built-in below.
                    // Platform must use Theme and ScrollPhysics must be Clamping.
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false,
                      overscroll: false,
                      physics: const ClampingScrollPhysics(),
                      platform: Theme.of(context).platform,
                    ),
                    child: PrimaryScrollController(
                      controller: widget.scrollController,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          scrollbarTheme: dropdownStyle.scrollbarTheme,
                        ),
                        child: Scrollbar(
                          thumbVisibility:
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              _isIOS ? _iOSThumbVisibility : true,
                          thickness: _isIOS ? _scrollbarTheme?.thickness?.resolve(_states) : null,
                          radius: _isIOS ? _scrollbarTheme?.radius : null,
                          child: ListView.custom(
                            // Ensure this always inherits the PrimaryScrollController
                            primary: true,
                            shrinkWrap: true,
                            padding: dropdownStyle.padding ?? kMaterialListPadding,
                            itemExtentBuilder: _hasIntrinsicHeight
                                ? null
                                : (index, dimensions) {
                                    final childrenLength = separator == null
                                        ? _children.length
                                        : SeparatedSliverChildBuilderDelegate
                                            .computeActualChildCount(_children.length);
                                    // TODO(Ahmed): Remove this when https://github.com/flutter/flutter/pull/142428
                                    // is supported by the min version of the package [Flutter>=3.22.0].
                                    if (index >= childrenLength) {
                                      return 100;
                                    }
                                    return separator == null
                                        ? route.items[index].height
                                        : index.isOdd
                                            ? separator.height
                                            : route.items[index ~/ 2].height;
                                  },
                            childrenDelegate: separator == null
                                ? SliverChildBuilderDelegate(
                                    (context, index) => _children[index],
                                    childCount: _children.length,
                                  )
                                : SeparatedSliverChildBuilderDelegate(
                                    itemCount: _children.length,
                                    itemBuilder: (context, index) => _children[index],
                                    separatorBuilder: (context, index) => SizedBox(
                                      height: separator.intrinsicHeight ? null : separator.height,
                                      child: separator,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return FadeTransition(
      opacity: _fadeOpacity,
      child: CustomPaint(
        painter: _DropdownMenuPainter(
          color: Theme.of(context).canvasColor,
          elevation: dropdownStyle.elevation,
          selectedIndex: route.selectedIndex,
          resize: _resize,
          itemHeight: items[0].height,
          dropdownDecoration: dropdownStyle.decoration,
          textDirection: widget.textDirection,
        ),
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: ClipRRect(
            //Prevent scrollbar, ripple effect & items from going beyond border boundaries when scrolling.
            clipBehavior:
                dropdownStyle.decoration?.borderRadius != null ? Clip.antiAlias : Clip.none,
            borderRadius: dropdownStyle.decoration?.borderRadius ?? BorderRadius.zero,
            child: dropdownStyle.dropdownBuilder?.call(context, dropdownMenu) ?? dropdownMenu,
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    required this.color,
    required this.elevation,
    required this.selectedIndex,
    required this.resize,
    required this.itemHeight,
    required this.dropdownDecoration,
    required this.textDirection,
  })  : _painter = dropdownDecoration
                ?.copyWith(
                  color: dropdownDecoration.color ?? color,
                  boxShadow: dropdownDecoration.boxShadow ?? kElevationToShadow[elevation],
                )
                .createBoxPainter(() {}) ??
            BoxDecoration(
              // If you add an image here, you must provide a real
              // configuration in the paint() function and you must provide some sort
              // of onChanged callback here.
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
              boxShadow: kElevationToShadow[elevation],
            ).createBoxPainter(),
        super(repaint: resize);

  final Color? color;
  final int? elevation;
  final int? selectedIndex;
  final Animation<double> resize;
  final double itemHeight;
  final BoxDecoration? dropdownDecoration;
  final TextDirection? textDirection;

  final BoxPainter _painter;

  @override
  void paint(Canvas canvas, Size size) {
    final Tween<double> top = Tween<double>(
      //Begin at 0.0 instead of selectedItemOffset so that the menu open animation
      //always start from top to bottom instead of starting from the selected item
      begin: 0.0,
      end: 0.0,
    );

    final Tween<double> bottom = Tween<double>(
      begin: clampDouble(top.begin! + itemHeight, math.min(itemHeight, size.height), size.height),
      end: size.height,
    );

    final Rect rect = Rect.fromLTRB(0.0, top.evaluate(resize), size.width, bottom.evaluate(resize));

    _painter.paint(
      canvas,
      rect.topLeft,
      ImageConfiguration(size: rect.size, textDirection: textDirection),
    );
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.itemHeight != itemHeight ||
        oldPainter.dropdownDecoration != dropdownDecoration ||
        oldPainter.textDirection != textDirection ||
        oldPainter.resize != resize;
  }
}
