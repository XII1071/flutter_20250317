void main() {
  // 1) is 연산자 (타입 확인) 객체가 특정 타입인지 확인할 때 is 연산자를 사용
  num value = 10.5;

  if (value is int) {
    print("value는 int 타입입니다.");
  } else if (value is double) {
    print("value는 double 타입입니다.");
  }

  // 2) as 연산자 (다운캐스팅) 객체를 특정 타입으로 변환할 때 사용
  Animal animal = Dog();

  if (animal is Dog) {
    Dog dog = animal as Dog; // Animal → Dog 형변환
    dog.bark(); // Woof!
  }

  // 3) cast<T>() (컬렉션 요소 변환) cast<T>()는 리스트, 맵 등의 요소 타입을 변환할 때 사용
  List<dynamic> items = [1, 2, 3];

  List<int> numbers = items.cast<int>(); // List<dynamic> → List<int>
  // cast<int>()를 사용하여 리스트의 요소를 변환
  print(numbers);
}

class Animal {
  void makeSound() => print("Animal sound");
}

class Dog extends Animal {
  void bark() => print("Woof!");
}