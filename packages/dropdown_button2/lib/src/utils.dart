part of 'dropdown_button2.dart';

void _uniqueValueAssert<T>(
  List<DropdownItem<T>>? items,
  ValueListenable<T?>? valueListenable,
  ValueListenable<List<T>>? multiValueListenable,
) {
  if (items == null || items.isEmpty) {
    return;
  }

  String assertMessage(T value) {
    return "There should be exactly one item with [DropdownButton]'s value: "
        '$value. \n'
        'Either zero or 2 or more [DropdownItem]s were detected '
        'with the same value';
  }

  assert(
    valueListenable?.value == null ||
        items.where((DropdownItem<T> item) {
              return item.value == valueListenable!.value;
            }).length ==
            1,
    assertMessage(valueListenable!.value as T),
  );

  final currentMultiValue = multiValueListenable?.value.lastOrNull;
  assert(
    currentMultiValue == null ||
        items.where((DropdownItem<T> item) {
              return item.value == currentMultiValue;
            }).length ==
            1,
    assertMessage(currentMultiValue),
  );
}

class _ConditionalDecoratedBox extends StatelessWidget {
  const _ConditionalDecoratedBox({
    required this.child,
    this.height,
    this.width,
    this.decoration,
    this.foregroundDecoration,
  });

  final double? height;
  final double? width;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return decoration != null || foregroundDecoration != null
        ? Container(
            height: height,
            width: width,
            decoration: decoration,
            foregroundDecoration: foregroundDecoration,
            child: child,
          )
        : SizedBox(height: height, width: width, child: child);
  }
}
