import 'dart:isolate';

// 비동기적인 프로그래밍을 동기적으로 실행하기 위하여 async 적용
// dart는 기본적으로 싱글 스레드 기반이지만 Isolate를 이용하여
// 전통적인 멀티스레딩 대신에 멀티코어기반 cpu에서 병렬처리가 가능.
// Isolate는 독립적인 메모리가 공간을 가지고, 다른 Isolate와 메모리를 공유.
// Message Passing 방식으로 데이터 교환

void main() async {
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