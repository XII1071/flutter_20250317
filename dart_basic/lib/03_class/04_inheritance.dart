void main() {
  Dog d = Dog("개");
  d.makeSound();
  d.bark();
}

class Animal {
  late String _name;
  Animal();
  Animal.withValue(this._name);
  void makeSound() {print(_name + " 소리입니다.");}
}

class Dog extends Animal {
  Dog(String name) : super.withValue(name);
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