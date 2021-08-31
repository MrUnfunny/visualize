import 'package:flutter/widgets.dart';

import 'models/algorithm.dart';
import 'models/item.dart';
import 'models/step.dart';
import 'sort-algos/bubble.dart';
import 'sort-algos/heapsort.dart';
import 'sort-algos/insertion.dart';
import 'sort-algos/merge.dart';
import 'sort-algos/quick.dart';
import 'sort-algos/radix.dart';
import 'sort-algos/selection.dart';

const matchActiveColor = Color(0xFF8CDAD8);
final defaultColor = matchActiveColor.withOpacity(0.3);
const sortedColor = Color(0xFF69F0AE);

final List<Algorithm> sortAlgos = [
  Algorithm(
    id: 0,
    name: 'Bubble Sort',
    algoType: AlgoType.sorting,
    image: 'assets/thumbnails/bubble.gif',
    url: 'https://en.wikipedia.org/wiki/Bubble_sort',
    function: bubbleSort,
  ),
  Algorithm(
    id: 1,
    name: 'Insertion Sort',
    algoType: AlgoType.sorting,
    image: 'assets/thumbnails/insertion.gif',
    url: 'https://en.wikipedia.org/wiki/Insertion_sort',
    function: insertionSort,
  ),
  Algorithm(
    id: 2,
    name: 'Selection Sort',
    algoType: AlgoType.sorting,
    image: 'assets/thumbnails/selection.gif',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    function: selectionSort,
  ),
  Algorithm(
    id: 3,
    name: 'Merge Sort',
    algoType: AlgoType.sorting,
    image: 'assets/thumbnails/merge.gif',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    function: mergeSort,
  ),
  Algorithm(
    id: 4,
    name: 'Quick Sort',
    algoType: AlgoType.sorting,
    image: 'assets/thumbnails/quick.gif',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    function: quickSort,
  ),
  Algorithm(
    id: 5,
    name: 'Heap Sort',
    algoType: AlgoType.sorting,
    image: 'assets/thumbnails/heap.gif',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    function: heapSort,
  ),
  Algorithm(
    id: 6,
    name: 'Radix Sort',
    algoType: AlgoType.sorting,
    image: 'assets/thumbnails/heap.gif',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    function: radixSort,
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
