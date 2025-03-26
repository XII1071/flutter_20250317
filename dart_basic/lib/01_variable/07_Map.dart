void main() {
  Map<String, String> dictionary = {
    'Harry Potter': '해리 포터',
    'Ron Weasley': '론 위즐리',
    'Hermeone Granger': '헤르미온느 그레인저',
  };
  print(dictionary);

  print(dictionary['Harry Potter']);

  //1) forEach
  dictionary.forEach((k, v) {
    print(k + " : " + v);
    print('${k} : ${v}');
  });

  //2) entries
  for (var entry in dictionary.entries) {
    print('${entry.key}/${entry.value}');
  }

  //3) map :: 결과물은 Iterable 타입
  print("map" + "=" * 20);
  List<String> result =
  dictionary.entries
      .map((entry) => '${entry.key}: ${entry.value}')
      .toList();
  var tmp = dictionary.map((k, v) => MapEntry(k, v + " 호그와트"));
  print(tmp);
  print(tmp.runtimeType);

  //4) where
  Map<String, int> magicalScore = {
    'Harry Potter': 90,
    'Ron Weasley': 85,
    'Hermeone Granger': 95,
  };
  print("=" * 30);
  var highScore = magicalScore.entries.where((entry) => entry.value >= 90);
  print(highScore);
  print(highScore.runtimeType); // WhereIterable<MapEntry<String, int>>
  Map<String, int> highScore2 = Map.fromEntries(highScore);
  highScore2.forEach((k, v) {
    print('${k} = ${v}'); // String의 보간법(interpolation)=backtick
    print(k + " : " + v.toString());
  });

  //5) 그 외 기타 🎸
  print(dictionary.containsKey('Harry Potter'));
  print(dictionary.containsValue('해리 포터'));
  print(dictionary.keys);
  print(dictionary.values);
  print(dictionary.length);
  print(dictionary.isEmpty);
  print(dictionary.isNotEmpty);
  dictionary.putIfAbsent('Dumble Dore', () => '덤블 도어');
  print(dictionary);
  dictionary.remove('Dumble Dore');
  print(highScore2);
  highScore2.removeWhere((k, v) => v > 90);
  print(highScore2);
  highScore2.clear();
  print(highScore2);
}