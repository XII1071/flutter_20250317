// 클래스에 대한 제어자 base, final, interface, sealed

base class Parent{

}
//  같은 파일 내부에서 오직 base 붙은 클래스 끼리만 상속 가능.
Parent parent = Parent();  // 인스턴스 가능
base class Child1 extends Parent{} // base 상속 가능
// class Child2 extends Parent{} // extends 불가
// class Child3 implements Parent{} // implements 불가

final class Parent2{

}
// 같은 파일 내부에서 extends, implements 불가.
Parent2 parent2 = Parent2(); // 인스턴스 가능
base class Child21 extends Parent2{} // base 상속 가능
// class Child22 extends Parent2{}  // extends 불가
// class Child23 implements Parent2{} // implements 불가

interface class Parent3{

}
// 같은 파일 내부에서 모두 가능.
Parent3 parent3 = Parent3(); // 인스턴스 가능
base class Child31 extends Parent3{}  // base 상속 가능
class Child32 extends Parent3{} // extends 가능
class Child33 implements Parent3{} // implements 가능

sealed class Parent4{

}
// 같은 파일 내부에서 상속, 재정의 가능.
// Parent4 parent4 = Parent4(); // 인스턴스 불가
base class Child41 extends Parent4{}
class Child42 extends Parent4{}
class Child43 implements Parent4{}

void main() {
    print("modifiers");
}