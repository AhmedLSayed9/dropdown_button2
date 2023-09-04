import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Button and Menu Focus',
    () {
      final List<int> menuItems = List<int>.generate(10, (int index) => index);
      final value = menuItems.first;

      final dropdownButton = find.byType(DropdownButton2<int>);
      final dropdownButtonText =
          find.descendant(of: dropdownButton, matching: find.text('$value'));
      final dropdownMenu = find.byType(ListView);
      final dropdownMenuText =
          find.descendant(of: dropdownMenu, matching: find.text('$value'));

      testWidgets('onTap should request focus for both button and menu',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButton2<int>(
                  value: value,
                  items: menuItems.map<DropdownItem<int>>((int item) {
                    return DropdownItem<int>(
                      value: item,
                      child: Text(item.toString()),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        );

        final buttonFocusNode = Focus.of(tester.element(dropdownButtonText));

        expect(dropdownMenu, findsNothing);
        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(dropdownButtonText);
        await tester.pumpAndSettle();

        expect(dropdownMenu, findsOneWidget);
        final menuFocusNode = Focus.of(tester.element(dropdownMenuText));

        expect(menuFocusNode.hasPrimaryFocus, isTrue);
        expect(buttonFocusNode.hasFocus, isTrue);
      });

      testWidgets('button should stay highlighted when menu closes',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButton2<int>(
                  value: value,
                  items: menuItems.map<DropdownItem<int>>((int item) {
                    return DropdownItem<int>(
                      value: item,
                      child: Text(item.toString()),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        );

        final buttonFocusNode = Focus.of(tester.element(dropdownButtonText));

        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(dropdownButtonText);
        await tester.pumpAndSettle();

        expect(buttonFocusNode.hasFocus, isTrue);

        await tester.tap(dropdownMenuText);
        await tester.pumpAndSettle();

        expect(buttonFocusNode.hasPrimaryFocus, isTrue);
      });
    },
  );
}
