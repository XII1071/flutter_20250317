void main() {

}
// Dart에서 모든 클래스는 암묵적으로 인터페이스 역할
// 명시적으로 인터페이스로 사용하려면 implements를 사용해야 함.
// extends는 부모 클래스의 모든 기능을 사용, implements는 반드시 모든 기능을 재정의 해야함.
// abstract 붙으면 미완성의 메서드 사용 가능.
abstract class Flyable {  void fly(); }
abstract interface class Swimmable { void swim(); }
// 아래 2개는 미완성의 메서드 사용 불가.
interface class Groundable {  void run() { print(""); }}
class Diggable {void dig(){print("");}}

class Eagle implements Flyable{
  @override
  void fly(){print("훨 훨");}
}
class Dog implements Groundable {
  @override
  void run(){print("댕 댕");}
}
class Dolphin implements Swimmable {
  void swim() {print("첨 벙");}
  void fly(){print("훨 훨");}
}
class Mole implements Diggable {
  void dig() {print("퍽 퍽");}
}

class Duck implements Groundable, Flyable {
  @override
  void run(){print("댕 댕");}
  @override
  void fly(){print("훨 훨");} //중복되어도 상관 없다. 재정의 해야하기 때문
}