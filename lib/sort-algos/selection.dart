import '../models/item.dart';
import '../models/step.dart';

import '../utils.dart';

List<Step> selectionSort(List<Item> input) {
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

  for (var i = 0; i < step.list.length - 1; i++) {
    var smallest = i;
    step.list[i] = step.list[i].copyWith(color: matchActiveColor);
    for (var j = i + 1; j < step.list.length; j++) {
      step.list[smallest] =
          step.list[smallest].copyWith(color: matchActiveColor);

      if (step.list[j].value < step.list[smallest].value) {
        step.list[j] = step.list[j].copyWith(color: matchActiveColor);

        result.add(
          Step(
            List<Item>.from(step.list),
            '${step.list[j].value} < ${step.list[smallest].value}, smallest = ${step.list[j].value}',
          ),
        );
        if (i != smallest) {
          step.list[smallest] =
              step.list[smallest].copyWith(color: defaultColor);
        }

        step.list[j] = step.list[j].copyWith(color: matchActiveColor);

        smallest = j;
      } else {
        step.list[j] = step.list[j].copyWith(color: matchActiveColor);

        result.add(
          Step(
            List<Item>.from(step.list),
            'Smallest = ${step.list[smallest].value}\n${step.list[j].value} >= ${step.list[smallest].value}, ignore',
          ),
        );
        step.list[j] = step.list[j].copyWith(color: defaultColor);
      }
    }
    final temp = step.list[i];
    step.list[i] = step.list[smallest];
    step.list[smallest] = temp.copyWith(color: defaultColor);

    step.list[i] = step.list[i].copyWith(color: sortedColor);

    result.add(
      Step(
        List<Item>.from(step.list),
        'Swap ${step.list[i].value} ${step.list[smallest].value}',
      ),
    );
  }
  step.list.last = step.list.last.copyWith(color: sortedColor);
  result.add(
    Step(
      List<Item>.from(step.list),
      'Sorted',
    ),
  );
  return result;
}
