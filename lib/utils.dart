import 'package:flutter/widgets.dart';

import 'models/item.dart';
import 'models/step.dart';
import 'sort-algos/bubble.dart';

const matchActiveColor = Color(0xFF8CDAD8);
final defaultColor = matchActiveColor.withOpacity(0.3);
const sortedColor = Color(0xFF69F0AE);

const Map<String, List<Step> Function(List<Item>)> sortAlgos = {
  'Bubble Sort': bubbleSort,
  'Insertion Sort': bubbleSort,
  'Merge Sort': bubbleSort,
};

final defaultSteps = [
  Step(
    [
      Item(0, 132, defaultColor),
      Item(1, 217, defaultColor),
      Item(2, 45, defaultColor),
      Item(3, 6, defaultColor),
      Item(4, 95, defaultColor),
      Item(5, 38, defaultColor),
      Item(6, 18, defaultColor),
    ],
    'Starting Position',
  ),
];
