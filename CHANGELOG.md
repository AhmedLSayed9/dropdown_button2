## 1.9.4
* Use generics with searchMatchFn for item type inference.

## 1.9.3
* Add searchInnerWidgetHeight, it fixes menu limits and scroll offset when using searchInnerWidget.

## 1.9.2
* Avoid overlapping menu items with keyboard when using searchable dropdown.

## 1.9.1
* Add dropdownButtonKey parameter to DropdownButtonFormField2, it allows accessing DropdownButton2State.
* Update README.

## 1.9.0
* Adapt to max items width when buttonWidth & dropdownWidth is null.
* Prevent dropdownWidth to exceed max screen width.
* Add dropdownDirection parameter, it controls the direction of the dropdown menu in relation to the button.
* Update README.

## 1.8.9
* Add buttonOverlayColor parameter, It changes the overlay color of the button's InkWell.
* Update README.

## 1.8.8
* Update README.

## 1.8.7
* Add buttonSplashColor parameter, It changes the splash color of the button's InkWell. close #79, #89.
* Add buttonHighlightColor parameter, It changes the highlight color of the button's InkWell. close #79, #89.

## 1.8.6
* Add itemSplashColor parameter, It changes the splash color of the item's InkWell. close #79, #89.
* Add itemHighlightColor parameter, It changes the highlight color of the item's InkWell. close #79, #89.

## 1.8.5
* Fix typo in clampDouble method call, fixes #88.

## 1.8.4
* Fix Dropdown menu dx offset range, fixes #86.

## 1.8.3
* Fix the ability to increase dy offset for some cases, fixes #85.

## 1.8.2
* define clampDouble within DropdownButton2 library.

## 1.8.1
* Add dropdownScrollPadding parameter, it add padding to the dropdown menu including the scrollbar.
* Update README.

## 1.8.0
### Breaking Changes:
* Remove customItemsIndexes and customItemsHeight parameters.
* Add customItemsHeights parameter, it uses different predefined heights for the menu items. close #71.
* Switched to a double variant of clamp to avoid boxing (Flutter Dropdown Update).
* Replace empty Container with const SizedBox (Flutter Dropdown Update).
* Update README.

## 1.7.2
* Fix DropdownButtonFormField ripple effect offset to top by 1px, fixes #65.

## 1.7.1
* Fix DropdownButtonFormField InkWell spreads to error message, fixes #56.
* Prevent Selected item from rendering before rest of the list items, fixes #57.

## 1.7.0
* Update DropdownButton menu clip (Flutter Dropdown Update).
* Fix hint alignment when selectedItemBuilder is non-null (Flutter Dropdown Update).
* Modify calculation of dense button height when text scale is large (Flutter Dropdown Update).
* Updating PrimaryScrollController for Desktop, fixes #49.
* Fix DropdownButton inkwell border radius. fixes #53, fixes #54.

## 1.6.3
* Fix openWithLongPress functionality. close #46.

## 1.6.2
* Use buttonDecoration's boxShadow value (if exists) for button's decoration, otherwise use buttonElevation.

## 1.6.1
* Fix #39.
* Update README.

## 1.6.0
### Breaking Changes:
* Add searching feature:
- searchController parameter, The TextEditingController used for searchable dropdowns. If null, then it'll perform as a normal dropdown without searching feature.
- searchInnerWidget parameter, The widget to be shown at the top of the dropdown menu for searchable dropdowns, such as search bar.
- searchMatchFn parameter, The match function used for searchable dropdowns, if null _defaultSearchMatchFn will be used.
* Improve selectedItemOffset to get accurate scrollOffset when dropdown padding is set.
* Update README.

## 1.5.3
* Add barrierDismissible parameter, you can prevent dismissing the menu by tapping the modal barrier.
* Add barrierColor parameter, you can change the color of the modal barrier (default is transparent). close #35.
* Add barrierLabel parameter, you can set the semantic label used for a dismissible barrier.
* Update README.

## 1.5.2
* Allow opening the button programmatically using GlobalKey. close #33.

## 1.5.1
* Use PlatformDispatcher.instance over window.
* Use super parameters lint.
* Add Multiselect Dropdown with Checkboxes Example.
* Update README.

## 1.5.0
### Breaking Changes:
* Flutter 3.0.0 upgrade.
* Update README.

## 1.4.0
### Breaking Changes:
* Remove onTap parameter.
* Remove onMenuClose parameter.
* Add onMenuStateChange parameter, It's called when the dropdown menu is opened or closed. close #24.
* Update README.

## 1.3.0
* Prevent scrollbar and ripple effect from going beyond the menu rounded border boundaries when scrolling. fix #21.

## 1.2.5
* Update docs & README.

## 1.2.4
* Update docs & README.

## 1.2.3
* Add dropdownFullScreen parameter, if true, menu will open in fullscreen mode (Above AppBar & TabBar). close #20.
* Update README.

## 1.2.2
* Add selectedItemHighlightColor parameter, It specifies highlight color of the current selected item.
* Update README.

## 1.2.1
* Add onMenuClose parameter, It calls a function when the dropdown menu is closed.
* Update README.

## 1.2.0
### Breaking Changes:
* Fix tappable area for DropdownButtonFormField & add InkWell to DropdownButton [Flutter Dropdown Update].
* Inline casts on Element.widget getter to improve web performance [Flutter Dropdown Update].
* Fix DropdownButtonFormField loses highlight when menu opens and stays highlighted after menu closes.
* Add iconOnClick parameter, It toggles different icon when dropdown menu open, close #12.
* Update README.

## 1.1.1
* Prevent first item to be highlighted when there's no item selected on web and desktop mode (when FocusHighlightMode is set to traditional).
* Prevent button's color to change to focusColor when selecting items on web and desktop mode (when FocusHighlightMode is set to traditional).

## 1.1.0
### Breaking Changes:
* Rename itemWidth to dropdownWidth for clearness.
* Prevent items from going beyond the menu rounded border boundaries when scrolling.
* Remove borderRadius from first and last item of the dropdown menu.
* Change List.from to List.of "Dart lint".
* Update README.

## 1.0.7
* BoxShadow can now be added to dropdownDecoration, and if so, it will be used instead of dropdownElevation.

## 1.0.6
* Update README

## 1.0.5
* Change some parameters names to be more clear.
* Add dropdown decoration as BoxDecoration parameter.
* Add Options table to README.
* Add "How to use DropdownButton2 with dividers" to README Examples.

## 1.0.2
* Add "How to use DropdownButtonFormField2 with Form" to README Examples.

## 1.0.1
* Update README

## 1.0.0
* initRelease