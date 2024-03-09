import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class WithSeparatorsExample extends StatefulWidget {
  const WithSeparatorsExample({super.key});

  @override
  State<WithSeparatorsExample> createState() => _WithSeparatorsExampleState();
}

class _WithSeparatorsExampleState extends State<WithSeparatorsExample> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  final valueListenable = ValueNotifier<String?>(null);

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
                .map((String item) => DropdownItem<String>(
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
                    ))
                .toList(),
            dropdownSeparator: const DropdownSeparator(
              height: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
            ),
            valueListenable: valueListenable,
            onChanged: (value) {
              valueListenable.value = value;
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
