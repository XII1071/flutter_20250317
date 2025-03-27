import 'dart:io';

void main() {
  stdout.write("점수를 입력하세요: ");
  String? input = stdin.readLineSync();
  int? score = int.parse(input ?? 0.toString());
  if(score > 90){

  } else if (score > 80) {

  } else {

  }

  stdout.write("당신이 태어난 월을 입력하세요: ");
  String? input2 = stdin.readLineSync();
  int? score2 = int.parse(input2 ?? 0.toString());
  switch (score2) {
    case 3:case 4:case 5:
    print("당신은 봄에 태어나셨군요"); break;
    case 6:case 7:case 8:
    print("당신은 여름에 태어나셨군요"); break;
    case 9:case 10:
    print("당신은 가을에 태어나셨군요"); break;
    case 11:case 12:case 1:case 2:
    print("당신은 겨울에 태어나셨군요"); break;
    default:
      print("1~12까지 입력하세요");
  }



}