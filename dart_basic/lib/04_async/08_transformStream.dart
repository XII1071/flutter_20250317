import 'dart:async';

void main() async {
  //Stream은 비동기적으로 데이터를 제공하므로 await를 사용불가
  //await는 Future를 기다릴 때 사용하며, Stream은 listen()을 통해 데이터를 받음
  //listen()은 Future<void>를 반환하지 않으므로 await를 붙일 필요 없음

  Stream<int> numberStream = Stream.fromIterable([1,2,3,4,5]);

  //1) map()을 이용하여 스트림 데이터 변환
  Stream<String> transformStream(Stream<int> stream) {
    return stream.map((number) => "1. 변환된 값: ${number * 2}");
  }
  Stream<String> transformedStream = transformStream(numberStream);
  transformedStream.listen((data){print(data);});
  await Future.delayed(Duration(seconds: 0));

  //2) StreamTransformer를 이용하여 스트림 데이터 변환
  final transformer = StreamTransformer<int, String>.fromHandlers(
      handleData: (int value, EventSink<String> sink){
        sink.add("2. 변환된 값: ${value * 2}");
      }
  );
  Stream<String> transformedStream2 = numberStream.transform(transformer);
  transformedStream2.listen((data) {print(data);});
  await Future.delayed(Duration(seconds: 0));

  //3) StreamTransformer를 이용한 필터링
  final evenFilterTrans = StreamTransformer<int, int>.fromHandlers(
      handleData: (int value, EventSink<int> sink) {
        if(value % 2 == 0) {
          sink.add(value);
        }
      }
  );

  Stream<int> filteredStream = numberStream.transform(evenFilterTrans);
  filteredStream.listen((data) {print("even value: $data");});

}
