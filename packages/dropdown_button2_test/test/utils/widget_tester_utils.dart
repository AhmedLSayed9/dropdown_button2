// ignore_for_file: deprecated_member_use

part of 'utils.dart';

/// An extension that adds functions to a [WidgetTester] object.
/// e.g. [configureView], [precacheImages],
extension WidgetTesterX on WidgetTester {
  Future<void> pumpTestApp(Widget widget) {
    return pumpWidget(
      TestApp(widget: widget),
    );
  }

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

  Future<void> verifyGolden(dynamic actual, Object file) async {
    await precacheImages();
    await expectLater(actual, matchesGoldenFile(file));
  }

  /// Pauses test until images are ready to be rendered.
  Future<void> precacheImages() async {
    final imageElements = find.byType(Image, skipOffstage: false).evaluate();
    final containerElements = find.byType(DecoratedBox, skipOffstage: false).evaluate();

    await runAsync(() async {
      for (final element in imageElements) {
        final widget = element.widget as Image;
        final image = widget.image;
        await precacheImage(image, element);
      }
      for (final element in containerElements) {
        final widget = element.widget as DecoratedBox;
        final decoration = widget.decoration;
        if (decoration is BoxDecoration) {
          final image = decoration.image?.image;
          if (image != null) {
            await precacheImage(image, element);
          }
        }
      }
    });

    await pumpAndSettle();
  }
}
