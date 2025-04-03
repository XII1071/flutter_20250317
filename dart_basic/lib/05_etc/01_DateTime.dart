import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/*
intl 패키시 설치 방법 pubspec.yaml에
dependencies:
  intl: ^0.18.0
추가한 후 pub get, pub upgrade, pub outdated 클릭 할 것
*/

void main() async {
  await initializeDateFormatting();

  //현재 날짜 및 시간 가져오기
  DateTime now = DateTime.now();
  print("현재 날짜 및 시간: $now"); // 2025-04-01 14:30:00.123456

  //날짜의 월 가져오기
  print("특정 날짜의 월: ${now.month}");  // 12 (12월)

  //특정 날짜 생성
  DateTime specificDate = DateTime(2025, 4, 1, 12, 30, 45);
  print("특정 날짜: $specificDate"); // 2025-04-01 12:30:45.000

  //시간의 분 가져오기
  print("특정 시간의 분: ${specificDate.minute}");  //

  // 날짜 더하기
  DateTime futureDate = now.add(Duration(days: 10));
  print("10일 후: $futureDate");

  // 날짜 빼기
  DateTime pastDate = now.subtract(Duration(days: 5));
  print("5일 전: $pastDate");

  // 당월 마지막날 구하기
  print(getDate(DateTime(2025,3,1).subtract(Duration(days: 1))));

  //두 날짜 차이 계산
  DateTime startDate = DateTime(2025, 4, 1);
  DateTime endDate = DateTime(2025, 4, 15);

  Duration difference = endDate.difference(startDate);
  print("두 날짜 차이: ${difference.inDays}일"); // 14일

  //날짜 비교
  DateTime date1 = DateTime(2025, 4, 1);
  DateTime date2 = DateTime(2025, 4, 15);

  print(date1.isBefore(date2)); // true (date1이 date2보다 이전인지)
  print(date1.isAfter(date2));  // false (date1이 date2보다 이후인지)
  print(date1.isAtSameMomentAs(date2)); // false (두 날짜가 같은지)

  //날짜 포맷 변환 (intl 패키지 사용)
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  print("포맷된 날짜: $formattedDate"); // 예: 2025-04-01 14:30:45

  // 숫자가 아닌 "April" 같은 문자열로 출력
  String monthName = DateFormat.MMMM('en_US').format(now);
  print("월 이름 (영어): $monthName");  // 예: April

  // 한국어 월 이름 출력
  // initializeDateFormatting()을 호출하지 않으면 다국어 날짜 포맷이 작동하지 않음
  // import 'package:intl/date_symbol_data_local.dart'; 추가 필요
  // await initializeDateFormatting();을 호출해야 해결됨
  String monthNameKR = DateFormat.MMMM('ko_KR').format(now);
  print("월 이름 (한글): $monthNameKR");  // 예: 4월

  print("오늘은 ${getWeekdayName(now.weekday)}요일입니다.");

  print(getDate(now));
  print(getTime(now));

}

String getWeekdayName(int weekday) {
  List<String> weekdays = ["월", "화", "수", "목", "금", "토", "일"];
  return weekdays[weekday - 1];  // 배열은 0부터 시작하므로 -1 필요
}

String getDate(DateTime dt) {
  return '${dt.year.toString()}-${digit2(dt.month)}-${digit2(dt.day)} ';
}

String getTime (DateTime dt) {
  return '${digit2(dt.hour)}:${digit2(dt.minute)}:${digit2(dt.second)} ';
}

String digit2(int val) {
  return val<10?"0"+val.toString():val.toString();
}
