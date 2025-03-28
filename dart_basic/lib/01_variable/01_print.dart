import 'dart:io';

void main() {
  // 한 줄 주석 ctrl + /
  /*
  여러 줄 주석
  ctrl + shift + /
  */


  print("=" * 30);
  print("♥${10}");

  for (var i = 0; i < 10; i++) {
    print('hello ${i + 1}');
  }
  String text = 'Hello ';
  String repeated = List.generate(3, (_) => text).join();
  print(repeated);

  print("Hello, World!\rNew Line Overwritten!"); //이전 줄 덮어쓰기

  for (int i = 0; i < 10; i++) {
    stdout.write(i); //개행 없이 출력
  }
}