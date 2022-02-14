import 'package:flutter/material.dart';

@immutable
class Box {
  const Box({
    required this.x,
    required this.y,
    required this.value,
  });

  final int x;
  final int y;
  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Box && other.x == x && other.y == y && other.value == value;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ value.hashCode;

  @override
  String toString() => 'Box(x: $x, y: $y, value: $value)';

  Box copyWith({
    int? x,
    int? y,
    String? value,
  }) {
    return Box(
      x: x ?? this.x,
      y: y ?? this.y,
      value: value ?? this.value,
    );
  }
}
