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

  result.add(Step(List<Item>.from(result.last.list), 'Sorted'));

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
  var pivot = high;

  var step = List<Item>.from(result.last.list);

  step[pivot] = step[pivot].copyWith(color: matchActiveColor);

  var i = low - 1;

  for (var j = low; j < high; j++) {
    if (step[j].value <= step[pivot].value) {
      i++;

      var temp = step[j];
      step[j] = step[i];
      step[i] = temp;

      var iSorting = step[i].color == sortedColor;

      step[i] = step[i].copyWith(color: matchActiveColor);
      step[j] = step[j].copyWith(color: matchActiveColor);

      result.add(Step(List<Item>.from(step),
          '${step[i].value} <= ${step[pivot].value}, so swap ${step[i].value} ${step[j].value}'));

      step[i] = step[i].copyWith(color: iSorting ? sortedColor : defaultColor);
      step[j] = step[j].copyWith(color: sortedColor);
    } else {
      var iSorting = true;
      if (i != -1) {
        iSorting = step[i].color == sortedColor;
      }
      var jSorting = step[j].color == sortedColor;
      if (i != -1) {
        step[i] =
            step[i].copyWith(color: iSorting ? sortedColor : matchActiveColor);
      }
      step[j] = step[j].copyWith(color: matchActiveColor);

      result.add(Step(List<Item>.from(step),
          '${step[j].value} > ${step[pivot].value}, Ignore'));
      if (i != -1) {
        step[i] =
            step[i].copyWith(color: iSorting ? sortedColor : defaultColor);
      }
      step[j] = step[j].copyWith(color: jSorting ? sortedColor : defaultColor);
    }
  }

  var temp = step[pivot];
  step[pivot] = step[i + 1];
  step[i + 1] = temp;

  step[i + 1] = step[i + 1].copyWith(color: sortedColor);
  result.add(Step(List<Item>.from(step), 'swap with pivot element'));

  return i + 1;
}
