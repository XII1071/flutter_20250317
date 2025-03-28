import 'package:dart_basic/03_class/02_constructor.dart';

void main() {
  Idol i1 = Idol("소녀시대", "SM");
  // print(i1._name); // 다른 파일 접근 안됨.
  Car c1 = Car("Beetle");
  print(c1._name); // 같은 파일에서만 접근 가능
  c1.name = "Porsche"; // setter
  print(c1.name); // getter
}

class Car {
  String _name;

  Car(this._name);

  @override
  String toString() {
    return _name;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}