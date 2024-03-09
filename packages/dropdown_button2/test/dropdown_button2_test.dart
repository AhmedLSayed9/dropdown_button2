import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Button and Menu Focus',
    () {
      final List<int> menuItems = List<int>.generate(10, (int index) => index);
      final valueListenable = ValueNotifier(menuItems.first);
      final value = valueListenable.value;

      final findDropdownButton = find.byType(DropdownButton2<int>);
      final findDropdownButtonFormField =
          find.byType(DropdownButtonFormField2<int>);
      final findDropdownButtonText = find.descendant(
          of: findDropdownButton, matching: find.text('$value'));
      final findDropdownMenu = find.byType(ListView);
      final findDropdownMenuText =
          find.descendant(of: findDropdownMenu, matching: find.text('$value'));

      testWidgets('onTap should request focus for both button and menu',
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

        final buttonFocusNode =
            Focus.of(tester.element(findDropdownButtonText));

        expect(findDropdownMenu, findsNothing);
        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(findDropdownButtonText);
        await tester.pumpAndSettle();

        expect(findDropdownMenu, findsOneWidget);
        final menuFocusNode = Focus.of(tester.element(findDropdownMenuText));

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

        final buttonFocusNode =
            Focus.of(tester.element(findDropdownButtonText));

        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(findDropdownButtonText);
        await tester.pumpAndSettle();

        expect(buttonFocusNode.hasFocus, isTrue);

        await tester.tap(findDropdownMenuText);
        await tester.pumpAndSettle();

        expect(buttonFocusNode.hasPrimaryFocus, isTrue);
      });

      testWidgets(
          'inkwell should not go beyond border and cover error message when pressed',
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

        final findInkWell = find.descendant(
            of: findDropdownButton, matching: find.byType(InkWell));
        expect(findInkWell, findsOneWidget);

        final findInkwellInputDecorator = find.descendant(
          of: findInkWell,
          matching: find.byType(InputDecorator),
        );
        final inkwellInputDecorator =
            tester.widget<InputDecorator>(findInkwellInputDecorator);
        expect(inkwellInputDecorator.decoration.errorText, null);

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
