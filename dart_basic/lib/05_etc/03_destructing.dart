void main() {
  // 1) 리스트에서 변수로 구조분해 할당
  // 아래 코드와 같지만 한줄에 해결 할 수 있다.
  // final newJeans = ['민지', '해린'];
  // final minji = newJeans[0];
  // final haerin = newJeans[1];
  final [minji, haerin] = ['민지', '해린'];
  print(minji);
  print(haerin);

  // 2) 리스트에서 스프레드 연산자를 이용한 구조분해 할당
  final numbers = [1, 2, 3, 4, 5, 6, 7, 8];
  final [x, y, ..., z] = numbers;
  print(x);  print(y);  print(z);
  var list1 = [1,2,3];
  var list2 = [0, ...list1, 4, 5];
  print(list2);
  List<int>? nullableList;

  // 3) 널값이 될 수 있는 컬렉션은 ...?를 사용
  var list3 = [1,2, ...?nullableList, 3, 4];
  print(list3);

  // 4) map에서 스프레드 연산자를 활용한 구조분해 할당
  var map1 = {'a': 1, "b":2};
  var map2 = {'c': 3,...map1, "d":4};
  print(map2);

  // 5) 클래스에서 구조 분해 사용 예제
  final minJiIdol = Idol(name: '민지', age: 19);
  final Idol(name: name3, age: age3) = minJiIdol;
  print(name3);
  print(age3);

  // 6) 클래스에서 레코드로 구조분해 불가, 형변환 불가 컴파일시 에러
  // (String, int) saram = Idol(name: '하니', age: 10) as (String, int);
  // print(saram);

  // 7) 클래스=>레코드로 변환::수동으로 별도의 메서드 작성하여 형변환 가능
  (String, int) saram = Idol(name: '하니', age: 10).toRecord();
  print(saram);

  Idol njz = Idol.fromRecord(("Daniel", 10));
  print(njz.name+" "+njz.age.toString());


}
class Idol {
  final String name;
  final int age;

  Idol({
    required this.name,
    required this.age,
  });
  // 클래스 => 레코드
  (String, int) toRecord() {
    return (name, age);
  }
  // 레코드 => 클래스
  factory Idol.fromRecord((String, int) record) {
    var (name, age) = record;
    return Idol(name: name, age: age);
  }
}