void main() {
  // 아래 코드와 같지만 한줄에 해결 할 수 있다.
  // final newJeans = ['민지', '해린'];
  // final minji = newJeans[0];
  // final haerin = newJeans[1];
  final [minji, haerin] = ['민지', '해린'];
  print(minji);
  print(haerin);

  final numbers = [1, 2, 3, 4, 5, 6, 7, 8];
  final [x, y, ..., z] = numbers;
  print(x);  print(y);  print(z);

  final minJiIdol = Idol(name: '민지', age: 19);
  final Idol(name: name3, age: age3) = minJiIdol;
  print(name3);
  print(age3);
}
class Idol {
  final String name;
  final int age;

  Idol({
    required this.name,
    required this.age,
  });
}
