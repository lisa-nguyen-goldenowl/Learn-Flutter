String s = "haha haha";
List<int> numbers = [1, 2, 3, 4, 5];

List<String> stringNumbers = numbers.map((number) {
  return 'value=$number';
}).toList();
