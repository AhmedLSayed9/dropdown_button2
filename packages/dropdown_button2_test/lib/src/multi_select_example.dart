import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MultiSelectExample extends StatefulWidget {
  const MultiSelectExample({super.key});

  @override
  State<MultiSelectExample> createState() => _MultiSelectExampleState();
}

class _MultiSelectExampleState extends State<MultiSelectExample> {
  final List<String> items = [
    'All',
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  final multiValueListenable = ValueNotifier<List<String>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select Items',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items.map((item) {
              return DropdownItem(
                value: item,
                height: 40,
                closeOnTap: false,
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: multiValueListenable,
                  builder: (context, multiValue, _) {
                    final isSelected = multiValue.contains(item);
                    return Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          if (isSelected)
                            const Icon(Icons.check_box_outlined)
                          else
                            const Icon(Icons.check_box_outline_blank),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            multiValueListenable: multiValueListenable,
            onChanged: (value) {
              final multiValue = multiValueListenable.value;
              final isSelected = multiValue.contains(value);
              if (value == 'All') {
                isSelected
                    ? multiValueListenable.value = []
                    : multiValueListenable.value = List.from(items);
              } else {
                multiValueListenable.value = isSelected
                    ? ([...multiValue]..remove(value))
                    : [...multiValue, value!];
              }
            },
            selectedItemBuilder: (context) {
              return items.map(
                (item) {
                  return ValueListenableBuilder<List<String>>(
                      valueListenable: multiValueListenable,
                      builder: (context, multiValue, _) {
                        return Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            multiValue
                                .where((item) => item != 'All')
                                .join(', '),
                            style: const TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        );
                      });
                },
              ).toList();
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(left: 16, right: 8),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
