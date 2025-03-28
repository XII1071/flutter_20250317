void main() {
  Company c = Company(); // 기본 생성자는 선언 없이 사용가능

  Idol i1 = Idol("소녀시대", "SM");
  Idol i2 = Idol.fromMap({'_name': 'BTS', 'company': "Hive"});
  print(i1.toString());
  print(i2);
}
class Company {
  late String name; // 초기화 되기 전 접근 불가
  int money = 100;  // 인라인 방식의 초기화.
}

class Idol {
  // 생성자에서 입력 받을 변수를 일반적으로 final로 선언
  final String _name; // private 속성 선언
  final String company;

  // 생성자를 통해서 변수의 초기화.
  Idol(String name, String company): this._name=name, this.company=company;
  Idol.fromMap(Map<String, dynamic> map): this._name=map['_name'], this.company=map['company'];

  @override
  String toString() {
    return '$_name / $company';
  }
}