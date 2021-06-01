import 'package:flutter/widgets.dart';

import 'item.dart';
import 'step.dart';

@immutable
class Algorithm {
  final int id;
  final String name;
  final String image;
  final String url;
  final List<Step> Function(List<Item>) function;

  Algorithm({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
    required this.function,
  });
}
