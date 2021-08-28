import '../models/item.dart';
import '../models/step.dart';
import '../utils.dart';

int leftChild(int index) => 2 * index + 1;
int rightChild(int index) => 2 * index + 2;

void maxHeapify(List<Item> a, int heapSize, int index, List<Step> result) {
  var lChild = leftChild(index);
  var rChild = rightChild(index);

  var largest = index;

  if (lChild < heapSize && a[lChild].value > a[largest].value) {
    largest = lChild;
  }

  if (rChild < heapSize && a[rChild].value > a[largest].value) {
    largest = rChild;
  }

  if (largest != index) {
    var temp = a[index];
    a[index] = a[largest];
    a[largest] = temp;

    a[index] = a[index].copyWith(color: matchActiveColor);
    a[largest] = a[largest].copyWith(color: matchActiveColor);

    result.add(Step(List<Item>.from(a),
        '${a[largest].value} is the largest children, so swaping it with ${a[index]}'));

    a[index] = a[index].copyWith(color: defaultColor);
    a[largest] = a[largest].copyWith(color: defaultColor);

    maxHeapify(a, heapSize, largest, result);
  }
}

void buildMaxHeap(List<Item> a, int heapSize, List<Step> result) {
  for (var i = (heapSize / 2).floor(); i >= 0; i--) {
    maxHeapify(a, heapSize, i, result);
  }
}

List<Step> heapSort(List<Item> input) {
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

  var heapSize = input.length;

  buildMaxHeap(step.list, heapSize, result);

  result.add(Step(List<Item>.from(step.list), 'created a max heap'));

  while (heapSize > 0) {
    var temp = step.list[heapSize - 1];
    step.list[heapSize - 1] = step.list.first.copyWith(color: sortedColor);
    step.list.first = temp;

    heapSize--;

    result.add(Step(
        List<Item>.from(step.list), 'swapped last element with first element'));

    maxHeapify(step.list, heapSize, 0, result);
  }

  step.list.first = step.list.first.copyWith(color: sortedColor);
  result.add(Step(List<Item>.from(step.list), 'Sorted'));

  return result;
}
