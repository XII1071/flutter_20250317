void main() {
  Set<int> numbers = {1, 2, 3};
  numbers.add(4);
  numbers.addAll([5, 6, 7]);
  print(numbers);

  numbers.remove(3);
  numbers.removeWhere((num) => num % 2 == 0);
  print(numbers);
  numbers.clear();
  print(numbers);

  Set<String> names = {'Alice', "Bob", "Charlie"};
  print(names.contains("Bob"));
  print(names.first);
  print(names.last);
  print(names.elementAt(1));

  Set<int> setA = {1,2,3,4};
  Set<int> setB = {5,6,7,8};
  Set<int> setC = setA.union(setB);
  print(setC);
  print(setA.union(setB));
  print(setA.intersection(setB)); // 교집합
  print(setA.difference(setB)); // 차집합
  print(setC.map((n) => n * n));
  print(setC);
  print(setC.map((n) => n%2==0));
  print(setC);
  List<int> setList = setC.toList();
  print(setList);
}

