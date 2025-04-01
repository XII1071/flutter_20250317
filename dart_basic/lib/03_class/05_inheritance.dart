void main() {
  var child = Child();
  child.instanceSay();
  print(Parent.staticVar);
  Parent.staticSay();
  // static 변수와 메서드는 자식에게 상속 불가
  // print(Child.staticVar);
  // Child.staticSay();

  var parent1 = Parent();
  var child1 = Child();
  var parent2 = Parent.named("Lee");
  // var child2 = Child.named(); // namedConstructor상속불가
}

class Parent {
  String instanceVar = "I am instance";
  static String staticVar = "I am static";

  void instanceSay() {print("Instance Method from Parent");}
  static void staticSay() {print("Static Method from Parent");}

  Parent();
  Parent.named(String name) {
    print("Generated $name constructor in Parent");
  }

  // 인스턴스 생성 후에 같은 인스턴스와 +라는 연산이 일어날 때를 정의
  Parent operator + (Parent other) {
    return Parent.named(instanceVar + other.instanceVar);
  }
}
// 상속 가능 요소 : 인스턴스 변수( _로 시작하는 변수 제외) 및 메서드, Getter/Setter
// 상속 불가 요소 : 생성자, static 변수 및 메서드, _로 시작하는 변수,

class Child extends Parent{
  void childMethod() {
    print(instanceVar);
    print(Parent.staticVar);
    // print(staticVar); //dart에서는 static 변수는 상속 불가
    instanceSay();
    // staticSay(); //dart에서는 static 메서드는 상속 불가
  }
}