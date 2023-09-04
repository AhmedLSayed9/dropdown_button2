import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_button2_test/examples.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/utils.dart';
import 'test_app.dart';

void main() {
  runGoldenTests(
    'FormField Example',
    (WidgetTester tester, ViewVariant variant) async {
      // GIVEN
      await tester.pumpTestApp(const FormFieldExample());

      // THEN
      await expectLater(
        find.byType(TestApp),
        matchesGoldenFile(
            'goldens/form_field_example/${variant.name}_closed_menu.png'),
      );

      // GIVEN
      final Finder dropdown = find.byType(DropdownButtonFormField2<String>);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // THEN
      await expectLater(
        find.byType(TestApp),
        matchesGoldenFile(
            'goldens/form_field_example/${variant.name}_open_menu.png'),
      );
    },
  );
}
