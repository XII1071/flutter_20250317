import 'package:ch21_scheduler_token/model/schedule_model.dart';
import 'package:ch21_scheduler_token/repository/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Flutter의 상태관리 패턴 중 하나인 Provider를 활용해 일정 데이터의 상태를 관리.
// ChangeNotifier를 상속할 경우 notifyListeners()를 호출하면 UI가 자동으로 갱신.
class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository;

  // 현재 사용하고 있는 날짜. 앱에서 오늘 날짜로 초기화
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // 날짜별로 일정들을 저장해 두는 임시 저장소(메모리 캐시:속도 개선 효과)
  Map<DateTime, List<ScheduleModel>> cache = {};

  // 기본 생성자: 오늘 날짜의 일정을 불러옴.
  ScheduleProvider({required this.repository}) : super() {
    getSchedules(date: selectedDate);
  }

  // 특정 날짜의 일정을 서버에서 가져 오기
  void getSchedules({required DateTime date}) async {
    final resp = await repository.getSchedules(date: date); // 특정 날짜의 스케줄 가져오기

    // 가져온 데이터를 cache에 저장하고 UI를 업데이트
    cache.update(date, (value) => resp, ifAbsent: () => resp);

    notifyListeners(); // Listening 하는 위젯들 업데이트하기
  }

  // 일정을 추가 하기
  void createSchedule({required ScheduleModel schedule}) async {
    final targetDate = schedule.date; // 선택한 날짜

    final uuid = Uuid(); // uuid 생성을 위한 객체 선언
    final tempId = uuid.v4(); // 유일무이한 ID값을 생성합니다.

    final newSchedule = schedule.copyWith(
      id: tempId, // 임시 ID를 지정합니다.
    );

    // 낙관적 업데이트: 서버에서 응답을 받기전에 캐시를 먼저 업데이트.
    cache.update(
      targetDate,
      (value) => [...value, newSchedule] // [기존 일정들, 새로운 일정을 추가]
        //추가 후에 시작 시간 순으로 정렬
        ..sort((a, b) => a.startTime.compareTo(b.startTime)),
      ifAbsent: () => [newSchedule], // 일정들이 하나도 없다면
    );

    notifyListeners(); // 캐시업데이트 반영하고 UI 변경:Provider의 핵심 함수

    try {
      // 서버에 특정 날짜에 대한 기존 일정 생성을 요청: savedSchedule에는 응답된 id 저장
      final savedSchedule = await repository.createSchedule(schedule: schedule);

      cache.update(
        targetDate, // 선택된 날짜
        // 캐시 속 임시 id를 서버에서 받아온 savedSchedule의 id로 변경, value:특정 날짜의 일정들,e:개별일정
        (value) => value.map((e) => e.id == tempId ? e.copyWith(id: savedSchedule) : e).toList(),
      );
    } catch (e) {
      cache.update(
        targetDate, // 선택된 날짜
        // 삭제 실패시 캐시 롤백하기 : 새로 생성된 tempId만 빼고 이전 일정으로만 롤백
        (value) => value.where((e) => e.id != tempId).toList(),
      );
    }
  }

  void deleteSchedule({required DateTime date, required String id}) async {
    final targetSchedule = cache[date]!.firstWhere(
      (e) => e.id == id,
    ); // 삭제할 일정 기억

    cache.update(
      date,
      (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    ); // 긍정적 응답 (응답 전에 캐시 먼저 업데이트)

    notifyListeners(); // 캐시업데이트 반영하기

    try {
      await repository.deleteSchedule(id: id); // ➊ 삭제함수 실행
    } catch (e) {
      cache.update(
        // ➋ 삭제 실패시 캐시 롤백하기
        date,
        (value) =>
            [...value, targetSchedule]
              ..sort((a, b) => a.startTime.compareTo(b.startTime)),
      );
    }

    notifyListeners();
  }

  void changeSelectedDate({required DateTime date}) {
    selectedDate = date; // 현재 선택된 날짜를 매개변수로 입력받은 날짜로 변경
    notifyListeners();
  }
}
