import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() async {
  // countdown(5);
  // countdown1(5);

  // 순차적인 진행으로 인해 카운트다운이 안됨.
  // stdout.write("입력하세요: ");
  // String? input = stdin.readLineSync();
  // stdout.write("입력 내용: "+ input!);

  // print("입력하세요: ");
  // StreamSubscription? inputSubscription;
  // final inputStream = stdin.transform(utf8.decoder).transform(LineSplitter());
  //
  // inputSubscription = inputStream.listen((input) {
  //   print("입력 내용: " + input);
  //   inputSubscription?.cancel();
  // });

  // inputSubscription = inputStream.listen((input) {
  //   Future.delayed(Duration(seconds: 0), () {
  //     print("입력 내용: " + input);
  //     inputSubscription?.cancel();
  //   });
  // });

  // Bomb start
  Bomb bomb = Bomb();
  bomb.start();
  print("빨간선(0)과 파란선(1) 중에 선택하세요(숫자 입력): ");
  StreamSubscription? inputSubscription;
  final inputStream = stdin.transform(utf8.decoder).transform(LineSplitter());

  inputSubscription = inputStream.listen((input) {
    bomb.choice(input);
    inputSubscription?.cancel();
  });
  // Bomb end
}

// 비동기 함수 호출
void countdown(int n) async {
  for (int i = n; i > 0; i--) {
    print(i);
    await Future.delayed(Duration(seconds: 1));
  }
}

// coundown1()을 호출하는 곳에 await를 붙일 수 있다.호출한 곳을 비동기로 운영가능
Future<void> countdown1(int n) async {
  for (int i = n; i > 0; i--) {
    print(i);
    await Future.delayed(Duration(seconds: 1));
  }
}

class Bomb {
  int lifeLine = Random().nextInt(2); // 0 또는 1 무작위 생성
  bool state = false;

  Future<void> start() async {
    for (int i = 10; i > 0; i--) {
      if (state) return; // 정지 조건
      print(i);
      await Future.delayed(Duration(milliseconds: 500)); // 0.5초 대기
    }
    // 카운트 다운이 0으로 끝났을 때 강제 종료
    if (!state) {
      print("Bomb~!");
      exit(-1);
    }
  }

  void choice(String input) {
    state = true; // 카운트다운 중단
    if (int.tryParse(input) == lifeLine) {
      print("휴~ 살았다.");
    } else {
      print("꽝~!");
    }
  }
}