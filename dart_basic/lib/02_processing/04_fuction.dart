// 재사용을 위하여 명령을 묶어놓은 것이 함수
// 1) 리턴 X, 매개변수 X
void done() { print("done"); }

// 2) 리턴 X, 매개변수 O
void done2(String str) { print(str + " done"); }

// 3) 리턴 O, 매개변수 X
String done3() { return "done"; }

// 4) 리턴 O, 매개변수 X
String done4(String str) { return str + "done"; }

// 1) 매개변수의 형태에 따라서 포지셔널 파라미터를 이용한 함수 정의
int add2Numbers(int a, int b) { return a + b; }
int add2Numbers2(int a, [int b=2]) { return a + b; }

// 2) 매개변수의 형태에 따라서 네임드 파라미터를 이용한 함수 정의
int add2a({required int a, required int b}) { return a+b; }
int add2b({required int a, int b = 3}) { return a+b; }

// 3) 포지셔널 + 네임드 파라미터 혼용 (포지셔널이 네임드 보다 앞에 있어야 함.)
int add2Combine(int a, {required int b, int c= 4}) {
  return a + b + c;
}

// 4) 매개변수로 익명함수 사용 (함수명 또는 함수 선언부)
void expFnc(Function callback){ callback(); }
void expFnc1(void Function() callback) {callback();}
void expFnc2(void Function(int, int) callback, int a, int b) {callback(5, 5);}
int expFnc3(int Function() callback) {return callback();}
void expFnc4(int Function(int, int) callback, int a, int b) {callback(a, b);}


void main() {
  expFnc(() {print("매개변수로 익명함수 사용");});
  expFnc(() => ("매개변수로 람다함수 사용"));
  expFnc1(()=> print("리턴 없는 콜백"));
  print("="*30);
  expFnc2((int a, int b)=> print(a + b), 1, 1);
  print(expFnc3((){return 10;}));

  add2Numbers(1, 1);print(add2Numbers2(1));
  print(add2a(a: 2, b: 3));print(add2a(b: 2, a:3));
  print(add2b(a: 1, b: 1));print(add2b(a: 1));
  print(add2Combine(1, b: 2, c:3));print(add2Combine(1, b: 2));
}
