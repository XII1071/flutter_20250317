// typedef 함수의 시그니처를 정의::함수의 선언부를 정의하는 키워드
typedef Operation = void Function(int x, int y);

void add (int x, int y) {
  print('결과값: ${x + y}');
}

typedef Operation2 = int Function(int, int);
void lambdaCallback(Operation2 oper) {
  int result = oper(6, 3);
  print("result: $result");
}

void lambdaCallback2(Operation2 oper, int x, int y) {
  int result = oper(6, 3);
  print("result: $result");
}

void main() {
  // 익명함수로 재정의
  Operation oper = (int x, int y) {print(x+y);};
  oper(1, 1);
  
  // 선언적 함수로 재정의
  Operation oper1 = add;
  oper1(2, 2);
  lambdaCallback((a, b) => a * b);
  lambdaCallback2((a, b) => a * b, 1, 1);

}