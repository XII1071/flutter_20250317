class Counter {
  // static 키워드를 사용해서 static 변수 선언
  // 각 인스턴스가 공유하는 속성이 됨.
  static int i = 0;

  // static 키워드를 사용해서 static 변수 선언
  Counter() {
    i++;
    print(i++);
  }
}

void main() {
  Counter count1 = Counter();
  Counter count2 = Counter();
  Counter count3 = Counter();

  Singleton s1 = Singleton();
  Singleton s2 = Singleton();

  s1.showInfo();
  s2.showInfo();
}

class Singleton {
  static Singleton? _instance;

  // 내부 생성자 (private constructor)
  Singleton._internal();

  // 외부에서 호출할 수 있는 factory 생성자
  // 필요할 때(factory Singleton())만 생성
  factory Singleton() {
    if (_instance == null) _instance ??= Singleton._internal();
    return _instance!;
  }

  void showInfo() {
    print("Singlton: $hashCode");
  }
}