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

@immutable
class ItemIterator {
  ItemIterator(
      {required this.steps,
      required this.current,
      required this.index,
      required this.message,
      required this.delay,
      required this.isSorting});

  factory ItemIterator.fromSteps({required List<Step> steps, int delay = 100}) {
    return ItemIterator(
      steps: steps,
      current: steps.first,
      index: 0,
      message: 'Starting Position',
      delay: delay,
      isSorting: false,
    );
  }

  final List<Step> steps;
  final Step current;
  final int index;
  final String message;
  final int delay;
  final bool isSorting;

  ItemIterator copyWith({
    List<Step>? steps,
    Step? current,
    int? index,
    String? message,
    int? delay,
    bool? isSorting,
  }) {
    return ItemIterator(
      steps: steps ?? this.steps,
      current: current ?? this.current,
      index: index ?? this.index,
      message: message ?? this.message,
      delay: delay ?? this.delay,
      isSorting: isSorting ?? this.isSorting,
    );
  }

  @override
  String toString() {
    return 'ItemIterator(steps: $steps, current: $current, index: $index, message: $message)';
  }
}

const defaultColor = Color(0xFFADD8E6);
const matchActiveColor = Color(0xFF386AFF);
const sortedColor = Colors.greenAccent;

final defaultSteps = [
  Step(
    [
      Item(0, 32, defaultColor),
      Item(1, 27, defaultColor),
      Item(2, 45, defaultColor),
      Item(3, 6, defaultColor),
      Item(4, 19, defaultColor),
      Item(5, 38, defaultColor),
    ],
    'Starting Position',
  ),
];
