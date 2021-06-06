import 'dart:math';

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

  final finalList = List<Item>.from(result.last.list);
  finalList
    ..first = finalList.first.copyWith(color: sortedColor)
    ..last = finalList.last.copyWith(color: sortedColor);

  result.add(
    Step(finalList, 'Sorted'),
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
    var activeIndexI = max(0, a.indexOf(l[i]));
    var activeIndexJ = max(0, a.indexOf(r[j]));

    var iSorted = a[activeIndexI].color == sortedColor;
    var jSorted = a[activeIndexJ].color == sortedColor;

    a[activeIndexI] = a[activeIndexI].copyWith(color: matchActiveColor);
    a[activeIndexJ] = a[activeIndexJ].copyWith(color: matchActiveColor);

    if (l[i].value <= r[j].value) {
      a[k] = l[i].copyWith(color: matchActiveColor);

      if (l[i].value != 100000 && r[j].value != 100000) {
        result.add(
          Step(
            List<Item>.from(a),
            'start = $start, mid = $mid, end = $end\n${l[i].value} <= ${r[j].value} so insert ${l[i]} at index $k',
          ),
        );
      } else {
        result.add(
          Step(
            List<Item>.from(a),
            'start = $start, mid = $mid, end = $end\n${l[i].value == 100000 ? r[j] : l[i]} is largest so insert it at index k',
          ),
        );
      }

      a[k] = a[k].copyWith(color: sortedColor);

      if (iSorted) {
        a[activeIndexI] = a[activeIndexI].copyWith(color: sortedColor);
      }
      if (jSorted) {
        a[activeIndexJ] = a[activeIndexJ].copyWith(color: sortedColor);
      }

      i++;
    } else {
      a[k] = r[j].copyWith(color: matchActiveColor);
      if (l[i].value != 100000 && r[j].value != 100000) {
        result.add(
          Step(
            List<Item>.from(a),
            'start = $start, mid = $mid, end = $end\n${l[i].value} > ${r[j].value} so insert ${r[j]} at index $k',
          ),
        );
      } else {
        result.add(
          Step(
            List<Item>.from(a),
            'start = $start, mid = $mid, end = $end\n${l[i].value == 100000 ? r[j] : l[i]} is largest so insert it at index $k',
          ),
        );
      }

      if (iSorted) {
        a[activeIndexI] = a[activeIndexI].copyWith(color: sortedColor);
      }
      if (jSorted) {
        a[activeIndexJ] = a[activeIndexJ].copyWith(color: sortedColor);
      }
      a[k] = a[k].copyWith(color: sortedColor);

      j++;
    }
    if (iSorted) a[activeIndexI] = a[activeIndexI].copyWith(color: sortedColor);
    if (jSorted) a[activeIndexJ] = a[activeIndexJ].copyWith(color: sortedColor);
  }
}
