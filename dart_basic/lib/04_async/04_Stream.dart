import 'dart:async';

void main() async {
  // Future는 반환값을 딱 한 번 받는 비동기 프로그래밍에서 사용, 지속적으로 받을 때는 Stream 사용
  // Stream은 한번 리슨하면 Stream에 주입되는 모든 값들을 지속적으로 받아 옴.
  // Dart에서 Stream은 비동기 데이터의 흐름을 처리하는 데 사용
  // 스트림은 한 번에 하나씩 데이터를 전달하며, 비동기 이벤트 또는 데이터 스트림을 처리할 때 유용
  final controller = StreamController(); // StreamController 선언
  final stream = controller.stream; // Stream 가져오기

  // Stream에 listen() 함수를 실행하면 값이 주입될 때마다 콜백 함수를 실행할 수 있습니다.
  final streamListener1 = stream.listen((val) {
    print(val);
  });

  // Stream에 값을 주입할 때는 sink.add() 함수를 실행하면 됩니다.
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
  await controller.close();

  final controller2 = StreamController<String>();
  controller2.stream.listen((data) {
    print("Stream Data : $data");
  });
  controller2.add("Hello");
  controller2.add("World");
  controller2.close();

}