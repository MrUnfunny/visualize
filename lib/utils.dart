import 'package:flutter/widgets.dart';

import 'graph/graph_plotter_page.dart';
import 'math/epicycloid_curve.dart';
import 'math/fourier_series.dart';
import 'math/langton_ant.dart';
import 'math/lissajous_curve.dart';
import 'math/maurer_rose.dart';
import 'math/pi_approximation.dart';
import 'math/rose_pattern.dart';
import 'math/toothpick.dart';
import 'models/algorithm.dart';
import 'models/item.dart';
import 'models/step.dart';
import 'optics/optics_page.dart';
import 'screens/algo-screen/sort_screen.dart';
import 'sort-algos/bubble.dart';
import 'sort-algos/insertion.dart';
import 'sort-algos/merge.dart';
import 'sort-algos/selection.dart';
import 'wave/wave_page.dart';

const matchActiveColor = Color(0xFF8CDAD8);
final defaultColor = matchActiveColor.withOpacity(0.3);
const sortedColor = Color(0xFF69F0AE);

final List<Algorithm> sortAlgos = [
  Algorithm(
    id: 0,
    name: 'Bubble Sort',
    algoType: AlgoType.sorting,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/Bubble_sort',
    page: SortingPage(),
    function: bubbleSort,
  ),
  Algorithm(
    id: 1,
    name: 'Insertion Sort',
    algoType: AlgoType.sorting,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/Insertion_sort',
    page: SortingPage(),
    function: insertionSort,
  ),
  Algorithm(
    id: 2,
    name: 'Selection Sort',
    algoType: AlgoType.sorting,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    page: SortingPage(),
    function: selectionSort,
  ),
  Algorithm(
    id: 3,
    name: 'Merge Sort',
    algoType: AlgoType.sorting,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/Selection_sort',
    page: SortingPage(),
    function: mergeSort,
  ),
  Algorithm(
    id: 4,
    name: 'Wave',
    algoType: AlgoType.physics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/wave',
    page: WavePage(),
    function: mergeSort,
  ),
  Algorithm(
    id: 5,
    name: 'Optics',
    algoType: AlgoType.physics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: OpticsPage(),
    function: mergeSort,
  ),
  Algorithm(
    id: 6,
    name: 'Graph',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: GraphPlotterPage(),
    function: mergeSort,
  ),
  Algorithm(
    id: 7,
    name: 'Toothpick',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: ToothpickPattern(),
    function: mergeSort,
  ),
  Algorithm(
    id: 8,
    name: 'Rose Pattern',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: RosePattern(),
    function: mergeSort,
  ),
  Algorithm(
    id: 9,
    name: 'Pi Approx.',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: PiApproximation(),
    function: mergeSort,
  ),
  Algorithm(
    id: 10,
    name: 'Lissajous Curve',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: LissajousCurve(),
    function: mergeSort,
  ),
  Algorithm(
    id: 11,
    name: 'Langton Curve',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: LangtonAnt(),
    function: mergeSort,
  ),
  Algorithm(
    id: 12,
    name: 'Fourier Curve',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: FourierSeries(),
    function: mergeSort,
  ),
  Algorithm(
    id: 13,
    name: 'Epicycloid Curve',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: EpicycloidCurve(),
    function: mergeSort,
  ),
  Algorithm(
    id: 14,
    name: 'Maurer Rose',
    algoType: AlgoType.mathematics,
    image: 'image',
    url: 'https://en.wikipedia.org/wiki/optics',
    page: MaurerRoseCurve(),
    function: mergeSort,
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
