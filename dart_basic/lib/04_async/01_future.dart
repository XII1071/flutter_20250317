void main() async {
  // 미래에 받을 값을 제네릭스로 정의
  Future<String> name;
  Future<int> number;
  Future<bool> isOpened;
  // 미래에 받을 값이 없을 때
  Future<void> doNothing;

  // 1) Future만 적용해 보기
  // addNumbers(1, 1);

  // 2) Fututre, async, await 적용하기
  // addNumbers2(1, 1);
  // addNumbers2(2, 2);

  // 3) main에 asyc하고 함수 리턴에 Future<void> 적용하기
  // await addNumbers3(1, 1);
  // await addNumbers3(2, 2);

  // 4) 결과 값 받기 함수 리턴에 Future<int> 적용하기
  final result = await addNumbers4(1, 1);
  print('결과값 $result');  // 일반 함수와 동일하게 반환값을 받을 수 있음
  final result2 = await addNumbers4(2, 2);
  print('결과값 $result2');
}

void addNumbers(int number1, int number2) {
  print('$number1 + $number2 계산 시작!');
  Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });
  print('$number1 + $number2 코드 실행 끝');
}

// async 키워드는 함수 매개변수 정의와 바디 사이에 입력합니다.
// await는 대기하고 싶은 비동기 함수 앞에 입력합니다.
void addNumbers2(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');
  await Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });
  print('$number1 + $number2 코드 실행 끝');
}

// async 키워드는 함수 매개변수 정의와 바디 사이에 입력합니다.
Future<void> addNumbers3(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');
  await Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });
  print('$number1 + $number2 코드 실행 끝');
}

Future<int> addNumbers4(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');
  await Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });
  print('$number1 + $number2 코드 실행 끝');
  return number1 + number2;
}