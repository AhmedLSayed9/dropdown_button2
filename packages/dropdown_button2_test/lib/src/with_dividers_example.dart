import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class WithDividersExample extends StatefulWidget {
  const WithDividersExample({super.key});

  @override
  State<WithDividersExample> createState() => _WithDividersExampleState();
}

class _WithDividersExampleState extends State<WithDividersExample> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  List<DropdownItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownItem<String>(
            value: item,
            height: 40,
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
            const DropdownItem<String>(
              enabled: false,
              height: 4,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
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
            items: _addDividersAfterItems(items),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            iconStyleData: const IconStyleData(
              openMenuIcon: Icon(Icons.arrow_drop_up),
            ),
          ),
        ),
      ),
    );
  }
}
