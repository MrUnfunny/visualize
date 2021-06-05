import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/algorithm.dart';
import '../models/item.dart';
import '../models/item_iterator.dart';
import '../models/step.dart';
import '../utils.dart';

final sortProvider =
    StateNotifierProvider<ItemIteratorState, ItemIterator>((ref) {
  return ItemIteratorState();
});

class ItemIteratorState extends StateNotifier<ItemIterator> {
  ItemIteratorState()
      : super(
          ItemIterator.fromSteps(steps: defaultSteps),
        );

  void updateIterator(List<Step> steps) {
    state = state.copyWith(steps: steps);
  }

  void setDelay(int delay) {
    state = state.copyWith(delay: delay);
  }

  void setIsSorting(bool isSorting) {
    state = state.copyWith(isSorting: isSorting);
  }

  void setSortFunction(Algorithm algorithm) {
    print('sort fn ${algorithm.name}');
    state = state.copyWith(
      algorithm: algorithm,
      isSorting: false,
    );
    getSteps();
    firstStep();
  }

  void getSteps() {
    final steps = state.algorithm.function(state.steps.first.list);
    updateIterator(steps);
  }

  void nextStep() {
    if (state.steps.length == 1) {
      getSteps();
    }
    if (state.index < state.steps.length - 1) {
      state = state.copyWith(
        current: state.steps[state.index + 1],
        index: state.index + 1,
        message: state.steps[state.index + 1].reason,
      );
    }
  }

  void previousStep() {
    if (state.index > 0) {
      state = state.copyWith(
        current: state.steps[state.index - 1],
        index: state.index - 1,
        message: state.steps[state.index - 1].reason,
      );
    }
  }

  void firstStep() {
    state = state.copyWith(
      current: state.steps.first,
      index: 0,
      message: state.steps[0].reason,
    );
  }

  void lastStep() {
    if (state.steps.length == 1) {
      getSteps();
    }

    state = state.copyWith(
      current: state.steps.last,
      index: state.steps.length - 1,
      message: state.steps[state.steps.length - 1].reason,
    );
  }

  void createSortItems(BuildContext context, int length, {int? width}) {
    var sortItems = <Item>[];

    final rand = Random();
    for (var i = 0; i < length; i++) {
      if (state.isSorting) {
        setIsSorting(false);
      }
      final tempNum = rand.nextInt(200);
      final tempItem = Item(
        i,
        tempNum,
        defaultColor,
      );

      sortItems.add(tempItem);
    }
    final steps = state.algorithm.function(sortItems);
    state = state.copyWith(
      steps: steps,
      current: steps.first,
      index: 0,
      message: steps.first.reason,
    );
  }

  //TODO: Implement creating Array from user input
  void createFromArray() {}

  Future<void> play() async {
    if (state.steps.length == 1) {
      getSteps();
    }
    setIsSorting(true);
    while (state.index != state.steps.length - 1 && state.isSorting) {
      await Future<void>.delayed(Duration(milliseconds: state.delay));
      if (!state.isSorting) break;
      nextStep();
    }
    setIsSorting(false);
  }
}
