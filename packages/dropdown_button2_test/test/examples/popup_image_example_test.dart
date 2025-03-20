import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_button2_test/examples.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/utils.dart';
import 'test_app.dart';

void main() {
  runGoldenTests(
    'Popup Image Example',
    (WidgetTester tester, ViewVariant variant) async {
      // GIVEN
      await tester.pumpTestApp(const PopupImageExample());
      await tester.precacheImages();

      // THEN
      await expectLater(
        find.byType(TestApp),
        matchesGoldenFile('goldens/popup_image_example/${variant.name}_closed_menu.png'),
      );

      // GIVEN
      final Finder dropdown = find.byType(DropdownButton2<Object>);
      await tester.longPress(dropdown);
      await tester.pumpAndSettle();

      // THEN
      await expectLater(
        find.byType(TestApp),
        matchesGoldenFile('goldens/popup_image_example/${variant.name}_open_menu.png'),
      );
    },
  );
}
