void main() {
  Company c = Company(); // 기본 생성자 사용가능,fetchData() 로드 안됨.
  print(c.data); // 이때 비로서 fetchData()실행하여 메모리 사용.

  // Idol idol = Idol(); 생성자 추가 되어 기본 생성자 사용 불가.
  Idol i1 = Idol("소녀시대", "SM");
  Idol i2 = Idol.fromMap({'_name': 'BTS', 'company': "Hive"});
  print(i1.toString());
  print(i2);
}
class Company {
  // late의 장점
  // 객체 생성시 즉시 초기화 되지 않으며 성능 최적화
  // 값이 필요할 때만 메모리를 사용함으로 메모리 절약
  // 무거운 연산이 필요할 경우 리소스 절약
  late String name; // 초기화 되기 전 접근 불가
  int money = 100;  // 인라인 방식의 초기화.

  late String data = fetchData();
  String fetchData() {
    return "loading"+"."*100;
  }
}

class Idol {
  // 생성자에서 입력 받을 변수를 일반적으로 final로 선언
  final String _name; // private 속성 선언
  late final String company; // company 속성이 초기화 될 할당, 값을 설정한 후 사용.

  // 생성자를 통해서 변수의 초기화.
  // Idol(String name, String company): this._name=name, this.company=company;
  Idol(this._name, this.company); // 윗줄과 같은 기능.

  Idol.fromMap(Map<String, dynamic> map): this._name=map['_name'], this.company=map['company'];

  @override
  String toString() {
    return '$_name / $company';
  }
}