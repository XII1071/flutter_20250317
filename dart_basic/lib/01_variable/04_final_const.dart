void main() {
  final String name = 'Hello World';
  // name = '안녕 세상아';  //final로 선언한 변수는 업뎃,재지정 :: (X)
  print(name);
  print(name.runtimeType);

  const double PI = 3.141592;
  print(PI);
  print(PI.runtimeType);

  // final 실행할 때 초기화 되는 상수 일 때
  final DateTime now = DateTime.now();
  print(now);
  print(now.runtimeType);

  // const 실행할 때 초기화 되는 상수에 사용 불가
  // const DateTime now2 = DateTime.now();


}