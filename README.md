# Flutter DropdownButton2

<a href="https://pub.dev/packages/dropdown_button2">
  <img src="https://img.shields.io/pub/v/dropdown_button2?label=Pub"/>
</a>
<a href="https://flutter.dev/">
  <img src="https://img.shields.io/badge/flutter-%3E%3D%202.0.0-green.svg"/>
</a>
<a href="https://opensource.org/licenses/MIT">
  <img src="https://img.shields.io/badge/License-MIT-red"/>
</a>

## Intro

Flutter's core Dropdown Button widget with steady dropdown menu and many other options you can
customize to your needs.

<img src="https://user-images.githubusercontent.com/70890146/144847227-a1fbf63b-e4a0-4fac-ba73-33cc468b7075.jpg" alt="Image" width="700"/>

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
* You can add dividers as items with different height by passing dividers indexes to
  customItemsIndexes and the height to customItemsHeight as shown in the examples.
* You can use DropdownButton2 as a popup menu button by using the parameter customButton. You can
  pass Icon,Image or any widget and customize it as shown in the examples.
* You can also use DropdownButtonFormField2 the same way with all options above and use it inside
  Form as shown in the examples.
* Use decoration parameter for the DropdownButtonFormField2 to add borders, label and more.
* You can customize DropdownButtonFormField2 width by wrapping it with Padding or with SizedBox and
  give it the width you want.

## Options

### For DropdownButton2:

| Option | Description | Type | Required |
|---|---|---|:---:|
items | List of items user can select | List<DropdownMenuItem<T>> | Yes
hint | Placeholder hint before you choose item | Widget | No
disabledHint | Placeholder hint if the dropdown is disabled | Widget | No
value | Value of the currently selected item | T | No
onChanged | Called when the user selects an item | ValueChanged<T?> | No
onTap | Called when the dropdown button is tapped | ValueChanged<T?> | No
selectedItemBuilder | How selected item will be displayed on button | DropdownButtonBuilder | No
buttonHeight | Button height | double | No
buttonWidth | Button width | double | No
buttonPadding | Button inner padding | EdgeInsetsGeometry | No
buttonDecoration | Button decoration | BoxDecoration | No
buttonElevation | Button elevation | int | No
icon | Dropdown button's icon | Widget | No
iconSize | Size of the icon | double | No
iconEnabledColor | Color of icon if button is enabled | Color | No
iconDisabledColor | Color of icon if button is disabled | Color | No
itemHeight | Menu items height | double | No
itemPadding | Menu items padding | EdgeInsetsGeometry | No
dropdownMaxHeight | Maximum height of the dropdown menu | double | No
dropdownWidth | width of the dropdown menu | double | No
dropdownPadding | Dropdown menu inner padding | EdgeInsetsGeometry | No
dropdownBorderRadius | BorderRadius of the dropdown menu | BorderRadius | No
dropdownBorder | Border of the dropdown menu | BoxBorder | No
dropdownElevation | Elevation of the dropdown menu | int | No
dropdownColor | Background color of the dropdown menu | Color | No
scrollbarRadius | Dropdown scrollbar radius | Radius | No
scrollbarThickness | Dropdown scrollbar thickness | double | No
scrollbarAlwaysShow | Always show Dropdown scrollbar or not | bool | No
offset | Change position of the dropdown menu | Offset | No
customButton | Use custom widget like icon,image,etc.. instead of the Button | Widget | No
customItemsIndexes | Pass indexes of items you want to give different height (useful for adding dividers) | List<int> | No
customItemsHeight | Height you want for the items you passed their indexes | double | No
isExpanded | Make the button hint or selectedItem expanded (set true to avoid long text overflowing) | bool | No
openWithLongPress | Open the dropdown menu by long pressing instead of normal tap | bool | No
dropdownOverButton | Open dropdown menu over button instead of below it | bool | No
focusColor | Button's color when it has the input focus using traditional interfaces (keyboard and mouse) | Color | No

### For DropdownButtonFormField2 "In addition to the above":

