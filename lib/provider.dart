import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils.dart';

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
    state = ItemIterator.fromSteps(
      steps: steps,
      delay: state.delay,
    );
  }

  void setDelay(int delay) {
    state = state = ItemIterator(
      steps: state.steps,
      current: state.current,
      index: state.index,
      message: state.message,
      delay: delay,
      isSorting: state.isSorting,
    );
  }

  void setIsSorting(bool isSorting) {
    state = state = ItemIterator(
      steps: state.steps,
      current: state.current,
      index: state.index,
      message: state.message,
      delay: state.delay,
      isSorting: isSorting,
    );
  }

  void nextStep() {
    if (state.index < state.steps.length - 1) {
      state = ItemIterator(
        steps: state.steps,
        current: state.steps[state.index + 1],
        index: state.index + 1,
        message: state.steps[state.index + 1].reason,
        delay: state.delay,
        isSorting: state.isSorting,
      );
    }
  }

  void previousStep() {
    if (state.index > 0) {
      state = ItemIterator(
        steps: state.steps,
        current: state.steps[state.index - 1],
        index: state.index - 1,
        message: state.steps[state.index - 1].reason,
        delay: state.delay,
        isSorting: state.isSorting,
      );
    }
  }

  void createSortItems(BuildContext context, List<Step> Function(List<Item>) fn,
      {int length = 7}) {
    var sortItems = <Item>[];

    final rand = Random();
    for (var i = 0; i < length; i++) {
      if (state.isSorting) {
        setIsSorting(false);
      }
      final tempNum = rand.nextInt(200);
      var tempheight = tempNum + 1.0;
      var tempwidth = MediaQuery.of(context).size.width / (2 * (length + 1));
      final tempItem = Item(
        i,
        tempNum,
        tempheight,
        tempwidth,
        defaultColor,
      );

      sortItems.add(tempItem);
    }
    final steps = fn(sortItems);
    state = ItemIterator.fromSteps(steps: steps);
  }

  Future<void> play() async {
    setIsSorting(true);
    while (state.index != state.steps.length - 1 && state.isSorting) {
      await Future<void>.delayed(Duration(milliseconds: state.delay));

      nextStep();
    }
    setIsSorting(false);
  }
}
