// ignore_for_file: deprecated_member_use_from_same_package

/*
 * Created by AHMED ELSAYED on 30 Nov 2021.
 * email: ahmedelsaayid@gmail.com
 * Edits made on original source code by Flutter.
 * Copyright 2014 The Flutter Authors. All rights reserved.
*/

import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'dropdown_style_data.dart';
part 'dropdown_route.dart';
part 'dropdown_menu.dart';
part 'dropdown_menu_item.dart';
part 'dropdown_menu_separators.dart';
part 'enums.dart';
part 'utils.dart';

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = kMinInteractiveDimension;
const double _kDenseButtonHeight = 24.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);
const EdgeInsetsGeometry _kAlignedButtonPadding =
    EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;

/// A builder to customize the selected menu item.
typedef SelectedMenuItemBuilder = Widget Function(
    BuildContext context, Widget child);

/// Signature for the callback that's called when when the dropdown menu opens or closes.
typedef OnMenuStateChangeFn = void Function(bool isOpen);

/// Signature for the callback for the match function used for searchable dropdowns.
typedef SearchMatchFn<T> = bool Function(
    DropdownItem<T> item, String searchValue);

/// A Material Design button for selecting from a list of items.
///
/// A dropdown button lets the user select from a number of items. The button
/// shows the currently selected item as well as an arrow that opens a menu for
/// selecting another item.
///
/// One ancestor must be a [Material] widget and typically this is
/// provided by the app's [Scaffold].
///
/// The type `T` is the type of the [value] that each dropdown item represents.
/// All the entries in a given menu must represent values with consistent types.
/// Typically, an enum is used. Each [DropdownItem] in [items] must be
/// specialized with that same type argument.
///
/// The [onChanged] callback should update a state variable that defines the
/// dropdown's value. It should also call [State.setState] to rebuild the
/// dropdown with the new value.
///
/// If the [onChanged] callback is null or the list of [items] is null
/// then the dropdown button will be disabled, i.e. its arrow will be
/// displayed in grey and it will not respond to input. A disabled button
/// will display the [disabledHint] widget if it is non-null. However, if
/// [disabledHint] is null and [hint] is non-null, the [hint] widget will
/// instead be displayed.
///
/// See also:
///
///  * [DropdownButtonFormField2], which integrates with the [Form] widget.
///  * [DropdownItem], the class used to represent the [items].
///  * [DropdownButtonHideUnderline], which prevents its descendant dropdown buttons
///    from displaying their underlines.
///  * [ElevatedButton], [TextButton], ordinary buttons that trigger a single action.
///  * <https://material.io/design/components/menus.html#dropdown-menu>
class DropdownButton2<T> extends StatefulWidget {
  /// Creates a DropdownButton2.
  /// It's customizable DropdownButton with steady dropdown menu and many other features.
  ///
  /// The [items] must have distinct values. If [value] isn't null then it
  /// must be equal to one of the [DropdownItem] values. If [items] or
  /// [onChanged] is null, the button will be disabled, the down arrow
  /// will be greyed out.
  ///
  /// If [value] is null and the button is enabled, [hint] will be displayed
  /// if it is non-null.
  ///
  /// If [value] is null and the button is disabled, [disabledHint] will be displayed
  /// if it is non-null. If [disabledHint] is null, then [hint] will be displayed
  /// if it is non-null.
  DropdownButton2({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.onMenuStateChange,
    this.style,
    this.underline,
    this.isDense = false,
    this.isExpanded = false,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.buttonStyleData,
    this.iconStyleData = const IconStyleData(),
    this.dropdownStyleData = const DropdownStyleData(),
    this.menuItemStyleData = const MenuItemStyleData(),
    this.dropdownSearchData,
    this.dropdownSeparator,
    this.customButton,
    this.openWithLongPress = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    // When adding new arguments, consider adding similar arguments to
    // DropdownButtonFormField.
  })  : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownItem]s were detected '
          'with the same value',
        ),
        _inputDecoration = null,
        _isEmpty = false,
        _isFocused = false;

  DropdownButton2._formField({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    required this.onChanged,
    this.onMenuStateChange,
    this.style,
    this.underline,
    this.isDense = false,
    this.isExpanded = false,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.buttonStyleData,
    required this.iconStyleData,
    required this.dropdownStyleData,
    required this.menuItemStyleData,
    this.dropdownSearchData,
    this.dropdownSeparator,
    this.customButton,
    this.openWithLongPress = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    required InputDecoration inputDecoration,
    required bool isEmpty,
    required bool isFocused,
  })  : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButtonFormField]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownItem]s were detected '
          'with the same value',
        ),
        _inputDecoration = inputDecoration,
        _isEmpty = isEmpty,
        _isFocused = isFocused;

  /// The list of items the user can select.
  ///
  /// If the [onChanged] callback is null or the list of items is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input.
  final List<DropdownItem<T>>? items;

  /// A builder to customize the dropdown buttons corresponding to the
  /// [DropdownItem]s in [items].
  ///
  /// When a [DropdownItem] is selected, the widget that will be displayed
  /// from the list corresponds to the [DropdownItem] of the same index
  /// in [items].
  ///
  /// {@tool dartpad}
  /// This sample shows a [DropdownButton] with a button with [Text] that
  /// corresponds to but is unique from [DropdownItem].
  ///
  /// ** See code in examples/api/lib/material/dropdown/dropdown_button.selected_item_builder.0.dart **
  /// {@end-tool}
  ///
  /// If this callback is null, the [DropdownItem] from [items]
  /// that matches [value] will be displayed.
  final DropdownButtonBuilder? selectedItemBuilder;

  /// The value of the currently selected [DropdownItem].
  ///
  /// If [value] is null and the button is enabled, [hint] will be displayed
  /// if it is non-null.
  ///
  /// If [value] is null and the button is disabled, [disabledHint] will be displayed
  /// if it is non-null. If [disabledHint] is null, then [hint] will be displayed
  /// if it is non-null.
  final T? value;

  /// A placeholder widget that is displayed by the dropdown button.
  ///
  /// If [value] is null and the dropdown is enabled ([items] and [onChanged] are non-null),
  /// this widget is displayed as a placeholder for the dropdown button's value.
  ///
  /// If [value] is null and the dropdown is disabled and [disabledHint] is null,
  /// this widget is used as the placeholder.
  final Widget? hint;

  /// A preferred placeholder widget that is displayed when the dropdown is disabled.
  ///
  /// If [value] is null, the dropdown is disabled ([items] or [onChanged] is null),
  /// this widget is displayed as a placeholder for the dropdown button's value.
  final Widget? disabledHint;

  /// {@template flutter.material.dropdownButton.onChanged}
  /// Called when the user selects an item.
  ///
  /// If the [onChanged] callback is null or the list of [DropdownButton2.items]
  /// is null then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [DropdownButton2.disabledHint] widget if it is non-null.
  /// If [DropdownButton2.disabledHint] is also null but [DropdownButton2.hint] is
  /// non-null, [DropdownButton2.hint] will instead be displayed.
  /// {@endtemplate}
  final ValueChanged<T?>? onChanged;

  /// Called when the dropdown menu opens or closes.
  final OnMenuStateChangeFn? onMenuStateChange;

  /// The text style to use for text in the dropdown button and the dropdown
  /// menu that appears when you tap the button.
  ///
  /// To use a separate text style for selected item when it's displayed within
  /// the dropdown button, consider using [selectedItemBuilder].
  ///
  /// {@tool dartpad}
  /// This sample shows a `DropdownButton` with a dropdown button text style
  /// that is different than its menu items.
  ///
  /// ** See code in examples/api/lib/material/dropdown/dropdown_button.style.0.dart **
  /// {@end-tool}
  ///
  /// Defaults to the [TextTheme.titleMedium] value of the current
  /// [ThemeData.textTheme] of the current [Theme].
  final TextStyle? style;

  /// The widget to use for drawing the drop-down button's underline.
  ///
  /// Defaults to a 0.0 width bottom border with color 0xFFBDBDBD.
  final Widget? underline;

  /// Reduce the button's height.
  ///
  /// By default this button's height is the same as its menu items' heights.
  /// If isDense is true, the button's height is reduced by about half. This
  /// can be useful when the button is embedded in a container that adds
  /// its own decorations, like [InputDecorator].
  final bool isDense;

  /// Set the dropdown's inner contents to horizontally fill its parent.
  ///
  /// By default this button's inner width is the minimum size of its contents.
  /// If [isExpanded] is true, the inner width is expanded to fill its
  /// surrounding container.
  final bool isExpanded;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// By default, platform-specific feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// Defines how the hint or the selected item is positioned within the button.
  ///
  /// This property must not be null. It defaults to [AlignmentDirectional.centerStart].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// Used to configure the theme of the button
  final ButtonStyleData? buttonStyleData;

  /// Used to configure the theme of the button's icon
  final IconStyleData iconStyleData;

  /// Used to configure the theme of the dropdown menu
  final DropdownStyleData dropdownStyleData;

  /// Used to configure the theme of the dropdown menu items
  final MenuItemStyleData menuItemStyleData;

  /// Used to configure searchable dropdowns
  final DropdownSearchData<T>? dropdownSearchData;

  /// Adds separator widget to the dropdown menu.
  ///
  /// Defaults to null.
  final DropdownSeparator<T>? dropdownSeparator;

  /// Uses custom widget like icon,image,etc.. instead of the default button
  final Widget? customButton;

  /// Opens the dropdown menu on long-pressing instead of tapping
  final bool openWithLongPress;

  /// Whether you can dismiss this route by tapping the modal barrier.
  final bool barrierDismissible;

  /// The color to use for the modal barrier. If this is null, the barrier will
  /// be transparent.
  final Color? barrierColor;

  /// The semantic label used for a dismissible barrier.
  ///
  /// If the barrier is dismissible, this label will be read out if
  /// accessibility tools (like VoiceOver on iOS) focus on the barrier.
  final String? barrierLabel;

  final InputDecoration? _inputDecoration;

  final bool _isEmpty;

  final bool _isFocused;

  @override
  State<DropdownButton2<T>> createState() => DropdownButton2State<T>();
}

