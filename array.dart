void main() {
  final array = [2, 3, 1];
  final answer = sortArray(array);
  print(answer);
}

List<int> sortArray(List<int> array) {
  if (array[0] > array[2]) {
    final temp = array[0];
    array[0] = array[2];
    array[2] = temp;
    print('1: $array');
  }
  if (array[0] > array[1]) {
    final temp = array[0];
    array[0] = array[1];
    array[1] = temp;
    print('2: $array');
  }
  if (array[1] > array[2]) {
    final temp = array[1];
    array[1] = array[2];
    array[2] = temp;
    print('3: $array');
  }

  print('untouched: $array');

  return array;
}
