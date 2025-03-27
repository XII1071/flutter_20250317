// enum :: 원소의 index는 0부터 시작
enum Status { approved, pending, rejected }
enum Days { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
enum Size {
  small(30, "작은"), medium(50, "중간"), large(70, "큰");
  final int grade;
  final String msg;
  const Size(this.grade, this.msg);
  String get message {
    switch (this) {
      case Size.small:
        return this.msg + "size를 선택하셨습니다.";
      case Size.medium:
        return this.msg + "size를 선택하셨습니다.";
      case Size.large:
        return this.msg + "size를 선택하셨습니다.";
    }
  }
}

enum AnimalType {
  mammal("포유류"), birds("조류"), reptile("파충류");
  final String species;
  const AnimalType(this.species);
}

class Animal {
  String name;
  AnimalType type;
  Animal(this.name, this.type);
  void describe() {
    print('$name는 ${type.species}입니다.');
  }
}

// enum은 정의된 값만 사용. class의 static const는 오류 입력 가능
// enum은 values를 사용해서 모든 enum 값을 순회할 수 있음.
class Colors {
  static const String red = "red";
  static const String green = "green";
  static const String blue = "blue";
}
void main() {
  Animal dog = Animal("댕댕이", AnimalType.mammal);
  dog.describe();
  print(Colors.blue);
  String color = Colors.red;
  color = "yellow";
  Status status = Status.approved;
  print(status);
  for (var s in Status.values) {
    print(s);
  }
  for (int i = 0; i < Status.values.length; i++) {
    print('${Status.values[i].index} : ${Status.values[i]}');
  }
  for (var day in Days.values) {
    print(day);
    print(day.name);
    print(day.index);
    print(day.runtimeType);
  }
  for (int i=0;i<Size.values.length;i++) {
    print('${Size.values[i].index} / ${Size.values[i].name} / ${Size.values[i].grade}');
  }
  for(var s in Size.values) {
    print('${s.index} / ${s.name} / ${s.grade}');
    print(s.message);
  }
  print(Size.small.message);
}