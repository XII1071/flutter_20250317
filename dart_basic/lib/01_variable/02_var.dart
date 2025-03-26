void main() {
  // var 변수에 값이 들어가면 자동으로 타입을 추론
  // 업데이트(O), 재선언(X), 타입 고정(O)


  var num;
  print(num);
  print(num.runtimeType);
  var name = 'Hello dart';
  print(name);
  print(name.runtimeType);
  // name = 100;
  // var name = 100;
  name = "멋진 하루";
}
