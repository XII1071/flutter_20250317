void main() {
  Person p = Person();
  p.introduce();
  Idol idol = Idol();
  idol.setName("에스파");
  idol.count = 4;
  print(idol.name);
  print(idol.count);
}

class Person {
  // 속성 선언시 초기화 완료.
  var name = "지원이잉";
  var age = 10;


  /*
  * Dart에서는 오버로딩이 없음.
  * Dart 언어는 동적인 타입의 언어. 선언 시점의 타입이 유효한 의미를 가지지 않으므로
  * 오버로딩처럼 어떤 메서드를 사용할 지 컴파일 타임에 선택하기 어렵다.
  * */

  void introduce() {
    print("안녕하세요? 저는 $name이고 나이는 $age입니다.");
  }
}
class Idol {
  // 속성 선언시 초기화해야 하나, late, var, dynamic일 경우 후에 초기화 가능
  late List<Person> p; // 복수의 Person 선언
  var name;
  dynamic count;

  void setName (String name) {
    this.name = name;
  }
}

class Mammal {
  // 생성자 활용할 경우 즉시 초기화하지 않아도 된다
  String name;
  Mammal(String name) : this.name=name;

}