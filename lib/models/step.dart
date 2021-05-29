import 'package:flutter/material.dart';

import 'item.dart';

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
