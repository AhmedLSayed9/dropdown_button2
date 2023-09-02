part of 'dropdown_button2.dart';

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Same as [num.clamp] but optimized for non-null [double].
///
/// This is faster because it avoids polymorphism, boxing, and special cases for
/// floating point numbers.
//
// See also: //dev/benchmarks/microbenchmarks/lib/foundation/clamp.dart
// TODO(Ahmed): use clampDouble from Flutter [flutter>=v3.3.0].
double _clampDouble(double x, double min, double max) {
  assert(min <= max && !max.isNaN && !min.isNaN);
  if (x < min) {
    return min;
  }
  if (x > max) {
    return max;
  }
  if (x.isNaN) {
    return max;
  }
  return x;
}

/// Adds separators to a list of heights.
///
/// The [itemHeights] property is the list of heights of the items.
///
/// The [separatorHeight] property is the height of the separator.
///
/// Returns a new list of heights with separators added.
List<double> addSeparatorsHeights({
  required List<double> itemHeights,
  required double? separatorHeight,
}) {
  final List<double> heights = [];

  bool addSeparator = false;
  if (separatorHeight != null) {
    for (final item in itemHeights) {
      if (addSeparator) {
        heights.add(separatorHeight);
      }
      heights.add(item);
      addSeparator = true;
    }
  } else {
    heights.addAll(itemHeights);
  }

  return heights;
}

// ignore: public_member_api_docs
extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
