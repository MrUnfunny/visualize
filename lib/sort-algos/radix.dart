import 'dart:math';

import '../models/item.dart';
import '../models/step.dart';
import '../utils.dart';

List<Step> radixSort(List<Item> input) {
  var result = <Step>[];
  var largest = max(input);

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

  for (var e = 1; (largest / e).floor() > 0; e *= 10) {
    countSort(
        input, result, e, (largest / e).floor() % 10 == (largest / e).floor());

    result.add(Step(List<Item>.from(input),
        'Sorted according to significant digit no. ${logBase(e, 10) + 1}'));
  }

  result.add(Step(List<Item>.from(input), 'Sorted'));

  return result;
}

void countSort(List<Item> a, List<Step> result, int e, bool last) {
  var cnt = List<int>.filled(10, 0);
  var res = List<Item>.filled(a.length, Item(0, 0, defaultColor));

  for (var i = 0; i < a.length; ++i) {
    cnt[(a[i].value / e).floor() % 10]++;
  }

  for (var i = 1; i < cnt.length; ++i) {
    cnt[i] += cnt[i - 1];
  }

  for (var i = a.length - 1; i >= 0; --i) {
    res[cnt[(a[i].value / e).floor() % 10] - 1] =
        last ? a[i].copyWith(color: sortedColor) : a[i];
    result.add(Step(List<Item>.from(res),
        'put ${res[cnt[(a[i].value / e).floor() % 10] - 1]} in place'));

    cnt[(a[i].value / e).floor() % 10]--;
  }

  for (var i = 0; i < a.length; i++) {
    a[i] = res[i];
  }
}

int max(List<Item> a) {
  var largest = -10e9.toInt();
  for (var i in a) {
    if (i.value > largest) {
      largest = i.value;
    }
  }

  return largest;
}

double logBase(num x, num base) => log(x) / log(base);
