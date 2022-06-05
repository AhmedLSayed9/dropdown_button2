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