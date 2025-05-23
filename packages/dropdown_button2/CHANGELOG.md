## UNRELEASED

- Avoid dropdown internal FocusNode listener leak when replaced by an external FocusNode

## 3.0.0-beta.22

- Fix errorStyle has no effect for DropdownButtonFormField2, closes #327.
- DropdownRoutePage should dispose the created ScrollController [Flutter core].
- Remove 'must be non-null' and 'must not be null' comments [Flutter core].
- Form fields onChange callback should be called on reset [Flutter core].
- Implement switch expressions.
- Fix memory leak in CurvedAnimation [Flutter core].
- Avoid Container objects when possible for better performance [Flutter core].
- Add semantics to dropdown menu items [Flutter core].
- Support helperStyle/helperMaxLines/errorMaxLines for DropdownButtonFormField2.
- Add `MenuItemStyleData.useDecorationHorizontalPadding`, used to determine whether to use the horizontal padding from "decoration.contentPadding" for menu items when using `DropdownButtonFormField2`.
- Use decoration hint text as the default value for dropdown button hints [Flutter core].
- Update SDK constraints: ">=3.4.0 <4.0.0"
- Fix DropdownButtonFormField clips text when large text scale is used [Flutter core].
- Fix DropdownButtonFormField padding when ButtonTheme.alignedDropdown is true [Flutter core].
- Add barrierCoversButton to DropdownButtonFormField2.
- Respect button's borderRadius when barrierCoversButton is false.
- Respect inputDecoration's borderRadius when barrierCoversButton is false.
- Support BorderRadiusDirectional for dropdown menu.
- Fix barrier when using TextDirection.rtl while barrierCoversButton set to false.
- Take InputDecoration's densityOffset into account when determining the button size.

## 3.0.0-beta.21

- Fix menu limits when using searchable dropdown with separators, closes #214.

## 3.0.0-beta.20

- Remove an assert from updateSelectedIndex method.
- Update examples.

## 3.0.0-beta.19

- Enhance the display of error/helper elements at DropdownButtonFormField2, closes #199.

## 3.0.0-beta.18

- Replaces textScaleFactor with TextScaler [Flutter core].
- Fix DropdownButtonFormField2 ink response radius for different input borders.
- Fix error border not showing for DropdownButtonFormField2, closes #297 & #319.

## 3.0.0-beta.17

- Enhance scroll position when using searchable dropdown, closes #285.
- Temporarily fix ink splash gets displayed over search widget, closes #290.
- Add copyWith method for style data classes, closes #314.

## 3.0.0-beta.16

- Fix dropdown menu position when window changes horizontally, closes #243.

## 3.0.0-beta.15

- Always call `onChanged` when tapping enabled item, closes #275.

## 3.0.0-beta.14

- Optimize scroll performance when dealing with large items list.
- Update SDK constraints: ">=3.2.0 <4.0.0"

## 3.0.0-beta.13

- **BREAKING**: Add `openDropdownListenable` property that can be used to programmatically open the dropdown menu.

  Instead of:

  ```dart
  final dropdownKey = GlobalKey<DropdownButton2State>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        DropdownButton2<String>(
          // Other properties...
          key: dropdownKey,
        );
        // Open the dropdown programmatically, like when another button is pressed:
        ElevatedButton(
          onTap: () => dropdownKey.currentState!.callTap(),
        ),
      ],
    );
  }
  ```

  do:

  ```dart
  final openDropdownListenable = ValueNotifier<Object?>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        DropdownButton2<String>(
          // Other properties...
          openDropdownListenable: openDropdownListenable,
        );
        // Open the dropdown programmatically, like when another button is pressed:
        ElevatedButton(
          onTap: () => openDropdownListenable.value = Object(),
        ),
      ],
    );
  }
  ```

## 3.0.0-beta.12

- Add `dropdownBuilder` property for DropdownStyleData, it can be used to customize the dropdown menu.

## 3.0.0-beta.11

- Introduce `valueListenable` and `multiValueListenable`, which replaces SetState with ValueListenable.
- Support implementing select all option (Check multi-select example), closes #121 and #167.

## 3.0.0-beta.10

- Add the possibility to display a dropdown menu centered through `DropdownDirection.center`.
- Add `barrierCoversButton` property, used to specify whether the modal barrier should cover the dropdown button or not.

## 3.0.0-beta.9

- Update DropdownItem to respect intrinsicHeight.
- Update added menu padding to include button icon.

## 3.0.0-beta.8

- Add `foregroundDecoration` property for ButtonStyleData.

## 3.0.0-beta.7

- Add intrinsicHeight property to DropdownItem. This enables setting item's height according to its intrinsic height.

## 3.0.0-beta.6

- Fix isExpanded and alignment functionality.

## 3.0.0-beta.5

- Enhance rendering performance when dealing with big items list.

## 3.0.0-beta.4

- Add `noResultsWidget` property for DropdownSearchData. It can be used to show some widget when the search results are empty.
- Rename searchInnerWidget[Height] to searchBarWidget[Height].

## 3.0.0-beta.3

