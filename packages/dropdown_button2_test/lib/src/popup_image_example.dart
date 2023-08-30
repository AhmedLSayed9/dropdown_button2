import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class PopupImageExample extends StatefulWidget {
  const PopupImageExample({super.key});

  @override
  State<PopupImageExample> createState() => _PopupImageExampleState();
}

class _PopupImageExampleState extends State<PopupImageExample> {
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
                  image: AssetImage(
                    'assets/images/city.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            openWithLongPress: true,
            items: [
              ..._MenuItems.firstItems.map(
                (item) => DropdownMenuItem<_MenuItem>(
                  value: item,
                  child: _MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ..._MenuItems.secondItems.map(
                (item) => DropdownMenuItem<_MenuItem>(
                  value: item,
                  child: _MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              _MenuItems.onChanged(context, value! as _MenuItem);
            },
            buttonStyleData: ButtonStyleData(
              // This is necessary for the ink response to match our customButton radius.
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent,
              ),
              offset: const Offset(40, -4),
            ),
            menuItemStyleData: MenuItemStyleData(
              customHeights: [
                ...List<double>.filled(_MenuItems.firstItems.length, 48),
                8,
                ...List<double>.filled(_MenuItems.secondItems.length, 48),
              ],
              padding: const EdgeInsets.only(left: 16, right: 16),
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

class _MenuItems {
  static const List<_MenuItem> firstItems = [like, share, download];
  static const List<_MenuItem> secondItems = [cancel];

  static const like = _MenuItem(text: 'Like', icon: Icons.favorite);
  static const share = _MenuItem(text: 'Share', icon: Icons.share);
  static const download = _MenuItem(text: 'Download', icon: Icons.download);
  static const cancel = _MenuItem(text: 'Cancel', icon: Icons.cancel);

  static Widget buildItem(_MenuItem item) {
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
      case _MenuItems.like:
        //Do something
        break;
      case _MenuItems.share:
        //Do something
        break;
      case _MenuItems.download:
        //Do something
        break;
      case _MenuItems.cancel:
        //Do something
        break;
    }
  }
}
