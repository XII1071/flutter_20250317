import 'dart:isolate';

// 비동기적인 프로그래밍을 동기적으로 실행하기 위하여 async 적용
void main() async {
  // print("1");
  // // 싱글 스레드 기반이지만 Future.delayed()가 이벤트 루프에서 비동기적으로 실행됨
  // Future.delayed(Duration(seconds: 1), () => print("2"));
  // print("3");

  ReceivePort receivePort = ReceivePort();
  // 멀티스레드 대신 Isolate 사용 (Dart의 병렬 처리 방식)
  // Isolate는 기존의 싱글 스레드 이벤트 루프와 다르게 완전히 독립된 스레드에서 실행.
  // Isolate.spawn()을 사용하여 새로운 작업을 다른 프로세스에서 실행 가능.
  await Isolate.spawn(heavyTask, receivePort.sendPort);

  receivePort.listen((message) {
    print("결과: $message");
  });
}

void heavyTask(SendPort sendPort) {
  int sum = 0;
  for (int i = 0; i < 1000000000; i++) {
    sum += i;
  }
  sendPort.send(sum);
}