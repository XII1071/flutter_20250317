void main() {
  var child = Child();
  child.instanceSay();
  print(Parent.staticVar);
  Parent.staticSay();
  // static 변수 메서드 상속 불가
  // print(Child.staticSay);
  // Child.staticSay();

  var parent1 = Parent();
  var child1 = Child();
  var parent = Parent.namedConstructor();
  // var child2 = Parent.namedConstructor(); // namedConstructor 상속불가
}

class Parent {
  String instanceVar = "I am instance";
  static String staticVar = "I am static";

  void instanceSay() {print("Instance Method from Parent");}
  static void staticSay() {print("Static Method from Parent");}
  // dart 에서는 메서드 생성자 오버로딩이 불가하므로 named 생성자를 생성할 수 있다.
  Parent.namedConstructor() {
    print("Named constructor in Parent");
  }
  Parent();
  Parent.whitValue(this.instanceVar);
  Parent operator + (Parent other) {
    return Parent.whitValue(instanceVar + other.instanceVar);
  }
}
class Child extends Parent{
  void childMethod() {
    print(instanceVar);
    print(Parent.staticVar);
    // print(Child.staticVar); //dart에서는 static 변수 상속 불가
    instanceSay();
    // sayStatic(); // dart에서는 static 메서드는 상속 불가
  }
}