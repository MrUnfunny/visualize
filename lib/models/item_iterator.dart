import 'package:flutter/widgets.dart';

import '../utils.dart';
import 'algorithm.dart';
import 'step.dart';

@immutable
class ItemIterator {
  ItemIterator({
    required this.steps,
    required this.current,
    required this.index,
    required this.message,
    required this.delay,
    required this.isSorting,
    required this.algorithm,
  });

  factory ItemIterator.fromSteps({required List<Step> steps, int delay = 100}) {
    return ItemIterator(
      steps: steps,
      current: steps.first,
      index: 0,
      message: 'Starting Position',
      delay: delay,
      isSorting: false,
      algorithm: sortAlgos.first,
    );
  }

  final List<Step> steps;
  final Step current;
  final int index;
  final String message;
  final int delay;
  final bool isSorting;
  final Algorithm algorithm;

  ItemIterator copyWith({
    List<Step>? steps,
    Step? current,
    int? index,
    String? message,
    int? delay,
    bool? isSorting,
    Algorithm? algorithm,
  }) {
    return ItemIterator(
      steps: steps ?? this.steps,
      current: current ?? this.current,
      index: index ?? this.index,
      message: message ?? this.message,
      delay: delay ?? this.delay,
      isSorting: isSorting ?? this.isSorting,
      algorithm: algorithm ?? this.algorithm,
    );
  }

  @override
  String toString() {
    return 'ItemIterator(steps: $steps, current: $current, index: $index, message: $message)';
  }
}
