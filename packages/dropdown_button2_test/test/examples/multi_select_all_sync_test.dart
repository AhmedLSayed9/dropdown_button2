import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_button2_test/examples.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

/// Returns whether the checkbox row for [itemLabel] is currently rendered
/// as checked (`Icons.check_box_outlined`) or unchecked.
bool _isItemChecked(WidgetTester tester, String itemLabel) {
  final Finder row = find.ancestor(
    of: find.text(itemLabel),
    matching: find.byType(Row),
  );
  final Icon icon = tester.widget<Icon>(
    find.descendant(of: row, matching: find.byType(Icon)),
  );
  return icon.icon == Icons.check_box_outlined;
}

void main() {
  testWidgets(
    "'All' checkbox stays in sync when every item is selected/deselected individually",
    (tester) async {
      await tester.pumpWidget(const TestApp(widget: MultiSelectExample()));
      await tester.tap(find.byType(DropdownButton2<String>));
      await tester.pumpAndSettle();

      expect(_isItemChecked(tester, 'All'), isFalse);

      // Select every real item one by one, without touching 'All' directly.
      for (final item in ['Item1', 'Item2', 'Item3', 'Item4']) {
        await tester.tap(find.text(item).last);
        await tester.pumpAndSettle();
      }

      // 'All' should now read as checked even though it was never tapped.
      expect(_isItemChecked(tester, 'All'), isTrue);

      // Deselecting a single item should uncheck 'All' again.
      await tester.tap(find.text('Item2').last);
      await tester.pumpAndSettle();
      expect(_isItemChecked(tester, 'All'), isFalse);
      expect(_isItemChecked(tester, 'Item1'), isTrue);
      expect(_isItemChecked(tester, 'Item3'), isTrue);
      expect(_isItemChecked(tester, 'Item4'), isTrue);

      // Re-selecting the missing item should check 'All' back on.
      await tester.tap(find.text('Item2').last);
      await tester.pumpAndSettle();
      expect(_isItemChecked(tester, 'All'), isTrue);

      // Tapping 'All' directly still clears every selection.
      await tester.tap(find.text('All').last);
      await tester.pumpAndSettle();
      for (final item in ['All', 'Item1', 'Item2', 'Item3', 'Item4']) {
        expect(_isItemChecked(tester, item), isFalse);
      }
    },
  );
}
