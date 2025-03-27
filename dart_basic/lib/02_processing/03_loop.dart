import 'dart:io';
import 'dart:math';

void main2() {
  while (true) {
    stdout.write("출력할 단을 입력하세요: ");
    String? input = stdin.readLineSync();
    if (input == "Q" || input == "q") {
      print("종료합니다.");
      break;
    }
    int? dan;
    try {
      dan = int.parse(input ?? 0.toString());
    } catch (e) {
      print("숫자가 아닙니다.");
      continue;
    }
    for (int i = 1; i < 10; i++) {
      print('$dan * $i = ${digit2(i * dan)}');
    }
  }
}

String digit2(int i) {
  return '${i < 10 ? " " + i.toString() : i.toString()}';
}

void main() {
  int you = Random().nextInt(3);
  stdout.write("가위(0), 바위(1), 보(2) 중 하나를 숫자로 입력하세요: ");
  String? input = stdin.readLineSync();
  int? me;
  try {
    me = int.parse(input ?? 0.toString());
  } catch (e) {
    print("숫자가 아닙니다.");
    return;
  }
  int result = me - you;
  print(result);
}