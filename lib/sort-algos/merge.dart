import 'package:flutter/material.dart' show Colors;

import '../models/item.dart';
import '../models/step.dart';

import '../utils.dart';

List<Step> mergeSort(List<Item> input) {
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

  mergeSortAlgo(result, List<Item>.from(input), 0, input.length - 1);

  result.add(
    Step(List<Item>.from(result.last.list), 'Sorted'),
  );

  return result;
}

void mergeSortAlgo(List<Step> result, List<Item> a, int start, int end) {
  if (start < end) {
    var mid = ((start + end) / 2).floor();

    mergeSortAlgo(result, a, start, mid);
    mergeSortAlgo(result, a, mid + 1, end);

    merge(result, a, start, mid, end);
  }
}

void merge(List<Step> result, List<Item> a, int start, int mid, int end) {
  var l = List<Item>.from(a.sublist(start, mid + 1));
  var r = List<Item>.from(a.sublist(mid + 1, end + 1));
  l.add(Item(100000, 100000, Colors.redAccent));
  r.add(Item(100000, 100000, Colors.redAccent));

  var i = 0, j = 0;
  for (var k = start; k <= end; k++) {
    var iSorted = a[start + i].color == sortedColor;
    var jSorted = a[start + j].color == sortedColor;

    a[start + i] = a[start + i].copyWith(color: matchActiveColor);
    a[start + j] = a[start + j].copyWith(color: matchActiveColor);

    if (l[i].value <= r[j].value) {
      result.add(
        Step(
          List<Item>.from(a),
          'start = $start, mid = $mid, end = $end',
        ),
      );

      if (iSorted) a[start + i] = a[start + i].copyWith(color: sortedColor);
      if (jSorted) a[start + j] = a[start + j].copyWith(color: sortedColor);
      a[k] = l[i];
      a[k] = a[k].copyWith(color: sortedColor);

      i++;
    } else {
      result.add(
        Step(
          List<Item>.from(a),
          'start = $start, mid = $mid, end = $end',
        ),
      );

      if (iSorted) a[start + i] = a[start + i].copyWith(color: sortedColor);
      if (jSorted) a[start + j] = a[start + j].copyWith(color: sortedColor);
      a[k] = r[j];
      a[k] = a[k].copyWith(color: sortedColor);

      j++;
    }
    if (iSorted) a[start + i] = a[start + i].copyWith(color: sortedColor);
    if (jSorted) a[start + j] = a[start + j].copyWith(color: sortedColor);
  }
  result.add(
    Step(
      List<Item>.from(a),
      'start = $start, mid = $mid, end = $end',
    ),
  );
}
