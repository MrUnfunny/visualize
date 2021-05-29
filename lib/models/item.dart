import 'package:flutter/material.dart';

@immutable
class Item {
  Item(
    this.key,
    this.value,
    this.color,
  );

  final int key;
  final int value;
  final Color color;

  @override
  String toString() {
    return value.toString();
  }

  Item copyWith({
    int? key,
    int? value,
    Color? color,
  }) {
    return Item(
      key ?? this.key,
      value ?? this.value,
      color ?? this.color,
    );
  }
}