// ignore: public_member_api_docs
class DropdownButton2State<T> extends State<DropdownButton2<T>>
    with WidgetsBindingObserver {
  int? _selectedIndex;
  _DropdownRoute<T>? _dropdownRoute;
  Orientation? _lastOrientation;
  FocusNode? _internalNode;

  ButtonStyleData? get _buttonStyle => widget.buttonStyleData;

  IconStyleData get _iconStyle => widget.iconStyleData;

  DropdownStyleData get _dropdownStyle => widget.dropdownStyleData;

  MenuItemStyleData get _menuItemStyle => widget.menuItemStyleData;

  DropdownSearchData<T>? get _searchData => widget.dropdownSearchData;

  FocusNode get _focusNode => widget.focusNode ?? _internalNode!;

  late Map<Type, Action<Intent>> _actionMap;

  // Using ValueNotifier for tracking when menu is open/close to update the button icon.
  final ValueNotifier<bool> _isMenuOpen = ValueNotifier<bool>(false);

  // Using ValueNotifier for the Rect of DropdownButton so the dropdown menu listen and
  // update its position if DropdownButton's position has changed, as when keyboard open.
  final ValueNotifier<Rect?> _rect = ValueNotifier<Rect?>(null);

  // Only used if needed to create _internalNode.
  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateSelectedIndex();
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => _handleTap(),
      ),
      ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
        onInvoke: (ButtonActivateIntent intent) => _handleTap(),
      ),
    };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeDropdownRoute();
    _internalNode?.dispose();
    _isMenuOpen.dispose();
    _rect.dispose();
    super.dispose();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
    _lastOrientation = null;
  }

  @override
  void didUpdateWidget(DropdownButton2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    if (widget.items == null ||
        widget.items!.isEmpty ||
        (widget.value == null &&
            widget.items!
                .where((DropdownItem<T> item) =>
                    item.enabled && item.value == widget.value)
                .isEmpty)) {
      _selectedIndex = null;
      return;
    }

    assert(widget.items!
            .where((DropdownItem<T> item) => item.value == widget.value)
            .length ==
        1);
    for (int itemIndex = 0; itemIndex < widget.items!.length; itemIndex++) {
      if (widget.items![itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  @override
  void didChangeMetrics() {
    //This fix the bug of calling didChangeMetrics() on iOS when app starts
    if (_rect.value == null) {
      return;
    }
    final Rect newRect = _getRect();
    //This avoid unnecessary rebuilds if _rect position hasn't changed
    if (_rect.value!.top == newRect.top) {
      return;
    }
    _rect.value = newRect;
  }

  TextStyle? get _textStyle =>
      widget.style ?? Theme.of(context).textTheme.titleMedium;

  Rect _getRect() {
    final TextDirection? textDirection = Directionality.maybeOf(context);
    const EdgeInsetsGeometry menuMargin = EdgeInsets.zero;
    final NavigatorState navigator = Navigator.of(context,
        rootNavigator:
            _dropdownStyle.isFullScreen ?? _dropdownStyle.useRootNavigator);

    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(Offset.zero,
            ancestor: navigator.context.findRenderObject()) &
        itemBox.size;

    return menuMargin.resolve(textDirection).inflateRect(itemRect);
  }

  double _getMenuHorizontalPadding() {
    final double menuHorizontalPadding =
        (_menuItemStyle.padding?.horizontal ?? _kMenuItemPadding.horizontal) +
            (_dropdownStyle.padding?.horizontal ?? 0.0) +
            (_dropdownStyle.scrollPadding?.horizontal ?? 0.0);
    return menuHorizontalPadding / 2;
  }

  void _handleTap() {
    final NavigatorState navigator = Navigator.of(context,
        rootNavigator:
            _dropdownStyle.isFullScreen ?? _dropdownStyle.useRootNavigator);

    final items = widget.items!;
    final separator = widget.dropdownSeparator;
    _rect.value = _getRect();

    assert(_dropdownRoute == null);
    _dropdownRoute = _DropdownRoute<T>(
      items: items,
      buttonRect: _rect,
      selectedIndex: _selectedIndex ?? 0,
      isNoSelectedItem: _selectedIndex == null,
      capturedThemes:
          InheritedTheme.capture(from: context, to: navigator.context),
      style: _textStyle!,
      barrierDismissible: widget.barrierDismissible,
      barrierColor: widget.barrierColor,
      barrierLabel: widget.barrierLabel ??
          MaterialLocalizations.of(context).modalBarrierDismissLabel,
      parentFocusNode: _focusNode,
      enableFeedback: widget.enableFeedback ?? true,
      dropdownStyle: _dropdownStyle,
      menuItemStyle: _menuItemStyle,
      searchData: _searchData,
      dropdownSeparator: separator,
    );

    _isMenuOpen.value = true;
    _focusNode.requestFocus();
    // This is a temporary fix for the "dropdown menu steal the focus from the
    // underlying button" issue, until share focus is fixed in flutter (#106923).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dropdownRoute?._childNode.requestFocus();
    });
    navigator
        .push(_dropdownRoute!)
        .then<void>((_DropdownRouteResult<T>? newValue) {
      _removeDropdownRoute();
      _isMenuOpen.value = false;
      widget.onMenuStateChange?.call(false);
      if (!mounted || newValue == null) {
        return;
      }
      widget.onChanged?.call(newValue.result);
    });

    widget.onMenuStateChange?.call(true);
  }

  /// Exposes the _handleTap() to Allow opening the button programmatically using GlobalKey.
  // Note: DropdownButton2State should be public as we need typed access to it through key.
  void callTap() => _handleTap();

  // When isDense is true, reduce the height of this button from _kMenuItemHeight to
  // _kDenseButtonHeight, but don't make it smaller than the text that it contains.
  // Similarly, we don't reduce the height of the button so much that its icon
  // would be clipped.
  double get _denseButtonHeight {
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final double fontSize = _textStyle!.fontSize ??
        Theme.of(context).textTheme.titleMedium!.fontSize!;
    final double scaledFontSize = textScaleFactor * fontSize;
    return math.max(
        scaledFontSize, math.max(_iconStyle.iconSize, _kDenseButtonHeight));
  }

  Color get _iconColor {
    // These colors are not defined in the Material Design spec.
    if (_enabled) {
      if (_iconStyle.iconEnabledColor != null) {
        return _iconStyle.iconEnabledColor!;
      }

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade700;
        case Brightness.dark:
          return Colors.white70;
      }
    } else {
      if (_iconStyle.iconDisabledColor != null) {
        return _iconStyle.iconDisabledColor!;
      }

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade400;
        case Brightness.dark:
          return Colors.white10;
      }
    }
  }

  bool get _enabled =>
      widget.items != null &&
      widget.items!.isNotEmpty &&
      widget.onChanged != null;

  Orientation _getOrientation(BuildContext context) {
    // TODO(Ahmed): use maybeOrientationOf [flutter>=v3.10.0].
    Orientation? result = MediaQuery.maybeOf(context)?.orientation;
    if (result == null) {
      // If there's no MediaQuery, then use the window aspect to determine
      // orientation.
      // TODO(Ahmed): use View.of(context) and update the comment [flutter>=v3.10.0].
      // ignore: deprecated_member_use
      final Size size = WidgetsBinding.instance.window.physicalSize;
      result = size.width > size.height
          ? Orientation.landscape
          : Orientation.portrait;
    }
    return result;
  }

  BorderRadius? _getButtonBorderRadius(BuildContext context) {
    final buttonRadius = _buttonStyle?.decoration?.borderRadius;
    if (buttonRadius != null) {
      return buttonRadius.resolve(Directionality.of(context));
    }

    final inputBorder = widget._inputDecoration?.border;
    if (inputBorder?.isOutline ?? false) {
      return (inputBorder! as OutlineInputBorder).borderRadius;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));

    final Orientation newOrientation = _getOrientation(context);
    _lastOrientation ??= newOrientation;
    if (newOrientation != _lastOrientation) {
      _removeDropdownRoute();
      _lastOrientation = newOrientation;
    }

    // The width of the button and the menu are defined by the widest
    // item and the width of the hint.
    // We should explicitly type the items list to be a list of <Widget>,
    // otherwise, no explicit type adding items maybe trigger a crash/failure
    // when hint and selectedItemBuilder are provided.
    final List<Widget> buttonItems = widget.selectedItemBuilder == null
        ? (widget.items != null ? List<Widget>.of(widget.items!) : <Widget>[])
        : List<Widget>.of(widget.selectedItemBuilder!(context));

    int? hintIndex;
    if (widget.hint != null || (!_enabled && widget.disabledHint != null)) {
      final Widget displayedHint =
          _enabled ? widget.hint! : widget.disabledHint ?? widget.hint!;

      hintIndex = buttonItems.length;
      buttonItems.add(DefaultTextStyle(
        style: _textStyle!.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          child: displayedHint,
        ),
      ));
    }

    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    final buttonHeight =
        _buttonStyle?.height ?? (widget.isDense ? _denseButtonHeight : null);

    Widget item = buttonItems[_selectedIndex ?? hintIndex ?? 0];
    if (item is DropdownItem) {
      item = item.copyWith(alignment: widget.alignment);
    }

    // If value is null (then _selectedIndex is null) then we
    // display the hint or nothing at all.
    final Widget innerItemsWidget;
    if (buttonItems.isEmpty) {
      innerItemsWidget = const SizedBox.shrink();
    } else {
      innerItemsWidget = Padding(
        // When buttonWidth & dropdownWidth is null, their width will be calculated
        // from the maximum width of menu items or the hint text (width of IndexedStack).
        // We need to add MenuHorizontalPadding so menu width adapts to max items width with padding properly
        padding: EdgeInsets.symmetric(
          horizontal:
              _buttonStyle?.width == null && _dropdownStyle.width == null
                  ? _getMenuHorizontalPadding()
                  : 0.0,
        ),
        // When both buttonHeight & buttonWidth are specified, we don't have to use IndexedStack,
        // which enhances the performance when dealing with big items list.
        // Note: Both buttonHeight & buttonWidth must be specified to avoid changing
        // button's size when selecting different items, which is a bad UX.
        child: buttonHeight != null && _buttonStyle?.width != null
            ? Align(
                alignment: widget.alignment,
                child: item,
              )
            : IndexedStack(
                index: _selectedIndex ?? hintIndex,
                alignment: widget.alignment,
                children: buttonHeight != null
                    ? buttonItems.mapIndexed((item, index) => item).toList()
                    // TODO(Ahmed): use indexed from Flutter [Dart>=v3.0.0].
                    : buttonItems.mapIndexed((item, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[item],
                        );
                      }).toList(),
              ),
      );
    }

    Widget result = DefaultTextStyle(
      style: _enabled
          ? _textStyle!
          : _textStyle!.copyWith(color: Theme.of(context).disabledColor),
      child: widget.customButton ??
          Container(
            decoration: _buttonStyle?.decoration?.copyWith(
              boxShadow: _buttonStyle!.decoration!.boxShadow ??
                  kElevationToShadow[_buttonStyle!.elevation ?? 0],
            ),
            padding: _buttonStyle?.padding ??
                padding.resolve(Directionality.of(context)),
            height: buttonHeight,
            width: _buttonStyle?.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.isExpanded)
                  Expanded(child: innerItemsWidget)
                else
                  innerItemsWidget,
                IconTheme(
                  data: IconThemeData(
                    color: _iconColor,
                    size: _iconStyle.iconSize,
                  ),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _isMenuOpen,
                    builder: (BuildContext context, bool isOpen, _) {
                      return _iconStyle.openMenuIcon != null
                          ? isOpen
                              ? _iconStyle.openMenuIcon!
                              : _iconStyle.icon
                          : _iconStyle.icon;
                    },
                  ),
                ),
              ],
            ),
          ),
    );

    if (!DropdownButtonHideUnderline.at(context)) {
      final double bottom = widget.isDense ? 0.0 : 8.0;
      result = Stack(
        children: <Widget>[
          result,
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: bottom,
            child: widget.underline ??
                Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFBDBDBD),
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
          ),
        ],
      );
    }

    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor>(
      MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!_enabled) MaterialState.disabled,
      },
    );

    if (widget._inputDecoration != null) {
      result = InputDecorator(
        decoration: widget._inputDecoration!,
        isEmpty: widget._isEmpty,
        isFocused: widget._isFocused,
        child: result,
      );
    }

    return Semantics(
      button: true,
      child: Actions(
        actions: _actionMap,
        child: InkWell(
          mouseCursor: effectiveMouseCursor,
          onTap: _enabled && !widget.openWithLongPress ? _handleTap : null,
          onLongPress: _enabled && widget.openWithLongPress ? _handleTap : null,
          canRequestFocus: _enabled,
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          overlayColor: _buttonStyle?.overlayColor,
          enableFeedback: false,
          borderRadius: _getButtonBorderRadius(context),
          child: result,
        ),
      ),
    );
  }
}

