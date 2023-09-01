part of 'dropdown_button2.dart';

/// Represents an item in a dropdown menu created by a [DropdownButton2].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class DropdownItem<T> extends DropdownMenuItem<T> {
  /// Creates a dropdown item.
  ///
  /// The [child] property must be set.
  const DropdownItem({
    required super.child,
    super.onTap,
    super.value,
    super.enabled,
    super.alignment,
    this.closeOnTap = true,
    super.key,
  });

  /// Whether the dropdown should close when the item is tapped.
  ///
  /// Defaults to true.
  final bool closeOnTap;
}
