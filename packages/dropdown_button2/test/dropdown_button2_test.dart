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
      final findDropdownButtonText = find.descendant(
        of: findDropdownButton,
        matching: find.text('${valueListenable.value}'),
      );
      final findSelectedMenuItemText = find.descendant(
        of: findDropdownMenu,
        matching: find.text('${valueListenable.value}'),
      );

      testWidgets('onTap should request focus for both button and selected menu item', (
        WidgetTester tester,
      ) async {
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

      testWidgets('inkwell should not go beyond border and cover error message when pressed', (
        WidgetTester tester,
      ) async {
        // Regression test for:
        // https://github.com/AhmedLSayed9/dropdown_button2/issues/56
        // https://github.com/AhmedLSayed9/dropdown_button2/issues/199

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
        final formFieldInputDecorator = tester.widget<InputDecorator>(
          findFormFieldInputDecorator.first,
        );
        expect(formFieldInputDecorator.decoration.errorText, errorMessage);
      });
    },
  );

  group(
    'DropdownButtonFormField2 Error Properties',
    () {
      final List<int> menuItems = List<int>.generate(10, (int index) => index);
      final valueListenable = ValueNotifier(menuItems.first);

      final findDropdownButtonFormField = find.byType(DropdownButtonFormField2<int>);

      List<DropdownItem<int>> buildItems() {
        return menuItems.map<DropdownItem<int>>((int item) {
          return DropdownItem<int>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList();
      }

      InputDecorator getFormFieldInputDecorator(WidgetTester tester) {
        final findInputDecorator = find.descendant(
          of: findDropdownButtonFormField,
          matching: find.byType(InputDecorator),
        );
        return tester.widget<InputDecorator>(findInputDecorator.first);
      }

      testWidgets('validator error text is displayed', (WidgetTester tester) async {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        const errorMessage = 'Please select a value';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Form(
                  key: formKey,
                  child: DropdownButtonFormField2<int>(
                    valueListenable: valueListenable,
                    items: buildItems(),
                    onChanged: (_) {},
                    validator: (int? v) => errorMessage,
                  ),
                ),
              ),
            ),
          ),
        );

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        expect(find.text(errorMessage), findsOneWidget);
      });

      testWidgets('validator returning null shows no error', (WidgetTester tester) async {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Form(
                  key: formKey,
                  child: DropdownButtonFormField2<int>(
                    valueListenable: valueListenable,
                    items: buildItems(),
                    onChanged: (_) {},
                    validator: (int? v) => null,
                  ),
                ),
              ),
            ),
          ),
        );

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        expect(inputDecorator.decoration.errorText, isNull);
        expect(inputDecorator.decoration.error, isNull);
      });

      testWidgets('autovalidateMode.always validates on first build', (
        WidgetTester tester,
      ) async {
        int validateCalled = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButtonFormField2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.always,
                  validator: (int? value) {
                    validateCalled++;
                    return 'Error';
                  },
                ),
              ),
            ),
          ),
        );

        expect(validateCalled, 1);
        expect(find.text('Error'), findsOneWidget);
      });

      testWidgets('decoration errorStyle is applied to error text', (
        WidgetTester tester,
      ) async {
        const errorStyle = TextStyle(color: Colors.orange, fontSize: 20);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButtonFormField2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.always,
                  validator: (int? v) => 'Styled error',
                  decoration: const InputDecoration(errorStyle: errorStyle),
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        expect(inputDecorator.decoration.errorStyle, errorStyle);
        expect(find.text('Styled error'), findsOneWidget);
      });

      testWidgets('decoration errorMaxLines is respected', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButtonFormField2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.always,
                  validator: (int? v) => 'A very long error message\nthat spans multiple lines',
                  decoration: const InputDecoration(errorMaxLines: 2),
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        expect(inputDecorator.decoration.errorMaxLines, 2);
      });

      testWidgets('widget returned by errorBuilder is shown', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButtonFormField2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.always,
                  validator: (int? v) => 'Required',
                  errorBuilder: (BuildContext context, String errorText) {
                    return Text('Custom: $errorText');
                  },
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Custom: Required'), findsOneWidget);
        expect(find.text('Required'), findsNothing);
      });

      testWidgets('errorBuilder widget is passed to InputDecorator as error', (
        WidgetTester tester,
      ) async {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Form(
                  key: formKey,
                  child: DropdownButtonFormField2<int>(
                    valueListenable: valueListenable,
                    items: buildItems(),
                    onChanged: (_) {},
                    validator: (int? v) => 'Required',
                    errorBuilder: (BuildContext context, String errorText) {
                      return Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          Text(errorText),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        // When errorBuilder is used, error widget is set instead of errorText.
        expect(inputDecorator.decoration.error, isNotNull);
        expect(inputDecorator.decoration.errorText, isNull);
        expect(find.byIcon(Icons.error), findsOneWidget);
      });

      testWidgets('errorBuilder is not called when there is no error', (
        WidgetTester tester,
      ) async {
        bool errorBuilderCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButtonFormField2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.always,
                  validator: (int? v) => null,
                  errorBuilder: (BuildContext context, String errorText) {
                    errorBuilderCalled = true;
                    return Text(errorText);
                  },
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(errorBuilderCalled, isFalse);
      });
    },
  );
}
