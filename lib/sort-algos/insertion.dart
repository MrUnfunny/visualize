import '../models/item.dart';
import '../models/step.dart';

import '../utils.dart';

//TODO: return proper reasons

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

    while (j >= 0 && j < step.list.length && step.list[j].value > key.value) {
      step.list[j + 1] = step.list[j + 1].copyWith(color: matchActiveColor);
      step.list[j] = step.list[j].copyWith(color: matchActiveColor);

      result.add(
        Step(
          List<Item>.from(step.list),
          '${step.list[j].value} > ${key.value}, swap ${step.list[j].value} ${step.list[j + 1].value}',
        ),
      );

      step.list[j] = step.list[j].copyWith(color: defaultColor);
      step.list[j + 1] = step.list[j + 1].copyWith(color: defaultColor);

      step.list[j + 1] = step.list[j];
      j--;
    }
    step.list[j + 1] = key;

    if (i != j + 1) {
      result.add(
        Step(
          List<Item>.from(step.list),
          '${step.list[j + 1].value} > ${key.value}, swap ${step.list[j + 1].value} ${key.value}',
        ),
      );
    } else {
      result.add(
        Step(
          List<Item>.from(step.list),
          'Ignore',
        ),
      );
    }
  }
  return result;
}
