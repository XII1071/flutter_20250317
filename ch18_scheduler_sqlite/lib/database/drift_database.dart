import 'package:ch18_scheduler_sqlite/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

// 코드 생성(자동 생성 코드)을 사용하려면 part파일을 지정
// part선언시 private값까지 불러올 수 있음
part 'drift_database.g.dart';

// drift는 데이터베이스를 다루기 위한 객체. 직접 SQL을 작성하지 않아도 SQLite를 사용가능
@DriftDatabase(
  // 앱에서 사용할 테이블 등록
  tables: [Schedules],
)
// _$LocalDatabase: drift가 자동으로 생성해주는 클래스
class LocalDatabase extends _$LocalDatabase {
  // 생성자를 통해서 데이터베이스에 접속됨.
  LocalDatabase() : super(_openConnection());

  // watchSchedules: 데이터를 실시간으로 조회하고 변화를 감지해서 화면 업데이트가 목적
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  // 새로운 스케줄을 추가하는 함수
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  // 특정 id를 가진 스케줄을 삭제
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  @override // 기존 테이블 구조를 변경할 때 버전 다르게 줄수 있음
  int get schemaVersion => 1;
}

// SQLite에 접속 하기 위한 함수
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // 앱에서 저장할 데이터베이스 경로 추출
    final dbFolder = await getApplicationDocumentsDirectory();
    // 해당 경로에 데이터베이스 파일 생성
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
