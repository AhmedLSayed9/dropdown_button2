# Flutter DropdownButton2

<a href="https://pub.dev/packages/dropdown_button2">
  <img src="https://img.shields.io/pub/v/dropdown_button2?label=Pub"/>
</a>
<a href="https://flutter.dev/">
  <img src="https://img.shields.io/badge/flutter-%3E%3D%203.0.0-green.svg"/>
</a>
<a href="https://opensource.org/licenses/MIT">
  <img src="https://img.shields.io/badge/License-MIT-red"/>
</a>

## Intro

Flutter's core Dropdown Button widget with steady dropdown menu and many other options you can
customize to your needs.

<img src="https://user-images.githubusercontent.com/70890146/144847227-a1fbf63b-e4a0-4fac-ba73-33cc468b7075.jpg" alt="Image" width="700"/>

- [Features](#features)
- [Options](#options)
- [Installation](#installation)
- [Usage and Examples](#usage-and-examples)
    - [1. Simple DropdownButton2 with no styling](#1-simple-dropdownbutton2-with-no-styling)
    - [2. DropdownButton2 with some styling and customization](#2-dropdownbutton2-with-some-styling-and-customization)
    - [3. DropdownButton2 with items of different heights like dividers](#3-dropdownbutton2-with-items-of-different-heights-like-dividers)
    - [4. DropdownButton2 as Multiselect Dropdown with Checkboxes](#4-dropdownbutton2-as-multiselect-dropdown-with-checkboxes)
    - [5. DropdownButton2 as Searchable Dropdown](#5-dropdownbutton2-as-searchable-dropdown)
    - [6. DropdownButton2 as Popup menu button using customButton parameter](#6-dropdownbutton2-as-popup-menu-button-using-custombutton-parameter)
    - [7. Using DropdownButtonFormField2 with Form](#7-using-dropdownbuttonformfield2-with-form)
- [CustomDropdownButton2 Widget "customize it to your needs"](#customdropdownbutton2-widget-customize-it-to-your-needs)

## Features

* Dropdown menu always open below the button "as long as it's possible otherwise it'll open to the
  end of the screen" and you can edit its position by using the offset parameter.
* You can control how (button, button's icon, dropdown menu and menu items) will be displayed "read
  Options below".
* You can align (hint & value) and customize them.
* You can edit the scrollbar's radius,thickness and isAlwaysShow.
* You can set max height for the dropdown menu & it'll become scrollable if there are more items.
* If you pass Null to dropdownMaxHeight parameter or didn't use it, the dropdown menu will take max
  height possible for the items and will become scrollable if there are more items.
* If you have long scrollable list, the dropdown menu will auto scroll to current selected item and
  show it at the middle of the menu if possible.
* Wrap DropdownButton2 with DropdownButtonHideUnderline to hide the underline.
* A Custom widget of the DropdownButton2 below to make it more reusable. You can customize it to
  your needs and use it throughout all your app easily as shown in the examples.
* You can use DropdownButton2 with items of different heights like dividers as shown in the
  examples.
* You can use DropdownButton2 as Multiselect Dropdown with Checkboxes as shown in the examples.
* You can use DropdownButton2 as Searchable Dropdown as shown in the examples.
* You can use DropdownButton2 as a popup menu button by using the parameter customButton. You can
  pass Icon,Image or any widget and customize it as shown in the examples.
* You can also use DropdownButtonFormField2 the same way with all options above and use it inside
  Form as shown in the examples.
* Use decoration parameter for the DropdownButtonFormField2 to add borders, label and more.
* You can customize DropdownButtonFormField2 width by wrapping it with Padding or with SizedBox and
  give it the width you want.

## Options

### DropdownButton2:

| Option                                                                                                                                 | Description                                                                              | Type                      | Required |
|----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|---------------------------|:--------:|
| [items](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/items.html)                             | The list of items the user can select                                                    | List<DropdownMenuItem<T>> |   Yes    |
| [selectedItemBuilder](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/selectedItemBuilder.html) | A builder to customize how the selected item will be displayed on the button             | DropdownButtonBuilder     |    No    |
| [value](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/value.html)                             | The value of the currently selected [DropdownMenuItem]                                   | T                         |    No    |
| [hint](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/hint.html)                               | The placeholder displayed before the user choose an item                                 | Widget                    |    No    |
| [disabledHint](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/disabledHint.html)               | The placeholder displayed if the dropdown is disabled                                    | Widget                    |    No    |
| [onChanged](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/onChanged.html)                     | Called when the user selects an item                                                     | ValueChanged<T?>          |    No    |
| [onMenuStateChange](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/onMenuStateChange.html)     | Called when the dropdown menu opens or closes                                            | OnMenuStateChangeFn       |    No    |
| [style](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/style.html)                             | The text style to use for text in the dropdown button and the dropdown menu              | TextStyle                 |    No    |
| [underline](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/underline.html)                     | The widget to use for drawing the drop-down button's underline                           | Widget                    |    No    |
| [isDense](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/isDense.html)                         | Reduce the button's height                                                               | bool                      |    No    |
| [isExpanded](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/isExpanded.html)                   | Makes the button's inner contents expanded (set true to avoid long text overflowing)     | bool                      |    No    |
| [alignment](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/alignment.html)                     | Defines how the hint or the selected item is positioned within the button                | AlignmentGeometry         |    No    |
| [buttonStyleData](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/buttonStyleData.html)         | Used to configure the theme of the button                                                | ButtonStyleData           |    No    |
| [iconStyleData](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/iconStyleData.html)             | Used to configure the theme of the button's icon                                         | IconStyleData             |    No    |
| [dropdownStyleData](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/dropdownStyleData.html)     | Used to configure the theme of the dropdown menu                                         | DropdownStyleData         |    No    |
| [menuItemStyleData](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/menuItemStyleData.html)     | Used to configure the theme of the dropdown menu items                                   | MenuItemStyleData         |    No    |
| [dropdownSearchData](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/dropdownSearchData.html)   | Used to configure searchable dropdowns                                                   | DropdownSearchData        |    No    |
| [customButton](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/customButton.html)               | Uses custom widget like icon,image,etc.. instead of the default button                   | Widget                    |    No    |
| [openWithLongPress](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/openWithLongPress.html)     | Opens the dropdown menu on long-pressing instead of tapping                              | bool                      |    No    |
| [barrierDismissible](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/barrierDismissible.html)   | Whether you can dismiss this route by tapping the modal barrier                          | bool                      |    No    |
| [barrierColor](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/barrierColor.html)               | The color to use for the modal barrier. If this is null, the barrier will be transparent | Color                     |    No    |
| [barrierLabel](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButton2/barrierLabel.html)               | The semantic label used for a dismissible barrier                                        | String                    |    No    |

#### Subclass ButtonStyleData:

| Option                                                                                                                   | Description                                                             | Type                          | Required |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|-------------------------------|:--------:|
| [height](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/ButtonStyleData/height.html)             | The height of the button                                                | double                        |    No    |
| [width](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/ButtonStyleData/width.html)               | The width of the button                                                 | double                        |    No    |
| [padding](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/ButtonStyleData/padding.html)           | The inner padding of the Button                                         | EdgeInsetsGeometry            |    No    |
| [decoration](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/ButtonStyleData/decoration.html)     | The decoration of the Button                                            | BoxDecoration                 |    No    |
| [elevation](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/ButtonStyleData/elevation.html)       | The elevation of the Button                                             | int                           |    No    |
| [overlayColor](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/ButtonStyleData/overlayColor.html) | Defines the ink response focus, hover, and splash colors for the button | MaterialStateProperty<Color?> |    No    |

#### Subclass IconStyleData:

| Option                                                                                                                           | Description                                              | Type   | Required |
|----------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|--------|:--------:|
| [icon](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/IconStyleData/icon.html)                           | The widget to use for the drop-down button's suffix icon | Widget |    No    |
| [iconDisabledColor](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/IconStyleData/iconDisabledColor.html) | The color of the icon if the button is disabled          | Color  |    No    |
| [iconEnabledColor](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/IconStyleData/iconEnabledColor.html)   | The color of the icon if the button is enabled           | Color  |    No    |
| [iconSize](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/IconStyleData/iconSize.html)                   | The size of the icon                                     | double |    No    |
| [openMenuIcon](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/IconStyleData/openMenuIcon.html)           | Shows different icon when dropdown menu is open          | Widget |    No    |

#### Subclass DropdownStyleData:

| Option                                                                                                                             | Description                                                                    | Type               | Required |
|------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|--------------------|:--------:|
| [maxHeight](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/maxHeight.html)               | The maximum height of the dropdown menu                                        | double             |    No    |
| [width](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/width.html)                       | The width of the dropdown menu                                                 | double             |    No    |
| [padding](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/padding.html)                   | The inner padding of the dropdown menu                                         | EdgeInsetsGeometry |    No    |
| [scrollPadding](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/scrollPadding.html)       | The inner padding of the dropdown menu including the scrollbar                 | EdgeInsetsGeometry |    No    |
| [decoration](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/decoration.html)             | The decoration of the dropdown menu                                            | BoxDecoration      |    No    |
| [elevation](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/elevation.html)               | The elevation of the dropdown menu                                             | int                |    No    |
| [direction](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/direction.html)               | The direction of the dropdown menu in relation to the button                   | DropdownDirection  |    No    |
| [offset](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/offset.html)                     | Changes the position of the dropdown menu                                      | Offset             |    No    |
| [isOverButton](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/isOverButton.html)         | Opens the dropdown menu over the button instead of below it                    | bool               |    No    |
| [useSafeArea](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/useSafeArea.html)           | Determine if the dropdown menu should only display in safe areas of the screen | bool               |    No    |
| [useRootNavigator](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/useRootNavigator.html) | Determine whether to open the dropdown menu using the root Navigator or not    | bool               |    No    |
| [scrollbarTheme](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/scrollbarTheme.html)     | Configures the theme of the menu's scrollbar                                   | ScrollbarThemeData |    No    |
| [openInterval](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownStyleData/openInterval.html)         | The animation curve used for opening the dropdown menu (forward direction)     | Interval           |    No    |

#### Subclass MenuItemStyleData:

| Option                                                                                                                                           | Description                                                              | Type                          | Required |
|--------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|-------------------------------|:--------:|
| [height](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/MenuItemStyleData/height.html)                                   | The height of the menu item                                              | double                        |    No    |
| [customHeights](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/MenuItemStyleData/customHeights.html)                     | Define different heights for the menu items (useful for adding dividers) | List<double>                  |    No    |
| [padding](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/MenuItemStyleData/padding.html)                                 | The padding of menu items                                                | EdgeInsetsGeometry            |    No    |
| [overlayColor](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/MenuItemStyleData/overlayColor.html)                       | Defines the ink response focus, hover, and splash colors for the items   | MaterialStateProperty<Color?> |    No    |
| [selectedMenuItemBuilder](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/MenuItemStyleData/selectedMenuItemBuilder.html) | A builder to customize the selected menu item                            | SelectedMenuItemBuilder       |    No    |

#### Subclass DropdownSearchData:

| Option                                                                                                                                            | Description                                                                                    | Type                  | Required |
|---------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|-----------------------|:--------:|
| [searchController](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownSearchData/searchController.html)               | The controller used for searchable dropdowns, if null, then it'll perform as a normal dropdown | TextEditingController |    No    |
| [searchInnerWidget](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownSearchData/searchInnerWidget.html)             | The widget to be shown at the top of the dropdown menu for searchable dropdowns                | Widget                |    No    |
| [searchInnerWidgetHeight](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownSearchData/searchInnerWidgetHeight.html) | The height of the searchInnerWidget if used                                                    | double                |    No    |
| [searchMatchFn](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownSearchData/searchMatchFn.html)                     | The match function used for searchable dropdowns, if null, defaultFn will be used              | SearchMatchFn         |    No    |

### DropdownButtonFormField2 (In addition to the above):

| Option                                                                                                                                      | Description                                                        | Type                  | Required |
|---------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|-----------------------|:--------:|
| [dropdownButtonKey](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButtonFormField2/dropdownButtonKey.html) | The key of DropdownButton2 child widget                            | Key                   |    No    |
| [decoration](https://pub.dev/documentation/dropdown_button2/latest/dropdown_button2/DropdownButtonFormField2/decoration.html)               | The decoration of the dropdown button form field                   | InputDecoration       |    No    |
| [onSaved](https://api.flutter.dev/flutter/widgets/FormField/onSaved.html)                                                                   | Called with the current selected item when the form is saved       | FormFieldSetter<T>    |    No    |
| [validator](https://api.flutter.dev/flutter/widgets/FormField/validator.html)                                                               | Called to validates if the input is invalid and display error text | FormFieldValidator<T> |    No    |
| [autovalidateMode](https://api.flutter.dev/flutter/widgets/AutovalidateMode.html)                                                           | Used to enable/disable auto validation                             | AutovalidateMode      |    No    |

## Installation

add this line to pubspec.yaml

```yaml
dependencies:

  dropdown_button2: ^2.0.1

```

import package

```dart

import 'package:dropdown_button2/dropdown_button2.dart';

```

## Usage and Examples

### 1. Simple DropdownButton2 with no styling:

<img src="https://user-images.githubusercontent.com/70890146/144771200-15e7e98e-bdf2-4265-b810-035191f7e607.jpg" alt="Image" width="300"/>

```dart
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
String? selectedValue;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
                  .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    ),
  );
}
```

### 2. DropdownButton2 with some styling and customization:

<img src="https://user-images.githubusercontent.com/70890146/144771235-8dd0b019-e93b-4613-9035-42dbedd9ba9e.jpg" alt="Image" width="300"/>

```dart
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];
String? selectedValue;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
                  .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.redAccent,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  padding: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.redAccent,
                  ),
                  elevation: 8,
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    thumbVisibility: MaterialStateProperty.all(true),
                  )),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    ),
  );
}
```

### 3. DropdownButton2 with items of different heights like dividers:

<img src="https://user-images.githubusercontent.com/70890146/144771246-49ea5ed8-78d7-4e0d-a411-331649cef3d5.jpg" alt="Image" width="300"/>

```dart
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
String? selectedValue;

List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
  List<DropdownMenuItem<String>> _menuItems = [];
  for (var item in items) {
    _menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return _menuItems;
}

List<double> _getCustomItemsHeights() {
  List<double> _itemsHeights = [];
  for (var i = 0; i < (items.length * 2) - 1; i++) {
    if (i.isEven) {
      _itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      _itemsHeights.add(4);
    }
  }
  return _itemsHeights;
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: _addDividersAfterItems(items),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonStyleData: const ButtonStyleData(height: 40, width: 140),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            customHeights: _getCustomItemsHeights(),
          ),
        ),
      ),
    ),
  );
}
```

### 4. DropdownButton2 as Multiselect Dropdown with Checkboxes:

<img src="https://user-images.githubusercontent.com/70890146/168461570-1682bf63-f1e9-40c1-a86d-aa4c3acdd1c9.jpg" alt="Image" width="300"/>

```dart
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
List<String> selectedItems = [];

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'Select Items',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              //disable default onTap to avoid closing menu when selecting an item
              enabled: false,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final _isSelected = selectedItems.contains(item);
                  return InkWell(
                    onTap: () {
                      _isSelected
                              ? selectedItems.remove(item)
                              : selectedItems.add(item);
                      //This rebuilds the StatefulWidget to update the button's text
                      setState(() {});
                      //This rebuilds the dropdownMenu Widget to update the check mark
                      menuSetState(() {});
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          _isSelected
                                  ? const Icon(Icons.check_box_outlined)
                                  : const Icon(Icons.check_box_outline_blank),
                          const SizedBox(width: 16),
                          Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
          value: selectedItems.isEmpty ? null : selectedItems.last,
          onChanged: (value) {},
          selectedItemBuilder: (context) {
            return items.map(
                      (item) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    selectedItems.join(', '),
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                );
              },
            ).toList();
          },
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    ),
  );
}
```

### 5. DropdownButton2 as Searchable Dropdown:

<img src="https://user-images.githubusercontent.com/70890146/173115793-de4ec762-ab62-4395-b64a-01ae096ed4e3.jpg" alt="Image" width="300"/>

```dart
final List<String> items = [
  'A_Item1',
  'A_Item2',
  'A_Item3',
  'A_Item4',
  'B_Item1',
  'B_Item2',
  'B_Item3',
  'B_Item4',
];

String? selectedValue;
final TextEditingController textEditingController = TextEditingController();

@override
void dispose() {
  textEditingController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
                  .map((item) => DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 200,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return (item.value.toString().contains(searchValue));
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    ),
  );
}
```

### 6. DropdownButton2 as Popup menu button using customButton parameter:

***Example 1*** using icon:

<img src="https://user-images.githubusercontent.com/70890146/144771258-e1a128dd-5b4c-46f6-bc89-645f7748c51b.jpg" alt="Image" width="300"/>

```dart
class CustomButtonTest extends StatefulWidget {
  const CustomButtonTest({Key? key}) : super(key: key);

  @override
  State<CustomButtonTest> createState() => _CustomButtonTestState();
}

class _CustomButtonTestState extends State<CustomButtonTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.list,
              size: 46,
              color: Colors.red,
            ),
            items: [
              ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem);
            },
            dropdownStyleData: DropdownStyleData(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent,
              ),
              elevation: 8,
              offset: const Offset(0, 8),
            ),
            menuItemStyleData: MenuItemStyleData(
              customHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
                8,
                ...List<double>.filled(MenuItems.secondItems.length, 48),
              ],
              padding: const EdgeInsets.only(left: 16, right: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
      //Do something
        break;
      case MenuItems.settings:
      //Do something
        break;
      case MenuItems.share:
      //Do something
        break;
      case MenuItems.logout:
      //Do something
        break;
    }
  }
}
```

***Example 2*** using image and openWithLongPress parameter:

<img src="https://user-images.githubusercontent.com/70890146/144771270-2be603a4-84e8-47e7-9c69-91c938626866.jpg" alt="Image" width="300"/>

```dart
class CustomButtonTest extends StatefulWidget {
  const CustomButtonTest({Key? key}) : super(key: key);

  @override
  State<CustomButtonTest> createState() => _CustomButtonTestState();
}

class _CustomButtonTestState extends State<CustomButtonTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2020/05/11/06/20/city-5156636_960_720.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            openWithLongPress: true,
            items: [
              ...MenuItems.firstItems.map(
                        (item) =>
                        DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                        (item) =>
                        DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem);
            },
            dropdownStyleData: DropdownStyleData(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent,
              ),
              elevation: 8,
              offset: const Offset(40, -4),
            ),
            menuItemStyleData: MenuItemStyleData(
              customHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
                8,
                ...List<double>.filled(MenuItems.secondItems.length, 48),
              ],
              padding: const EdgeInsets.only(left: 16, right: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [like, share, download];
  static const List<MenuItem> secondItems = [cancel];

  static const like = MenuItem(text: 'Like', icon: Icons.favorite);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const download = MenuItem(text: 'Download', icon: Icons.download);
  static const cancel = MenuItem(text: 'Cancel', icon: Icons.cancel);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: Colors.white,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.like:
      //Do something
        break;
      case MenuItems.share:
      //Do something
        break;
      case MenuItems.download:
      //Do something
        break;
      case MenuItems.cancel:
      //Do something
        break;
    }
  }
}
```

### 7. Using DropdownButtonFormField2 with Form:

<img src="https://user-images.githubusercontent.com/70890146/144771294-4b98a3f4-5cb7-452f-a1be-5d3e1275fb93.jpg" alt="Image" width="500"/>

```dart
final List<String> genderItems = [
  'Male',
  'Female',
];

String? selectedValue;

final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintText: 'Enter Your Full Name.',
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField2(
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: const Text(
                'Select Your Gender',
                style: TextStyle(fontSize: 14),
              ),
              items: genderItems
                      .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
                      .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select gender.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
              buttonStyleData: const ButtonStyleData(
                height: 60,
                padding: EdgeInsets.only(left: 20, right: 10),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: const Text('Submit Button'),
            ),
          ],
        ),
      ),
    ),
  );
}
```

## CustomDropdownButton2 Widget "customize it to your needs"

```dart
class CustomDropdownButton2 extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = const Offset(0, 0),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        //To avoid long text overflowing.
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        value: value,
        items: dropdownItems
                .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Container(
            alignment: valueAlignment,
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ))
                .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: buttonHeight ?? 40,
          width: buttonWidth ?? 140,
          padding: buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          decoration: buttonDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black45,
                    ),
                  ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: iconSize ?? 12,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? 200,
          width: dropdownWidth ?? 140,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          //Default is false to show menu below button
          isOverButton: false,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                    ? MaterialStateProperty.all<double>(scrollbarThickness!)
                    : null,
            thumbVisibility: scrollbarAlwaysShow != null
                    ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                    : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 40,
          padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
```

### How simple you can use it:

<img src="https://user-images.githubusercontent.com/70890146/144771305-23338e9d-9664-46e5-a7b7-ffc02e9d61a3.jpg" alt="Image" width="300"/>

```dart

final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];
String? selectedValue;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: CustomDropdownButton2(
        hint: 'Select Item',
        dropdownItems: items,
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
      ),
    ),
  );
}
```

---

## Thanks

If something is missing or you want to add some feature, feel free to open a ticket or contribute!

[LICENSE: MIT](LICENSE)