- Fix inkwell covers error message.

## 3.0.0-beta.2

- Add border radius parameter for menu item.

## 3.0.0-beta.1

- Fix formatting.

## 3.0.0-beta.0

- **BREAKING**: Replaces DropdownMenuItem with DropdownItem to provide extra functionality.

  Instead of:

  ```dart
  items: items.map((String item) => DropdownMenuItem<String>(...)).toList(),
  ```

  do:

  ```dart
  items: items.map((String item) => DropdownItem<String>(...)).toList(),
  ```

- Add `closeOnTap` property to DropdownItem. It controls whether the dropdown should close when the item is tapped.

- **BREAKING**: Support setting different heights for items.

  Instead of:

  ```dart
  items: items
    .map((String item) => DropdownItem<String>(
        value: item,
        child: Text(item),
      ))
    .toList(),
  menuItemStyleData: const MenuItemStyleData(
    height: 40,
  ),
  ```

  do:

  ```dart
  items: items
    .map((String item) => DropdownItem<String>(
          value: item,
          height: 40,
          child: Text(item),
        ))
    .toList(),
  ```

- Support adding separator widget internally, closes #134.

- Update highlight behavior, closes #184.

## 2.3.9

- Use melos to separate package golden tests, closes #176.

## 2.3.8

- Use null-aware operators for thumbVisibility and thickness.

## 2.3.7

- Remove deprecated isAlwaysShown member.

## 2.3.6

- Remove unnecessary packages from `dependencies`.

## 2.3.5

- Fix ScrollBar theming.

## 2.3.4

- `isFullScreen` should be null by default, fixes #157.

## 2.3.3

- Support ScrollBar theming for Cupertino, closes #154.

## 2.3.1

- Update gitignore/pubignore, fixes #153.

## 2.2.2

- Ignore goldens and assets for pub.dev (reduces package size)

## 2.2.1

- Fix README images.

## 2.2.0

- Update DropdownButtonFormField2 decoration behavior. (#152)
- Squashed MediaQuery InheritedModel [Flutter core].
- Fix rebuild issue of openMenuIcon.
- Fix ink response radius for DropdownButtonFormField2.
- Update README and examples.

## 2.1.4

- Fix button falsely maintaining focus, closes #152.

## 2.1.3

- Fix assertion failure when dropdownStyleData's decoration has an image.
- Fix IgnorePointer to only block user interactions (Flutter Dropdown Update).

## 2.1.2

- Revert "Remove the deprecated window" and ignore instead.

## 2.1.1

- Remove the deprecated `window`.

## 2.1.0

- Update dropdown menu's vertical extent.

## 2.0.1

- `DropdownStyleData.isFullScreen` is deprecated in favor of `DropdownStyleData.useRootNavigator`.
- Add `DropdownStyleData.useSafeArea`, used to determine if the dropdown menu should only display in
  safe areas of the screen.

## 2.0.0

### Breaking Changes:

- Refactor & organize related parameters to sub-classes (check Options at README).
- Prefer overlayColor for button/menuItem's ink response (supports desktop/web inkwell behavior
  customization).
