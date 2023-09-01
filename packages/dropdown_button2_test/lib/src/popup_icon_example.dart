import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class PopupIconExample extends StatefulWidget {
  const PopupIconExample({super.key});

  @override
  State<PopupIconExample> createState() => _PopupIconExampleState();
}

class _PopupIconExampleState extends State<PopupIconExample> {
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
              ..._MenuItems.firstItems.map(
                (item) => DropdownItem<_MenuItem>(
                  value: item,
                  height: 48,
                  child: _MenuItems.buildItem(item),
                ),
              ),
              const DropdownItem<Divider>(
                enabled: false,
                height: 8,
                child: Divider(),
              ),
              ..._MenuItems.secondItems.map(
                (item) => DropdownItem<_MenuItem>(
                  value: item,
                  height: 48,
                  child: _MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              _MenuItems.onChanged(context, value! as _MenuItem);
            },
            dropdownStyleData: DropdownStyleData(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent,
              ),
              offset: const Offset(0, 8),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.only(left: 16, right: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class _MenuItems {
  static const List<_MenuItem> firstItems = [home, share, settings];
  static const List<_MenuItem> secondItems = [logout];

  static const home = _MenuItem(text: 'Home', icon: Icons.home);
  static const share = _MenuItem(text: 'Share', icon: Icons.share);
  static const settings = _MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = _MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(_MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, _MenuItem item) {
    switch (item) {
      case _MenuItems.home:
        //Do something
        break;
      case _MenuItems.settings:
        //Do something
        break;
      case _MenuItems.share:
        //Do something
        break;
      case _MenuItems.logout:
        //Do something
        break;
    }
  }
}
