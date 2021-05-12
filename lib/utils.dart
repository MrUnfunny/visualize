import 'package:flutter/material.dart';

@immutable
class Item {
  Item(
    this.key,
    this.value,
    this.height,
    this.width,
    this.color,
  );

  final int key;
  final int value;
  final double height;
  final double width;
  final Color color;

  @override
  String toString() {
    return value.toString();
  }

  Item copyWith({
    int? key,
    int? value,
    double? height,
    double? width,
    Color? color,
  }) {
    return Item(
      key ?? this.key,
      value ?? this.value,
      height ?? this.height,
      width ?? this.width,
      color ?? this.color,
    );
  }
}

@immutable
class Step {
  Step(
    this.list,
    this.reason,
  );

  final List<Item> list;
  final String reason;

  @override
  String toString() {
    return '$list  $reason\n';
  }

  Step copyWith({
    List<Item>? list,
    String? reason,
  }) {
    return Step(
      list ?? this.list,
      reason ?? this.reason,
    );
  }
}

const defaultColor = Colors.blueAccent;
const matchActiveColor = Colors.redAccent;
const sortedColor = Colors.greenAccent;
