void main() {
  // periodic : 1초마다 새로운 값을 생성, take(n) : 0부터 n-1까지
  Stream<int> stream = Stream.periodic(
    Duration(seconds: 1),
        (count) => count,
  ).take(5);
  stream.listen((event){
    print("Stream 값: $event");
  });
}