/// A [FormField] that contains a [DropdownButton2].
///
/// This is a convenience widget that wraps a [DropdownButton2] widget in a
/// [FormField].
///
/// A [Form] ancestor is not required. The [Form] allows one to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// See also:
///
///  * [DropdownButton2], which is the underlying text field without the [Form]
///    integration.
class DropdownButtonFormField2<T> extends FormField<T> {
  /// Creates a [DropdownButton2] widget that is a [FormField], wrapped in an
  /// [InputDecorator].
  ///
  /// For a description of the `onSaved`, `validator`, or `autovalidateMode`
  /// parameters, see [FormField]. For the rest (other than [decoration]), see
  /// [DropdownButton2].
  ///
  /// The `items`, `elevation`, `iconSize`, `isDense`, `isExpanded`,
  /// `autofocus`, and `decoration`  parameters must not be null.
  DropdownButtonFormField2({
    super.key,
    this.dropdownButtonKey,
    required List<DropdownItem<T>>? items,
    DropdownButtonBuilder? selectedItemBuilder,
    T? value,
    Widget? hint,
    Widget? disabledHint,
    this.onChanged,
    OnMenuStateChangeFn? onMenuStateChange,
    TextStyle? style,
    bool isDense = true,
    bool isExpanded = false,
    FocusNode? focusNode,
    bool autofocus = false,
    InputDecoration? decoration,
    super.onSaved,
    super.validator,
    AutovalidateMode? autovalidateMode,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    ButtonStyleData? buttonStyleData,
    IconStyleData iconStyleData = const IconStyleData(),
    DropdownStyleData dropdownStyleData = const DropdownStyleData(),
    MenuItemStyleData menuItemStyleData = const MenuItemStyleData(),
    DropdownSearchData<T>? dropdownSearchData,
    DropdownSeparator<T>? dropdownSeparator,
    Widget? customButton,
    bool openWithLongPress = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
  })  : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownItem]s were detected '
          'with the same value',
        ),
        decoration = _getInputDecoration(decoration, buttonStyleData),
        super(
          initialValue: value,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<T> field) {
            final _DropdownButtonFormFieldState<T> state =
                field as _DropdownButtonFormFieldState<T>;
            final InputDecoration decorationArg =
                _getInputDecoration(decoration, buttonStyleData);
            final InputDecoration effectiveDecoration =
                decorationArg.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            final bool showSelectedItem = items != null &&
                items
                    .where((DropdownItem<T> item) => item.value == state.value)
                    .isNotEmpty;
            bool isHintOrDisabledHintAvailable() {
              final bool isDropdownDisabled =
                  onChanged == null || (items == null || items.isEmpty);
              if (isDropdownDisabled) {
                return hint != null || disabledHint != null;
              } else {
                return hint != null;
              }
            }

            final bool isEmpty =
                !showSelectedItem && !isHintOrDisabledHintAvailable();

            // An unFocusable Focus widget so that this widget can detect if its
            // descendants have focus or not.
            return Focus(
              canRequestFocus: false,
              skipTraversal: true,
              child: Builder(
                builder: (BuildContext context) {
                  return InputDecorator(
                    decoration: const InputDecoration.collapsed(hintText: '')
                        .copyWith(errorText: field.errorText),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<T>._formField(
                        key: dropdownButtonKey,
                        items: items,
                        selectedItemBuilder: selectedItemBuilder,
                        value: state.value,
                        hint: hint,
                        disabledHint: disabledHint,
                        onChanged: onChanged == null ? null : state.didChange,
                        onMenuStateChange: onMenuStateChange,
                        style: style,
                        isDense: isDense,
                        isExpanded: isExpanded,
                        focusNode: focusNode,
                        autofocus: autofocus,
                        enableFeedback: enableFeedback,
                        alignment: alignment,
                        buttonStyleData: buttonStyleData,
                        iconStyleData: iconStyleData,
                        dropdownStyleData: dropdownStyleData,
                        menuItemStyleData: menuItemStyleData,
                        dropdownSearchData: dropdownSearchData,
                        dropdownSeparator: dropdownSeparator,
                        customButton: customButton,
                        openWithLongPress: openWithLongPress,
                        barrierDismissible: barrierDismissible,
                        barrierColor: barrierColor,
                        barrierLabel: barrierLabel,
                        inputDecoration: effectiveDecoration,
                        isEmpty: isEmpty,
                        isFocused: Focus.of(context).hasFocus,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );

  /// The key of DropdownButton2 child widget
  ///
  /// This allows accessing DropdownButton2State.
  /// It is useful for some cases, i.e: calling callTap() method to open the menu programmatically
  final Key? dropdownButtonKey;

  /// {@macro flutter.material.dropdownButton.onChanged}
  final ValueChanged<T?>? onChanged;

  /// The decoration to show around the dropdown button form field.
  ///
  /// By default, draws a horizontal line under the dropdown button field but
  /// can be configured to show an icon, label, hint text, and error text.
  ///
  /// If not specified, an [InputDecorator] with the `focusColor` and `hoverColor`
  /// set to the supplied `buttonStyleData.overlayColor` (if any) will be used.
  final InputDecoration decoration;

  static InputDecoration _getInputDecoration(
      InputDecoration? decoration, ButtonStyleData? buttonStyleData) {
    return decoration ??
        InputDecoration(
          focusColor: buttonStyleData?.overlayColor
              ?.resolve(<MaterialState>{MaterialState.focused}),
          hoverColor: buttonStyleData?.overlayColor
              ?.resolve(<MaterialState>{MaterialState.hovered}),
        );
  }

  @override
  FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}

class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  void didChange(T? value) {
    super.didChange(value);
    final DropdownButtonFormField2<T> dropdownButtonFormField =
        widget as DropdownButtonFormField2<T>;
    assert(dropdownButtonFormField.onChanged != null);
    dropdownButtonFormField.onChanged!(value);
  }

  @override
  void didUpdateWidget(DropdownButtonFormField2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}
