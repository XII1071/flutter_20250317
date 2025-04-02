void main(){
  // dart 언어에서 변수의 종류 : bool, int, double, String
  // null, Collection(List, Set, Map)
  bool isBool = false;
  print(isBool);
  print(isBool.runtimeType);

  int isInt = 100;
  print(isInt);
  print(isInt.runtimeType);

  double isDouble = 100;
  print(isDouble);
  print(isDouble.runtimeType);

  String isString = 100.toString();
  print(isString);
  print(isString.runtimeType);
  // isString = null;

  String? name;
  name = 'Hello';
  print(name);

  name = null;
  print(name);
  print(name.runtimeType);

  /* 변수의 명명규칙
  * 변수는 반드시 문자 또는 '_'로 시작해야 한다.
  * 변수는 반드시 글자, 숫자, '_', '$' 의 조합으로 선언.
  * CamelCase, SnakeCase, 케밥표기법 등 다 되지만, 일관성 있게 작성요!
  */

  // int 100_score = 100; // 숫자, 특수문자 시작 안됨. 오직, 문자, '_'만!
  int $num$ = 100;
  print($num$);

  //특수문자는 '_', '$'만 가능, 그외 특수 문자, 공백, 사용 불가
  //String num@ = 100;

  // 1) 기본 타입 형 변환(Primitive Type Casting)
  // Dart에서는 자동 형변환은 없다. 대부분 명시적인 형변환 필요
  int a = 10;
  double b = a.toDouble(); // int → double
  print(b); // 10.0

  double c = 3.14;
  int d = c.toInt(); // double → int (소수점 버림)
  print(d); // 3

  String str = "123";
  int num = int.parse(str); // String → int
  print(num); // 123

  double dnum = double.parse("3.14"); // String → double
  print(dnum); // 3.14

  int num2 = 42;
  String str2 = num2.toString(); // int → String
  print(str2); // "42"

  double num3 = 5.67;
  String str3 = num3.toStringAsFixed(1); // double → String (소수점 조절)
  print(str3); // "5.7"
}

class Temp {
  // '_'로 시작한 변수, 외부 접근 불가::private
  int _sum = 0;
}