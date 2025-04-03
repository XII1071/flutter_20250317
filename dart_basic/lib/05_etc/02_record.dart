void main() {
  // 해당 데이터가 아주 짧은 생명주기를 가질 때 사용하며 권장. 상속 불가
  // 클래스로 만들기에 애매하지만, 연관성이 있는 변수 묶을 수 있음.
  // Positional Parameter 형태로 Record 선언, 순서에 따른다.
  (String, int) person = ('길동', 20);
  // (String, int) person = (20, '길동');
  print(person);

  (String, int, bool) person2 = ('길동', 20, true);
  print(person2.$1);
  print(person2.$2);
  print(person2.$3);

  // Named Parameter 형태로 Record 선언, 순서는 상관이 없어진다.
  ({String name, int age}) person3 = (name: '길동', age: 20);
  print(person3);
}