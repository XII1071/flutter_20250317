void main() {
  // 변수의 타입이 동적으로 선언
  dynamic name = "Hello";
  print(name);
  print(name.runtimeType);
  name = true;  // 타입 고정(X)
  print(name);
  print(name.runtimeType);
  // dynamic name = 10; // 재선언 (X)
  name = 10.123;  // 업뎃(O)
  print(name);
  print(name.runtimeType);


}