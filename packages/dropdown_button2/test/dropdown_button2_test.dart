import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Button and Menu Focus',
    () {
      final List<int> menuItems = List<int>.generate(10, (int index) => index);
      final valueListenable = ValueNotifier(menuItems.first);

      final findDropdownButton = find.byType(DropdownButton2<int>);
      final findDropdownButtonFormField = find.byType(DropdownButtonFormField2<int>);
      final findDropdownMenu = find.byType(ListView);

      final findDropdownButtonFocus = find
          .descendant(of: find.byType(DropdownButton2<int>), matching: find.byType(Focus))
          .first;
      final findDropdownButtonText =
          find.descendant(of: findDropdownButton, matching: find.text('${valueListenable.value}'));
      final findSelectedMenuItemText =
          find.descendant(of: findDropdownMenu, matching: find.text('${valueListenable.value}'));

      testWidgets('onTap should request focus for both button and selected menu item',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButton2<int>(
                  valueListenable: valueListenable,
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

        final buttonFocusNode = tester.widget<Focus>(findDropdownButtonFocus).focusNode!;

        expect(findDropdownMenu, findsNothing);
        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(findDropdownButtonText);
        await tester.pumpAndSettle();

        expect(findDropdownMenu, findsOneWidget);
        final selectedMenuItemFocusNode = Focus.of(tester.element(findSelectedMenuItemText));

        expect(selectedMenuItemFocusNode.hasPrimaryFocus, isTrue);
        expect(buttonFocusNode.hasFocus, isTrue);
      });

      testWidgets('button should stay highlighted when menu closes', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButton2<int>(
                  valueListenable: valueListenable,
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

        final buttonFocusNode = tester.widget<Focus>(findDropdownButtonFocus).focusNode!;

        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(findDropdownButtonText);
        await tester.pumpAndSettle();

        expect(buttonFocusNode.hasFocus, isTrue);

        await tester.tap(findSelectedMenuItemText);
        await tester.pumpAndSettle();

        expect(buttonFocusNode.hasPrimaryFocus, isTrue);
      });

      testWidgets('inkwell should not go beyond border and cover error message when pressed',
          (WidgetTester tester) async {
        // Regression test for https://github.com/AhmedLSayed9/dropdown_button2/issues/56

        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        const errorMessage = 'error_message';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Form(
                  key: formKey,
                  child: DropdownButtonFormField2<int>(
                    valueListenable: valueListenable,
                    items: menuItems.map<DropdownItem<int>>((int item) {
                      return DropdownItem<int>(
                        value: item,
                        child: Text(item.toString()),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    validator: (value) => errorMessage,
                  ),
                ),
              ),
            ),
          ),
        );

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        final findInkWell = find.descendant(of: findDropdownButton, matching: find.byType(InkWell));
        expect(findInkWell, findsNothing);

        final findFormFieldInputDecorator = find.descendant(
          of: findDropdownButtonFormField,
          matching: find.byType(InputDecorator),
        );
        final formFieldInputDecorator =
            tester.widget<InputDecorator>(findFormFieldInputDecorator.first);
        expect(formFieldInputDecorator.decoration.errorText, errorMessage);
      });
    },
  );
}
