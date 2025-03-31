void main() {
  // Dart에서 String객체는 불변(immutable)이며 한 번 생성되면 변경 불가
  String str = "Hello";
  print('str.hashCode: ' + str.hashCode.toString());
  str = str + "world";
  print('str.hashCode: ' + str.hashCode.toString());

  // 문자열 비교는 == 연산자로 수행, 동일한 문자열 값은 같은 객체로 취급(constant Pool활용)
  String str1 = "Hello";
  String str2 = "hello";
  String str3 = "Hello";
  print("identical(str1, str2): " + identical(str1, str2).toString());
  print("str1 == str2 : " + (str1 == str2).toString()); //false
  print(
    "str1.hashCode == str2.hashCode : " +
        (str1.hashCode == str2.hashCode).toString(),
  ); //true
  print("identical(str1, str3): " + identical(str1, str3).toString());
  print("str1 == str3 : " + (str1 == str3).toString()); //true
  print(
    "str1.hashCode == str3.hashCode : " +
        (str1.hashCode == str3.hashCode).toString(),
  ); //true
  // identical은 두 객체가 같은 비교할 때 사용
  String str5 = "Dart";
  String str6 = "Dart".substring(0, 4);
  print(str5 == str6); // true (값 비교)
  // String은 자동으로 동일한 리터럴을 캐싱하지만,
  // 동적으로 생성된 문자열은 다를 수 있음.
  print(identical(str5, str6)); // false (다른 객체)

  String result = "";
  StringBuffer buffer = StringBuffer();
  for (int i = 0; i < 100; i++) {
    //result += i.toString(); // +를 이용해서 문자열 객체를 생성하는 반복작업은 비추
    buffer.write(i); // 새로운 객체 생성 없이 버퍼를 사용하여 성능 향상.
  }

  print("C:\Program Files\Dart"); //C:Program FilesDart \는 특수문자
  print(r"C:\Program Files\Dart"); // \는 특수문자라서 문자열 앞에 r
  String multiLine = '''
    다중 줄 문자열을 
    사용할 때 \''' 또는 \"""를 사용한다.
  ''';
  print(multiLine);
  str = "Hello";
  print(str.length);
  print("Dart".toUpperCase());
  print("Dart".toLowerCase());
  print("    Dart   ".trim());
  print("    Dart   ".trimLeft());
  print("    Dart   ".trimRight());
  print("Hello World".replaceAll("World", "Dart"));
  print("Hello World".substring(0, 4));
  print("Hello World".contains("Wo"));
  print("Hello World".indexOf("l"));
  print("Hello World".lastIndexOf("l"));
  print("Boys be ambitious".split(" "));
  print("Boys be ambitious".split(" ").runtimeType);
  print("7".padLeft(3, "0"));
  print("Star".padRight(8, "⭐"));
  print("ABC".codeUnits); //문자열을 UTF-16 코드 List 반환
  print("".isEmpty);
  print("Hello".isNotEmpty);
}