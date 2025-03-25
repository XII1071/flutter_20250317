void main() {
  // 한 줄 주석 ctrl + /
  /*
  * 여러 줄 주석
  * ctrl + shift + /
  */

  print("="*30);
  print("❤"+10.toString());

  for (var i = 0; i < 10; i++) {
    print('hello${i+1}');
  }
  String text = 'Hello';
  String repeated = List.generate(3, (_)=>text).join();
  print(repeated);

}
