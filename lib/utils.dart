import 'package:flutter/widgets.dart';

import 'models/algorithm.dart';
import 'models/item.dart';
import 'models/step.dart';
import 'sort-algos/bubble.dart';
import 'sort-algos/insertion.dart';
import 'sort-algos/selection.dart';

const matchActiveColor = Color(0xFF8CDAD8);
final defaultColor = matchActiveColor.withOpacity(0.3);
const sortedColor = Color(0xFF69F0AE);

final List<Algorithm> sortAlgos = [
  Algorithm(
    id: 0,
    name: 'Bubble Sort',
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/Bubble_sort',
    function: bubbleSort,
  ),
  Algorithm(
    id: 0,
    name: 'Insertion Sort',
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/Insertion_sort',
    function: insertionSort,
  ),
  Algorithm(
    id: 0,
    name: 'Selection Sort',
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    function: selectionSort,
  ),
];

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
