import 'dart:math';

void main() {
  // List 여러 값을 순서 대로 나열한 변수, [] 사용
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  print(blackPinkList);
  print(blackPinkList.runtimeType);
  print(blackPinkList[0]);
  // print(blackPinkList[4]); //RangeError

  //1) forEach :: 개별 접근
  blackPinkList.forEach((String name) {
    print('${name}');
  });
  blackPinkList.forEach((name) => print('${name}'));
  blackPinkList.add('토끼');

  //2) where :: 선별적 채택, 필터링
  final newBlackPinkList = blackPinkList.where((name) {
    return name != '토끼';
  });
  final newBlackPinkList2 = blackPinkList.where((name) => name != '토끼');
  print(newBlackPinkList2); // type이 WhereIterable<String>라서 ()사용
  print(newBlackPinkList2.runtimeType);

  //3) map :: 개별적 변형
  final newBlackPinkList3 = blackPinkList.map((name) {
    return '블랙핑크' + name;
  });
  final newBlackPinkList4 = blackPinkList
      .where((name) => name != '토끼')
      .map((name) => '블랙핑크 ' + name);
  print(newBlackPinkList4);
  int hap2 = 0;
  List<int> list =
  List<int>.filled(10, 0, growable: true).map((_)=> hap2 += 1).toList();
  print("list:"+list.toString());

  //4) reduce :: 리스트 내부의 값을 combine!
  // value는 누적값, element는 개별원소 값
  final allMembers = blackPinkList.reduce((value, element) {
    return value + ',' + element;
  });
  print("reduce결과: " + allMembers);

  final allMembers2 = blackPinkList.reduce(
        (value, element) => value + ',' + element,
  );
  print(allMembers2);
  print(allMembers2.runtimeType);


  //4) reduce는 리스트 요소의 타입과 리턴 타입이 같을 때, fold는 어떠한 타입도 반환
  final allMembers3 = blackPinkList.where((name) => name != '토끼')
      .fold(0, (val, ele)=>val+ele.length);
  print(allMembers3);

  List<int> score = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final hap = score.reduce((sum, element) => sum + element);
  print(hap);

  // List의 원소를 새로 생성하는 방법
  List<int> scores = List.generate(10, (index) => index + 1);
  print(scores);
  scores = List.generate(10, (_) => Random().nextInt(10) + 1);
  print(scores);

  // growable true이면 초기화 후 수정 가능, false이면 수정 불가
  List<int> scores2 = List<int>.filled(10, 0, growable: true);
  scores2 = scores2.asMap().keys.map((index) => index + 1).toList();
  print(scores2);

}