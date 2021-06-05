import 'package:flutter/widgets.dart';

import 'item.dart';
import 'step.dart';

enum AlgoType {
  sorting,
  mathematics,
  physics,
}

@immutable
class Algorithm {
  final int id;
  final String name;
  final AlgoType algoType;
  final String image;
  final String url;
  final List<Step> Function(List<Item>) function;

  Algorithm({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
    required this.algoType,
    required this.function,
  });
}
