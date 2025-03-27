void main() {
  double num = 3;
  // 이항 연산자
  print(num + 2);
  print(num - 2);
  print(num * 2);
  print(num / 2); // 그냥 나눔
  print(num % 2); // 나머지만
  print(num ~/ 2); // 몫만

  // 단항 연산자
  print(num++);
  print(num--);
  print(++num);
  print(--num);
  print(-num); // 부호의 반전
  print(!true); // 논리의 반전
  print(~5); // int에만 적용 가능
  print("str" is String); // 타입 체크
  print(5 is String);
  print(true is bool);
  print("hello" as String); // 캐스팅
  print(int.parse("12") as int);
  print(bool.parse("true") as bool);

  // 할당 연산자(Assignment Operators)
  dynamic a = 10;
  print(a += 5);
  print(a -= 5);
  print(a *= 5);
  print(a /= 5);
  print(a %= 5);
  a = 10;
  print(a = (a ~/ 5) as int);
  print("=" * 30);

  // 비교 연산자(Comparison Operators)
  a = 10;
  int b = 2;
  print(a == b);
  print(a > b);
  print(a != b);

  // 논리 연산자(Logical Operators)
  bool x = true, y = false;
  print(x && y);
  print(x || y);
  print(!x);

  // 비트 연산자(Bitwise Operators)
  print(a.toString() + ", " + b.toString());
  print(a & b);
  print(a | b);
  print(a ^ b);
  print(~b);
  print(b<<2); //왼쪽 시프트
  print(a>>2); //오른쪽 시프트

  // 삼항 연산자(Conditional Operators)
  print(a>b?"big":a==b?"same":"small");

  // Null 관련 연산자(Null-aware Operators)
  print("="*10+"Null 관련 연산자"+"="*10);
  String? name = null; //Nullable 변수 선언::String 이지만 null 일수도 있다.
  // name ="Dart";
  // name = 100;
  // print(name!.length);   // Null 강제 해제 :: null이면 아닙을 확신할 때
  print(name?.length);    // Null-aware 접근 :: null이면 null을 반환
  print(name ?? "Guest");   // Null 병합 연산자 :: null이면 기본값 제공
  print(name);
  name ??= "Guest"; // Null 병합 활당 연산자 :: null이면 기본값 활당
  print(name);
}