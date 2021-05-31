import '../models/item.dart';
import '../models/step.dart';

import '../utils.dart';

List<Step> insertionSort(List<Item> input) {
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

  for (var i = 1; i < step.list.length; i++) {
    final key = step.list[i];
    var j = i - 1;

    step.list[i] = step.list[i].copyWith(color: matchActiveColor);

    if (step.list[j].value <= key.value) {
      step.list[j] = step.list[j].copyWith(color: sortedColor);
    }

    while (j >= 0 && j < step.list.length && step.list[j].value > key.value) {
      // Used to keep track if [j] and [j+1] elements are sorted in left side of
      // key. This is used for color of these Items in the list.
      var jSort = false;
      var j1Sort = false;

      if (step.list[j + 1].color == sortedColor) {
        j1Sort = true;
      }
      if (step.list[j].color == sortedColor) {
        jSort = true;
      }

      step.list[j] = step.list[j].copyWith(color: matchActiveColor);
      step.list[j + 1] = step.list[j + 1].copyWith(color: matchActiveColor);

      result.add(
        Step(
          List<Item>.from(step.list),
          'key = ${key.value}\n${step.list[j].value} > ${key.value}, Shift ${step.list[j].value} to left',
        ),
      );

      if (jSort) {
        step.list[j] = step.list[j].copyWith(color: sortedColor);
      }
      if (j1Sort) {
        step.list[j + 1] = step.list[j + 1].copyWith(color: sortedColor);
      }

      step.list[j + 1] = step.list[j];
      j--;
    }

    step.list[j + 1] = key;
    step.list[j + 1] = step.list[j + 1].copyWith(color: sortedColor);

    if (i != j + 1) {
      result.add(
        Step(
          List<Item>.from(step.list),
          'key = ${key.value}\nShift ${step.list[j + 2].value} and insert $key in place',
        ),
      );
    } else {
      step.list[i] = step.list[i].copyWith(color: sortedColor);
      result.add(
        Step(
          List<Item>.from(step.list),
          'Ignore, ${step.list[i].value} is already largest',
        ),
      );
    }

    if (i == step.list.length - 1) {
      step.list[i] = step.list[i].copyWith(color: sortedColor);
      result.add(
        Step(
          List<Item>.from(step.list),
          'Sorted',
        ),
      );
    }
    if (step.list[i].color != sortedColor) {
      step.list[i] = step.list[i].copyWith(color: defaultColor);
    }
  }
  return result;
}