| Option | Description | Type | Required |
|---|---|---|:---:|
decoration | The decoration of the dropdown button form field | InputDecoration | No
onSaved | Called when the form is saved with the current selected item | FormFieldSetter<T> | No
validator | Called to validates if the input is invalid and display error text | FormFieldValidator<T> | No
autovalidateMode | Used to enable/disable auto validation | AutovalidateMode | No

## Installation

add this line to pubspec.yaml

```yaml

dependencies:

  dropdown_button2: ^1.1.1

```

import package

```dart

import 'package:dropdown_button2/dropdown_button2.dart';

```

## Usage & Examples

### 1. Simple DropdownButton2 with no styling:

<img src="https://user-images.githubusercontent.com/70890146/144771200-15e7e98e-bdf2-4265-b810-035191f7e607.jpg" alt="Image" width="300"/>

```dart
String? selectedValue;
List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];

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
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
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
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
    ),
  );
}
```

### 2. DropdownButton2 with some styling and customization:

<img src="https://user-images.githubusercontent.com/70890146/144771235-8dd0b019-e93b-4613-9035-42dbedd9ba9e.jpg" alt="Image" width="300"/>

```dart
 String? selectedValue;
List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];

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
                  .map((item) =>
                  DropdownMenuItem<String>(
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
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
          buttonHeight: 50,
          buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    ),
  );
}
```

### 3. How to add different height items like dividers:

<img src="https://user-images.githubusercontent.com/70890146/144771246-49ea5ed8-78d7-4e0d-a411-331649cef3d5.jpg" alt="Image" width="300"/>

```dart
 String? selectedValue;
List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];

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

List<int> _getDividersIndexes() {
  List<int> _dividersIndexes = [];
  for (var i = 0; i < (items.length * 2) - 1; i++) {
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      _dividersIndexes.add(i);
    }
  }
  return _dividersIndexes;
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
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: _addDividersAfterItems(items),
          customItemsIndexes: _getDividersIndexes(),
          customItemsHeight: 4,
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
          itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    ),
  );
}
```

### 4. DropdownButton2 as Popup menu button using customButton parameter:

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
            customItemsIndexes: const [3],
            customItemsHeight: 8,
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
            itemHeight: 48,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.redAccent,
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
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
        Icon(
                item.icon,
                color: Colors.white,
                size: 22
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
            customItemsIndexes: const [3],
            customItemsHeight: 8,
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
            itemHeight: 48,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.redAccent,
            ),
            dropdownElevation: 8,
            offset: const Offset(40, -4),
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

### 5. Using DropdownButtonFormField2 with Form:

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
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 60,
              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: genderItems
                      .map((item) =>
                      DropdownMenuItem<String>(
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
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
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

## Custom DropdownButton2 Widget "customize it to your needs"

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
  final Offset? offset;

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
    this.offset,
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
        icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
        iconSize: iconSize ?? 12,
        iconEnabledColor: iconEnabledColor,
        iconDisabledColor: iconDisabledColor,
        buttonHeight: buttonHeight ?? 40,
        buttonWidth: buttonWidth ?? 140,
        buttonPadding:
        buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: buttonDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black45,
                  ),
                ),
        buttonElevation: buttonElevation,
        itemHeight: itemHeight ?? 40,
        itemPadding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownMaxHeight: dropdownHeight ?? 200,
        dropdownWidth: dropdownWidth ?? 140,
        dropdownPadding: dropdownPadding,
        dropdownDecoration: dropdownDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
        dropdownElevation: dropdownElevation ?? 8,
        scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: scrollbarThickness,
        scrollbarAlwaysShow: scrollbarAlwaysShow,
        //Null or Offset(0, 0) will open just under the button. You can edit as you want.
        offset: offset,
        dropdownOverButton: false, //Default is false to show menu below button
      ),
    );
  }
}
```

### How simple you can use it:

<img src="https://user-images.githubusercontent.com/70890146/144771305-23338e9d-9664-46e5-a7b7-ffc02e9d61a3.jpg" alt="Image" width="300"/>

```dart
String? selectedValue;
List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];

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