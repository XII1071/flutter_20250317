import 'dart:io';

void main() {
  stdout.write("점수를 입력하세요: ");
  String? input = stdin.readLineSync();
  int? score = int.parse(input ?? 0.toString());
  if (score > 90) {
  } else if (score > 80) {
  } else {}

  stdout.write("당신이 태어난 월을 입력하세요: ");
  String? input2 = stdin.readLineSync();
  int? score2 = int.parse(input2 ?? 0.toString());
  // 1)일반적인 switch case 문
  // switch (score2) {
  //   case 3:case 4:case 5:
  //     print("당신은 봄에 태어나셨군요"); break;
  //   case 6:case 7:case 8:
  //     print("당신은 여름에 태어나셨군요"); break;
  //   case 9:case 10:
  //     print("당신은 가을에 태어나셨군요"); break;
  //   case 11:case 12:case 1:case 2:
  //     print("당신은 겨울에 태어나셨군요"); break;
  //   default:
  //     print("1~12까지 입력하세요");
  // }

  // 2) Switch Expressions
  // var season = switch (score2) {
  //   6 || 7 || 8 => 'Born in Summer',
  //   9 || 10 => 'Born in Fall',
  //   (11 || 12 || 1 || 2) => 'Born in Winter',
  //   (3 || 4 || 5) => 'Born in Spring',
  //   _ => 'Are you born in the barn?',
  // };

  // 3) Guard Clause : 조건 추가
  // var season = switch (score2) {
  //   _ when [6,7,8].contains(score2) => 'Born in Summer',
  //   9 || 10 when score2 != 15 => 'Born in Fall',
  //   (11 || 12 || 1 || 2) => 'Born in Winter',
  //   (3 || 4 || 5) => 'Born in Spring',
  //   _ => 'Are you born in the barn?',
  // };

  // 4) Pattern Matching
  switch (score2) {
    case int num when num > 0 && num < 13:
      switch (num) {
        case 6 || 7 || 8 : print('Born in Summer'); break;
        case 9 || 10 : print('Born in Fall'); break;
        case 11 || 12 || 1 || 2 : print('Born in Winter'); break;
        case 3 || 4 || 5 :  print('Born in Spring');break;
        default : print('Are you born in the barn?');
      }
      break;
    default:
      print("입력된 수는 유효하지 않습니다.");
  }
}