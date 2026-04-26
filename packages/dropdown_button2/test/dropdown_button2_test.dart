import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder findInputDecoratorBorderPainter() {
  return find.descendant(
    of: find.byWidgetPredicate((Widget w) => '${w.runtimeType}' == '_BorderContainer'),
    matching: find.byWidgetPredicate((Widget w) => w is CustomPaint),
  );
}

void main() {
  group(
    'Button and Menu Focus',
    () {
      final List<int> menuItems = List<int>.generate(10, (int index) => index);

      final findDropdownButton = find.byType(DropdownButton2<int>);
      final findDropdownButtonFormField = find.byType(DropdownButtonFormField2<int>);
      final findDropdownMenu = find.byType(ListView);

      final findDropdownButtonFocus = find
          .descendant(of: find.byType(DropdownButton2<int>), matching: find.byType(Focus))
          .first;

      testWidgets('onTap should request focus for both button and selected menu item', (
        WidgetTester tester,
      ) async {
        final valueListenable = ValueNotifier(menuItems.first);
        final findSelectedMenuItemText = find.descendant(
          of: findDropdownMenu,
          matching: find.text('${valueListenable.value}'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButton2<int>(
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
        );

        final buttonFocusNode = tester.widget<Focus>(findDropdownButtonFocus).focusNode!;

        expect(findDropdownMenu, findsNothing);
        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        expect(findDropdownMenu, findsOneWidget);
        final selectedMenuItemFocusNode = Focus.of(tester.element(findSelectedMenuItemText));

        expect(selectedMenuItemFocusNode.hasPrimaryFocus, isTrue);
        expect(buttonFocusNode.hasFocus, isTrue);
      });

      testWidgets('button should stay highlighted when menu closes', (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);
        final findSelectedMenuItemText = find.descendant(
          of: findDropdownMenu,
          matching: find.text('${valueListenable.value}'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButton2<int>(
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
        );

        final buttonFocusNode = tester.widget<Focus>(findDropdownButtonFocus).focusNode!;

        expect(buttonFocusNode.hasFocus, isFalse);

        await tester.tap(findDropdownButton);
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
        final valueListenable = ValueNotifier(menuItems.first);
        const errorMessage = 'error_message';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
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

      testWidgets('DropdownButtonFormField2 can replace focusNode properly', (
        WidgetTester tester,
      ) async {
        tester.binding.focusManager.highlightStrategy = FocusHighlightStrategy.alwaysTraditional;
        final valueListenable = ValueNotifier(menuItems.first);
        FocusNode focusNode = FocusNode(debugLabel: 'DropdownButtonFormField2');
        addTearDown(() => focusNode.dispose());

        Widget buildFormField() => MaterialApp(
          home: Scaffold(
            body: DropdownButtonFormField2<int>(
              valueListenable: valueListenable,
              items: menuItems.map<DropdownItem<int>>((int item) {
                return DropdownItem<int>(
                  value: item,
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: (_) {},
              focusNode: focusNode,
              decoration: const InputDecoration(
                filled: true,
                focusColor: Color(0xff00ff00),
              ),
            ),
          ),
        );

        await tester.pumpWidget(buildFormField());
        final Color defaultBorderColor = Theme.of(
          tester.element(find.byType(InputDecorator)),
        ).colorScheme.surfaceContainerHighest;
        expect(
          findInputDecoratorBorderPainter(),
          paints..path(style: PaintingStyle.fill, color: defaultBorderColor),
        );

        // Replace focusNode and request focus.
        focusNode.dispose();
        focusNode = FocusNode(debugLabel: 'DropdownButtonFormField2');
        focusNode.requestFocus();

        await tester.pumpWidget(buildFormField());
        await tester.pump(); // Wait for requestFocus to take effect.
        expect(
          findInputDecoratorBorderPainter(),
          paints..path(style: PaintingStyle.fill, color: const Color(0xff00ff00)),
        );

        // Replace focusNode and request focus.
        focusNode.dispose();
        focusNode = FocusNode(debugLabel: 'DropdownButtonFormField2');
        focusNode.requestFocus();

        await tester.pumpWidget(buildFormField());
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pump(); // Wait for unfocus to take effect.
        expect(
          findInputDecoratorBorderPainter(),
          paints..path(style: PaintingStyle.fill, color: defaultBorderColor),
        );
      });

      testWidgets(
        'DropdownButtonFormField2 should properly dispose its internal FocusNode '
        'when replaced by an external FocusNode',
        (WidgetTester tester) async {
          final valueListenable = ValueNotifier(menuItems.first);
          FocusNode? focusNode;
          addTearDown(() => focusNode?.dispose());

          Widget buildFormField() => MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
                valueListenable: valueListenable,
                items: menuItems.map<DropdownItem<int>>((int item) {
                  return DropdownItem<int>(
                    value: item,
                    child: Text(item.toString()),
                  );
                }).toList(),
                onChanged: (_) {},
                focusNode: focusNode,
              ),
            ),
          );

          await tester.pumpWidget(buildFormField());
          final FocusNode internalNode = tester
              .widget<Focus>(
                find
                    .descendant(
                      of: find.byType(DropdownButton2<int>),
                      matching: find.byType(Focus),
                    )
                    .first,
              )
              .focusNode!;

          // Replace internal FocusNode with external FocusNode.
          focusNode = FocusNode(debugLabel: 'DropdownButtonFormField2');
          await tester.pumpWidget(buildFormField());

          expect(
            internalNode.dispose,
            throwsA(
              isA<FlutterError>().having(
                (FlutterError error) => error.message,
                'message',
                startsWith('A FocusNode was used after being disposed.'),
              ),
            ),
          );
        },
      );
    },
  );

  group(
    'DropdownButtonFormField2 Error Properties',
    () {
      final List<int> menuItems = List<int>.generate(10, (int index) => index);

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

      testWidgets('validator error text should be displayed when validation fails', (
        WidgetTester tester,
      ) async {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        final valueListenable = ValueNotifier(menuItems.first);
        const errorMessage = 'Please select a value';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
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
        );

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        expect(find.text(errorMessage), findsOneWidget);
      });

      testWidgets('validator should show no error when returning null', (
        WidgetTester tester,
      ) async {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
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
        );

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        expect(inputDecorator.decoration.errorText, isNull);
        expect(inputDecorator.decoration.error, isNull);
      });

      testWidgets('autovalidateMode.always should validate on first build', (
        WidgetTester tester,
      ) async {
        final valueListenable = ValueNotifier(menuItems.first);
        int validateCalled = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
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
        );

        expect(validateCalled, 1);
        expect(find.text('Error'), findsOneWidget);
      });

      testWidgets('decoration errorStyle should be applied to error text', (
        WidgetTester tester,
      ) async {
        final valueListenable = ValueNotifier(menuItems.first);
        const errorStyle = TextStyle(color: Colors.orange, fontSize: 20);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
                valueListenable: valueListenable,
                items: buildItems(),
                onChanged: (_) {},
                autovalidateMode: AutovalidateMode.always,
                validator: (int? v) => 'Styled error',
                decoration: const InputDecoration(errorStyle: errorStyle),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        expect(inputDecorator.decoration.errorStyle, errorStyle);
        expect(find.text('Styled error'), findsOneWidget);
      });

      testWidgets('decoration errorMaxLines should be respected', (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
                valueListenable: valueListenable,
                items: buildItems(),
                onChanged: (_) {},
                autovalidateMode: AutovalidateMode.always,
                validator: (int? v) => 'A very long error message\nthat spans multiple lines',
                decoration: const InputDecoration(errorMaxLines: 2),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        expect(inputDecorator.decoration.errorMaxLines, 2);
      });

      testWidgets('errorBuilder should replace default error text when provided', (
        WidgetTester tester,
      ) async {
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
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
        );

        await tester.pumpAndSettle();

        expect(find.text('Custom: Required'), findsOneWidget);
        expect(find.text('Required'), findsNothing);
      });

      testWidgets('errorBuilder widget should be passed to InputDecorator as error', (
        WidgetTester tester,
      ) async {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
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
        );

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        final inputDecorator = getFormFieldInputDecorator(tester);
        // When errorBuilder is used, error widget is set instead of errorText.
        expect(inputDecorator.decoration.error, isNotNull);
        expect(inputDecorator.decoration.errorText, isNull);
        expect(find.byIcon(Icons.error), findsOneWidget);
      });

      testWidgets('errorBuilder should not be called when there is no error', (
        WidgetTester tester,
      ) async {
        final valueListenable = ValueNotifier(menuItems.first);
        bool errorBuilderCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
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
        );

        await tester.pumpAndSettle();

        expect(errorBuilderCalled, isFalse);
      });

      testWidgets('forceErrorText should force field to display error', (
        WidgetTester tester,
      ) async {
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
                valueListenable: valueListenable,
                items: buildItems(),
                onChanged: (_) {},
                forceErrorText: 'Forced error',
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Forced error'), findsOneWidget);
        final inputDecorator = getFormFieldInputDecorator(tester);
        expect(inputDecorator.decoration.errorText, 'Forced error');
      });

      testWidgets('forceErrorText should make isValid return false', (WidgetTester tester) async {
        final GlobalKey<FormFieldState<int>> fieldKey = GlobalKey<FormFieldState<int>>();
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButtonFormField2<int>(
                key: fieldKey,
                valueListenable: valueListenable,
                items: buildItems(),
                onChanged: (_) {},
                forceErrorText: 'Forced error',
              ),
            ),
          ),
        );

        expect(fieldKey.currentState!.isValid, isFalse);
        expect(fieldKey.currentState!.hasError, isTrue);
      });

      testWidgets(
        'forceErrorText should override InputDecoration.errorText when both are provided',
        (WidgetTester tester) async {
          final valueListenable = ValueNotifier(menuItems.first);

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DropdownButtonFormField2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                  decoration: const InputDecoration(errorText: 'Decoration error'),
                  forceErrorText: 'Forced error',
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.text('Forced error'), findsOneWidget);
          expect(find.text('Decoration error'), findsNothing);
        },
      );
    },
  );

  group(
    'Semantics',
    () {
      final List<int> menuItems = List<int>.generate(4, (int index) => index);

      final findDropdownButton = find.byType(DropdownButton2<int>);

      List<DropdownItem<int>> buildItems() {
        return menuItems.map<DropdownItem<int>>((int item) {
          return DropdownItem<int>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList();
      }

      testWidgets(
        'button should include expanded state semantics and update when menu opens and closes',
        (
          WidgetTester tester,
        ) async {
          final valueListenable = ValueNotifier(menuItems.first);

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DropdownButton2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                ),
              ),
            ),
          );

          // Before opening: should have expanded state but not be expanded.
          expect(
            tester.getSemantics(find.byType(DropdownButton2<int>)),
            matchesSemantics(
              isButton: true,
              hasExpandedState: true,
              isFocusable: true,
              hasTapAction: true,
              hasFocusAction: true,
              label: '${valueListenable.value}',
            ),
          );

          // Open the menu.
          await tester.tap(findDropdownButton);
          await tester.pumpAndSettle();

          // While the menu is open, BlockSemantics in ModalBarrier blocks the
          // button's semantics node (making tester.getSemantics return a stale node).
          // Verify the Semantics widget's expanded property directly instead.
          final expandedSemantics = tester.widget<Semantics>(
            find.descendant(
              of: find.byType(DropdownButton2<int>),
              matching: find.byWidgetPredicate(
                (widget) => widget is Semantics && widget.properties.expanded != null,
              ),
            ),
          );
          expect(expandedSemantics.properties.expanded, isTrue);

          // Close the menu by selecting an item.
          await tester.tap(find.text('1').last);
          await tester.pumpAndSettle();

          // After closing: should have expanded state but not be expanded.
          expect(
            tester.getSemantics(find.byType(DropdownButton2<int>)),
            matchesSemantics(
              isButton: true,
              hasExpandedState: true,
              isFocusable: true,
              isFocused: true,
              hasTapAction: true,
              hasFocusAction: true,
              label: '${valueListenable.value}',
            ),
          );
        },
      );

      testWidgets(
        'button should include hint semantics when no value is selected',
        (
          WidgetTester tester,
        ) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DropdownButton2<int>(
                  hint: const Text('Select a number'),
                  items: buildItems(),
                  onChanged: (_) {},
                ),
              ),
            ),
          );

          expect(
            tester.getSemantics(find.byType(DropdownButton2<int>)),
            matchesSemantics(
              hasExpandedState: true,
              isFocusable: true,
              hasTapAction: true,
              hasFocusAction: true,
              label: 'Select a number',
            ),
          );
        },
      );

      testWidgets(
        'semantics tree should only contain the selected item label when the menu is closed',
        (
          WidgetTester tester,
        ) async {
          final valueListenable = ValueNotifier(menuItems[1]);

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: DropdownButton2<int>(
                  valueListenable: valueListenable,
                  items: buildItems(),
                  onChanged: (_) {},
                ),
              ),
            ),
          );

          // Only the selected item (1) should be in the semantics tree.
          expect(
            find.bySemanticsLabel('${menuItems[0]}'),
            findsNothing,
          );
          expect(
            find.bySemanticsLabel('${menuItems[1]}'),
            findsOneWidget,
          );
          expect(
            find.bySemanticsLabel('${menuItems[2]}'),
            findsNothing,
          );
          expect(
            find.bySemanticsLabel('${menuItems[3]}'),
            findsNothing,
          );
        },
      );

      testWidgets('menu should include menu and menuItem role semantics', (
        WidgetTester tester,
      ) async {
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButton2<int>(
                valueListenable: valueListenable,
                items: buildItems(),
                onChanged: (_) {},
              ),
            ),
          ),
        );

        // Open the menu.
        await tester.tap(find.text('${valueListenable.value}'));
        await tester.pumpAndSettle();

        // Verify menu role.
        expect(
          find.byWidgetPredicate(
            (widget) => widget is Semantics && widget.properties.role == SemanticsRole.menu,
          ),
          findsOneWidget,
        );

        // Verify menuItem roles for each item.
        expect(
          find.byWidgetPredicate(
            (widget) => widget is Semantics && widget.properties.role == SemanticsRole.menuItem,
          ),
          findsNWidgets(menuItems.length),
        );
      });
    },
  );

  group('Modal Barrier', () {
    final List<int> menuItems = List<int>.generate(4, (int i) => i);

    final findDropdownButton = find.byType(DropdownButton2<int>);
    final findDropdownMenu = find.byType(ListView);

    List<DropdownItem<int>> buildItems() {
      return menuItems.map<DropdownItem<int>>((int item) {
        return DropdownItem<int>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList();
    }

    testWidgets(
      'outside tap should dismiss menu and not pass through '
      'when barrierDismissible and barrierBlocksInteraction are true (default)',
      (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);
        int outsideTaps = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  DropdownButton2<int>(
                    valueListenable: valueListenable,
                    items: buildItems(),
                    onChanged: (_) {},
                  ),
                  ElevatedButton(
                    onPressed: () => outsideTaps++,
                    child: const Text('Outside'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        expect(outsideTaps, 0);
        expect(findDropdownMenu, findsOneWidget);

        // The barrier absorbs the tap; warnIfMissed silences the hit-test warning.
        await tester.tap(find.text('Outside'), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(outsideTaps, 0);
        expect(findDropdownMenu, findsNothing);
      },
    );

    testWidgets(
      'outside tap should dismiss menu and pass through '
      'when barrierDismissible is true (default) and barrierBlocksInteraction is false',
      (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);
        int outsideTaps = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  DropdownButton2<int>(
                    barrierBlocksInteraction: false,
                    valueListenable: valueListenable,
                    items: buildItems(),
                    onChanged: (_) {},
                  ),
                  ElevatedButton(
                    onPressed: () => outsideTaps++,
                    child: const Text('Outside'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        expect(outsideTaps, 0);
        expect(findDropdownMenu, findsOneWidget);

        await tester.tap(find.text('Outside'));
        await tester.pumpAndSettle();

        expect(outsideTaps, 1);
        expect(findDropdownMenu, findsNothing);
      },
    );

    testWidgets(
      'outside tap should not dismiss menu or pass through '
      'when barrierDismissible is false and barrierBlocksInteraction is true (default)',
      (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);
        int outsideTaps = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  DropdownButton2<int>(
                    barrierDismissible: false,
                    valueListenable: valueListenable,
                    items: buildItems(),
                    onChanged: (_) {},
                  ),
                  ElevatedButton(
                    onPressed: () => outsideTaps++,
                    child: const Text('Outside'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        expect(outsideTaps, 0);
        expect(findDropdownMenu, findsOneWidget);

        await tester.tap(find.text('Outside'), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(outsideTaps, 0);
        expect(findDropdownMenu, findsOneWidget);
      },
    );

    testWidgets(
      'outside tap should not dismiss menu but pass through '
      'when barrierDismissible and barrierBlocksInteraction are false',
      (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);
        int outsideTaps = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  DropdownButton2<int>(
                    barrierDismissible: false,
                    barrierBlocksInteraction: false,
                    valueListenable: valueListenable,
                    items: buildItems(),
                    onChanged: (_) {},
                  ),
                  ElevatedButton(
                    onPressed: () => outsideTaps++,
                    child: const Text('Outside'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        expect(outsideTaps, 0);
        expect(findDropdownMenu, findsOneWidget);

        await tester.tap(find.text('Outside'));
        await tester.pumpAndSettle();

        expect(outsideTaps, 1);
        expect(findDropdownMenu, findsOneWidget);
      },
    );

    testWidgets(
      'menu should close without re-opening on anchor-button tap '
      'when barrierDismissible is true (default) and barrierBlocksInteraction is false',
      (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButton2<int>(
                barrierBlocksInteraction: false,
                valueListenable: valueListenable,
                items: buildItems(),
                onChanged: (_) {},
              ),
            ),
          ),
        );

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        expect(findDropdownMenu, findsOneWidget);

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        // Barrier intercepts the anchor-button tap, and barrierDismissible (true) closes the menu.
        expect(findDropdownMenu, findsNothing);
      },
    );

    testWidgets(
      'menu should not close on anchor-button tap '
      'when barrierDismissible and barrierBlocksInteraction are false',
      (WidgetTester tester) async {
        final valueListenable = ValueNotifier(menuItems.first);
        int stateChanges = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DropdownButton2<int>(
                barrierDismissible: false,
                barrierBlocksInteraction: false,
                onMenuStateChange: (_) => stateChanges++,
                valueListenable: valueListenable,
                items: buildItems(),
                onChanged: (_) {},
              ),
            ),
          ),
        );

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        expect(stateChanges, 1);
        expect(findDropdownMenu, findsOneWidget);

        await tester.tap(findDropdownButton);
        await tester.pumpAndSettle();

        // Menu's route stays active (no close/re-open).
        expect(stateChanges, 1);
        // Barrier intercepts the anchor-button tap, and barrierDismissible (false) keeps menu open.
        expect(findDropdownMenu, findsOneWidget);
      },
    );
  });
}
