import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'test_variants.dart';
import 'widget_tester_utils.dart';

typedef GoldenTestCallback = Future<void> Function(
  WidgetTester widgetTester,
  ViewVariant viewVariant,
);

/// Wrapper around [testWidgets] that will be executed for all test variants.
@isTest
void runGoldenTests(
  String description,
  GoldenTestCallback callback, {
  ValueVariant<ViewVariant>? variantsOverride,
}) {
  final ValueVariant<ViewVariant> variants = variantsOverride ?? defaultVariants;
  testWidgets(
    description,
    (WidgetTester tester) async {
      final ViewVariant variant = variants.currentValue!;
      debugDefaultTargetPlatformOverride = variant.targetPlatform;
      debugDisableShadows = false;

      tester.configureView(variant);
      await callback(tester, variant);

      debugDisableShadows = true;
      debugDefaultTargetPlatformOverride = null;
    },
    variant: variants,
    tags: ['golden'],
    // [intended] Only run Golden Tests on the same platform, i.e: MacOS (Also, should run on a CI
    // pipeline that uses Mac). This is necessary because fonts will have small differences when
    // tests are run on different platforms "Flutter related".
    // Alternatively, You can use the default "Ahem" font that shows black spaces instead of Roboto font.
    skip: !Platform.isMacOS,
  );
}
