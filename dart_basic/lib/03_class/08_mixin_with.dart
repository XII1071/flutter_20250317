void main() {
  Duck duck = Duck();
  duck.fly();
  duck.swim();
}
class Birds {
  late String _name;
  set name(String name){_name = name;}
  String get name => _name;
  void layEgg(){print("알 알");}
}
class Fish {
  late String _name;
  set name(String name){_name = name;}
  String get name => _name;
}
// mixin과 on이 있을 때 상속받는(with) 클래스에서 extends로 상속을 받아야 함.
mixin Flyable on Birds {
  void fly() {print('${this.name} 훨 훨');}
}
mixin Swimmable { void swim();}

// mixin은 여러개 적용 가능하나, mixin on은 복수개 적용 안됨.
// 이유는 mixin on은 클래스도 상속해야 하고, 이때 단 하나의 클래스만 상속 가능.
// 정의가 된 메서드는 interface처럼 반드시 재정의 할 필요가 없다.
class Duck extends Birds with Flyable, Swimmable {
  void swim() {print("첨 벙");}
  // void fly() {print("훨 훨");} // mixin은 정의된 메서드는 재정의 안해줘도 됨
// void layEgg() {}
}
class Boramae extends Birds with Flyable {
  void fly() {print('${this.name} 훨 훨');}
}