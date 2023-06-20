// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_variants.dart';

/// An extension that adds functions to a [WidgetTester] object.
/// e.g. [configureView], [precacheImages],
extension WidgetTesterX on WidgetTester {
  /// Configure the tester view to represent the given view variant.
  void configureView(ViewVariant viewVariant) {
    // TODO(Ahmed): use WidgetTester.view [flutter>=v3.10.0].
    // view.physicalSize = viewVariant.physicalSize;
    // view.devicePixelRatio = viewVariant.devicePixelRatio;

    binding.window.physicalSizeTestValue = viewVariant.physicalSize;
    binding.window.devicePixelRatioTestValue = viewVariant.devicePixelRatio;

    addTearDown(binding.window.clearPhysicalSizeTestValue);
    addTearDown(binding.window.clearDevicePixelRatioTestValue);
  }

  /// Pauses test until images are ready to be rendered.
  Future<void> precacheImages() async {
    await runAsync(() async {
      for (final Element element in find.byType(Image).evaluate().toList()) {
        final Image widget = element.widget as Image;
        final ImageProvider<Object> image = widget.image;
        await precacheImage(image, element);
        await pumpAndSettle();
      }

      for (final Element element in find.byType(DecoratedBox).evaluate().toList()) {
        final DecoratedBox widget = element.widget as DecoratedBox;
        final Decoration decoration = widget.decoration;
        if (decoration is BoxDecoration) {
          final ImageProvider<Object>? image = decoration.image?.image;
          if (image != null) {
            await precacheImage(image, element);
            await pumpAndSettle();
          }
        }
      }
    });
  }
}
