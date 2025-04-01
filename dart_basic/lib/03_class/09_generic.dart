void main() {
  Box<int> intBox = Box<int>(10);
  Box<String> stringBox = Box("문자열");
  Box<List<int>> intListBox = Box([1, 2, 3, 4, 5]);
  //print(intBox.value);print(stringBox.value);print(intListBox.value);
  intBox.show();
  stringBox.show();
  intListBox.show();
  print(getFirst<int>(intListBox.value));
  print(getLast<int>(intListBox.value));
  getFirst2(intListBox.value);
  getLast2(intListBox.value);
  final boxBasic    = Box<List<int>>([1,2,3]);
  final boxRequired = Box<List<int>>.requiredGen(value: [1,2,3]);
}

class Box<T> {
  T value;
  // Box(T value):this.value = value;
  Box(this.value); // 기본 생성자
  Box.requiredGen({required this.value}); //named constructor
  T get() {return value;}
  void show() {print(value);}
}

T getFirst<T>(List<T> items) {return items[0];}
T getLast<T>(List<T> items) {return items[items.length - 1];}
void getFirst2<T>(List<T> items) {print(items[0]);}
void getLast2<T>(List<T> items) {print(items[items.length - 1]);}