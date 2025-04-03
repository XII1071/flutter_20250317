void main() {
  // Positional Parameter 형태로 Record 선언, 순서에 따른다.
  (String, int) person = ('길동', 20);
  // (String, int) person = (20, '길동');
  print(person);

  (String, int, bool) person2 = ('길동', 20, true);
  print(person2.$1);
  print(person2.$2);
  print(person2.$3);

  // Named Parameter 형태로 Record 선언, 순서는 상관이 없어진다.
  ({String name, int age}) person3 = (name: '길동', age: 20);
  print(person3);
}
