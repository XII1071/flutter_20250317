import 'package:isar/isar.dart';

part 'message_model.g.dart';

//  Isar에서 이 클래스를 **컬렉션(테이블)**으로 인식하도록 하는 어노테이션
@collection
class MessageModel {
  Id id = Isar.autoIncrement; //고유 식별자(기본 키)로 사용하는 타입
  bool isMine; // 내가 보낸 것인지 아닌지(true/false)
  String message;
  int? point;
  DateTime date;

  MessageModel({
    required this.isMine,
    required this.message,
    required this.date,
    this.id = Isar.autoIncrement,  // 기본값으로 자동 증가 id를 사용
    this.point, // 선택적 필드 (nullable)
  });
}