- Add scrollbarTheme parameter, used to configures scrollbar's theme (#113).
- Add openInterval parameter, used to configure menu animation speed (#128).
- Add selectedMenuItemBuilder parameter, used to customize the selected menu item (#124).
- Improve SearchMatchFn's type inference.
- Replace deprecated subtitle1 by titleMedium.
- Update README.

## 1.9.4

- Use generics with searchMatchFn for item type inference.

## 1.9.3

- Add searchBarWidgetHeight, it fixes menu limits and scroll offset when using searchBarWidget.

## 1.9.2

- Avoid overlapping menu items with keyboard when using searchable dropdown.

## 1.9.1

- Add dropdownButtonKey parameter to DropdownButtonFormField2, it allows accessing
  DropdownButton2State.
- Update README.

## 1.9.0

- Adapt to max items width when buttonWidth & dropdownWidth is null.
- Prevent dropdownWidth to exceed max screen width.
- Add dropdownDirection parameter, it controls the direction of the dropdown menu in relation to the
  button.
- Update README.

## 1.8.9

- Add buttonOverlayColor parameter, It changes the overlay color of the button's InkWell.
- Update README.

## 1.8.8

- Update README.

## 1.8.7

- Add buttonSplashColor parameter, It changes the splash color of the button's InkWell. close #79,
  #89.
- Add buttonHighlightColor parameter, It changes the highlight color of the button's InkWell. close
  #79, #89.

## 1.8.6

- Add itemSplashColor parameter, It changes the splash color of the item's InkWell. close #79, #89.
- Add itemHighlightColor parameter, It changes the highlight color of the item's InkWell. close #79,
  #89.

## 1.8.5

- Fix typo in clampDouble method call, fixes #88.

## 1.8.4

- Fix Dropdown menu dx offset range, fixes #86.

## 1.8.3

- Fix the ability to increase dy offset for some cases, fixes #85.

## 1.8.2

- define clampDouble within DropdownButton2 library.

## 1.8.1

- Add dropdownScrollPadding parameter, it add padding to the dropdown menu including the scrollbar.
- Update README.

## 1.8.0

### Breaking Changes:

- Remove customItemsIndexes and customItemsHeight parameters.
- Add customItemsHeights parameter, it uses different predefined heights for the menu items. close
  #71.
- Switched to a double variant of clamp to avoid boxing (Flutter Dropdown Update).
- Replace empty Container with const SizedBox (Flutter Dropdown Update).
- Update README.

## 1.7.2

- Fix DropdownButtonFormField ripple effect offset to top by 1px, fixes #65.

## 1.7.1

- Fix DropdownButtonFormField InkWell spreads to error message, fixes #56.
- Prevent Selected item from rendering before rest of the list items, fixes #57.

## 1.7.0

- Update DropdownButton menu clip (Flutter Dropdown Update).
- Fix hint alignment when selectedItemBuilder is non-null (Flutter Dropdown Update).
- Modify calculation of dense button height when text scale is large (Flutter Dropdown Update).
- Updating PrimaryScrollController for Desktop, fixes #49.
- Fix DropdownButton inkwell border radius. fixes #53, fixes #54.

## 1.6.3

- Fix openWithLongPress functionality. close #46.

## 1.6.2

- Use buttonDecoration's boxShadow value (if exists) for button's decoration, otherwise use
  buttonElevation.

## 1.6.1

- Fix #39.
- Update README.

## 1.6.0

### Breaking Changes:

- Add searching feature:

* searchController parameter, The TextEditingController used for searchable dropdowns. If null, then
  it'll perform as a normal dropdown without searching feature.
* searchBarWidget parameter, The widget to be shown at the top of the dropdown menu for searchable
  dropdowns, such as search bar.
* searchMatchFn parameter, The match function used for searchable dropdowns, if null \_
  defaultSearchMatchFn will be used.

- Improve selectedItemOffset to get accurate scrollOffset when dropdown padding is set.
- Update README.

## 1.5.3

- Add barrierDismissible parameter, you can prevent dismissing the menu by tapping the modal
  barrier.
- Add barrierColor parameter, you can change the color of the modal barrier (default is transparent)
  . close #35.
- Add barrierLabel parameter, you can set the semantic label used for a dismissible barrier.
- Update README.

## 1.5.2

- Allow opening the button programmatically using GlobalKey. close #33.

## 1.5.1

- Use PlatformDispatcher.instance over window.
- Use super parameters lint.
- Add Multiselect Dropdown with Checkboxes Example.
- Update README.

## 1.5.0

### Breaking Changes:

- Flutter 3.0.0 upgrade.
- Update README.

## 1.4.0

### Breaking Changes:

- Remove onTap parameter.
- Remove onMenuClose parameter.
- Add onMenuStateChange parameter, It's called when the dropdown menu is opened or closed. close
  #24.
- Update README.

## 1.3.0

- Prevent scrollbar and ripple effect from going beyond the menu rounded border boundaries when
  scrolling. fix #21.

## 1.2.5

- Update docs & README.

## 1.2.4

- Update docs & README.

## 1.2.3

- Add dropdownFullScreen parameter, if true, menu will open in fullscreen mode (Above AppBar &
  TabBar). close #20.
- Update README.

## 1.2.2

- Add selectedItemHighlightColor parameter, It specifies highlight color of the current selected
  item.
- Update README.

## 1.2.1

- Add onMenuClose parameter, It calls a function when the dropdown menu is closed.
- Update README.

## 1.2.0

### Breaking Changes:

- Fix tappable area for DropdownButtonFormField & add InkWell to
  DropdownButton [Flutter Dropdown Update].
- Inline casts on Element.widget getter to improve web performance [Flutter Dropdown Update].
- Fix DropdownButtonFormField loses highlight when menu opens and stays highlighted after menu
  closes.
- Add iconOnClick parameter, It toggles different icon when dropdown menu open, close #12.
- Update README.

## 1.1.1

- Prevent first item to be highlighted when there's no item selected on web and desktop mode (when
  FocusHighlightMode is set to traditional).
- Prevent button's color to change to focusColor when selecting items on web and desktop mode (when
  FocusHighlightMode is set to traditional).

## 1.1.0

### Breaking Changes:

- Rename itemWidth to dropdownWidth for clearness.
- Prevent items from going beyond the menu rounded border boundaries when scrolling.
- Remove borderRadius from first and last item of the dropdown menu.
- Change List.from to List.of "Dart lint".
- Update README.

## 1.0.7

- BoxShadow can now be added to dropdownDecoration, and if so, it will be used instead of
  dropdownElevation.

## 1.0.6

- Update README

## 1.0.5

- Change some parameters names to be more clear.
- Add dropdown decoration as BoxDecoration parameter.
- Add Options table to README.
- Add "How to use DropdownButton2 with dividers" to README Examples.

## 1.0.2

- Add "How to use DropdownButtonFormField2 with Form" to README Examples.

## 1.0.1

- Update README

## 1.0.0

- initRelease
