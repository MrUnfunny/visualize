import 'utils.dart';

List<Step> bubbleSort(List<Item> input) {
  var result = <Step>[];
  var step = Step(<Item>[], 'starting position');

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
    for (var j = 0; j < step.list.length - i - 1; j++) {
      step.list[j] = step.list[j].copyWith(color: matchActiveColor);
      step.list[j + 1] = step.list[j + 1].copyWith(color: matchActiveColor);

      if (step.list[j].value > step.list[j + 1].value) {
        var temp = step.list[j];
        step.list[j] = step.list[j + 1];
        step.list[j + 1] = temp;

        result.add(
          Step(
            List<Item>.from(step.list),
            '${step.list[j + 1].value} > ${step.list[j].value}, swap ${step.list[j].value} ${step.list[j + 1].value}',
          ),
        );
      } else {
        result.add(
          Step(
            List<Item>.from(step.list),
            '${step.list[j].value} <= ${step.list[j + 1].value}, no change',
          ),
        );
      }

      step.list[j] = step.list[j].copyWith(color: defaultColor);
      step.list[j + 1] = step.list[j + 1].copyWith(color: defaultColor);

      if (j == step.list.length - i - 2) {
        step.list[j + 1] = step.list[j + 1].copyWith(color: sortedColor);
      }
      if (i == step.list.length - 2) {
        step.list[j] = step.list[j].copyWith(color: sortedColor);
        step.list[j + 1] = step.list[j + 1].copyWith(color: sortedColor);

        result.add(
          Step(
            List<Item>.from(step.list),
            ' sorted',
          ),
        );
      }
    }
  }
  return result;
}
