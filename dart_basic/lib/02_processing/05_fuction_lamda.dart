import 'dart:io';

void main() {
  // lamba 함수는 단 하나의 스테이트먼트
  List<int> numbers = [1, 2, 3, 4, 5];
  // final allMembers = numbers.reduce((value, element){
  //   return value + element;
  // });
  final allMembers = numbers.reduce((value, element) => value + element);
  print(allMembers);
  print(allMembers.runtimeType);
  // var newNumbers = numbers.map((n) {
  //   return n * n;
  // }).toList();
  var newNumbers = numbers.map((n) => n * n).toList();
  print(newNumbers);print(newNumbers.runtimeType);
  // var filterNumbers = newNumbers.where((n) {return n % 2 == 0;}).toList();
  var filterNumbers = newNumbers.where((n) => n % 2 == 0).toList();
  numbers.forEach((n) => stdout.write(n)); // 개행 없이 출력
}