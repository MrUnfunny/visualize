import 'dart:math';

import '../models/item.dart';
import '../models/step.dart';

import '../utils.dart';

List<Step> quickSort(List<Item> input) {
  var result = <Step>[];
  var step = Step(<Item>[], 'Starting Position');

  for (var i = 0; i < input.length; i++) {
    step.list.add(
      Item(
        i,
        input[i].value,
        defaultColor,
      ),
    );
  }

  result.add(Step(List<Item>.from(step.list), step.reason));

  quickSortAlgo(result, 0, result.last.list.length - 1);

  var finalList = List<Item>.from(result.last.list);

  for (var i = 0; i < finalList.length; i++) {
    finalList[i] = finalList[i].copyWith(color: sortedColor);
  }
  result.add(Step(finalList, 'Sorted'));

  return result;
}

void quickSortAlgo(List<Step> result, int low, int high) {
  if (low < high) {
    var pivot = partition(result, low, high);

    quickSortAlgo(result, low, pivot - 1);
    quickSortAlgo(result, pivot + 1, high);
  }
}

int partition(List<Step> result, int low, int high) {
  var random = Random();
  var pivot = low + random.nextInt(high - low);

  var step = List<Item>.from(result.last.list);

  var i = low - 1;

  var temp1 = step[pivot].copyWith(color: matchActiveColor);
  step[pivot] = step[high].copyWith(color: matchActiveColor);
  step[high] = temp1;

  result.add(Step(List<Item>.from(step),
      'Randomly choose ${step[high]} and swapped it with ${step[pivot]}'));

  step[pivot] = step[pivot].copyWith(color: defaultColor);
  step[high] = step[high].copyWith(color: defaultColor);

  pivot = high;

  step[pivot] = step[pivot].copyWith(color: matchActiveColor);

  for (var j = low; j < high; j++) {
    if (step[j].value <= step[pivot].value) {
      i++;

      var iSorted = step[i].color == sortedColor;
      var jSorted = step[j].color == sortedColor;

      step[i] = step[i].copyWith(color: matchActiveColor);
      step[j] = step[j].copyWith(color: matchActiveColor);

      var temp = step[j];
      step[j] = step[i];
      step[i] = temp;

      result.add(Step(List<Item>.from(step),
          '${step[i].value} <= ${step[pivot].value}, so swap ${step[i].value} ${step[j].value}'));

      step[i] = step[i].copyWith(color: iSorted ? sortedColor : defaultColor);
      step[j] = step[j].copyWith(color: jSorted ? sortedColor : defaultColor);
    } else {
      var jSorted = step[j].color == sortedColor;

      step[j] = step[j].copyWith(color: matchActiveColor);

      result.add(Step(List<Item>.from(step),
          '${step[j].value} > ${step[pivot].value}, Ignore'));

      step[j] = step[j].copyWith(color: jSorted ? sortedColor : defaultColor);
    }
  }

  step[pivot] = step[pivot].copyWith(color: sortedColor);

  var temp = step[pivot];
  step[pivot] = step[i + 1];
  step[i + 1] = temp;

  result.add(Step(List<Item>.from(step), 'swap with pivot element'));

  return i + 1;
}
