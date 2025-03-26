void main() {
  // dart 언어 에서 변수의 종류 : bool, int, double, String
  // collection(List, Set, Map)

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
  name = 'hello';
  print(name);

  name = null;
  print(name);
  print(name.runtimeType);

  /* 변수의 명명규칙
  * 변수는 반드시 문자 또는 '_'로 시작해야 한다.
  * 변수는 반드시 글자, 숫자, '_', '$' 의 조합으로 선언.
  * CamelCase, SnakeCase, 케밥표기법 등 다 되지만, 일관성 있게 작성요!
  */

  // int 100_score =100; // 숫자, 특수문자 시작안됨. 오직 문자, '_' 만!
  int num$ = 100;
  print(num$);

  // 특수문자는 '_', '$'만 사용가능!, 그외 특수문자 공백, 사용 불가
  // String num@ = 100;
}