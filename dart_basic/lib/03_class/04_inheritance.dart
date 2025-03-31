void main() {
  Dog d = Dog("개");
  d.makeSound();
  d.bark();
}

class Animal {
  late String _name;
  Animal.whitValue(this._name);
  Animal.param2Constructor(){} // named Constructor
  void makeSound() {print(_name + " 소리입니다.");}
}

class Dog extends Animal {
  // 상속 가능 요소 : 인스턴스 변수( _로 시작하는 변수 제외) 및 메서드, Getter/Setter
  // 상속 불가 요소 : 생성자, static 변수 및 메서드, _로 시작하는 변수,
  Dog(String name) : super.whitValue(name);
  void bark() {print("멍멍");}
}

/* java code start
class Parent {static String staticVar = "Parent static variable";}
class Child extends Parent { }
public class Main {
  public static void main(String[] args) {
    System.out.println(Child.staticVar);  // "Parent static variable"
    Child.staticVar = "Modified in Child";
    System.out.println(Parent.staticVar); // "Modified in Child"
  }
}
java code end */