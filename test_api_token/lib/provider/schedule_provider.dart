import 'package:test_api_token/model/schedule_model.dart';
import 'package:test_api_token/repository/auth_repository.dart';
import 'package:test_api_token/repository/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Flutter의 상태관리 패턴 중 하나인 Provider를 활용해 일정 데이터의 상태를 관리.
// ChangeNotifier를 상속할 경우 notifyListeners()를 호출하면 UI가 자동으로 갱신.
class ScheduleProvider extends ChangeNotifier {

  final ScheduleRepository scheduleRepository;
  final AuthRepository authRepository;
  ScheduleProvider({
    required this.scheduleRepository,
    required this.authRepository,
  }) : super();

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // 해당 날짜의 일정 들을 저장해 두는 임시 저장소(메모리 캐시:속도 개선 효과)
  Map<DateTime, List<ScheduleModel>> cache = {};

  String? accessToken;
  String? refreshToken;
  // updateTokens: 토큰을 새로 받거나 갱신할 경우 호출
  updateTokens({String? refreshToken, String? accessToken}) {
    if (refreshToken != null) this.refreshToken = refreshToken;
    if (accessToken != null) this.accessToken = accessToken;
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    final resp = await authRepository.login(email: email, password: password);
    updateTokens(
      refreshToken: resp.refreshToken,
      accessToken: resp.accessToken,
    );
  }

  logout() {
    accessToken = null;
    refreshToken = null;
    cache = {};
    notifyListeners();
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final resp = await authRepository.register(
      email: email,
      password: password,
    );

    updateTokens(
      refreshToken: resp.refreshToken,
      accessToken: resp.accessToken,
    );
  }

  // refreshToken으로 true면 refreshToken을 갱신, false면 accessToken을 갱신
  rotateToken({
    required String refreshToken,
    required bool isRefreshToken,
  }) async {
    if (isRefreshToken) {
      final token = await authRepository.rotateRefreshToken(
        refreshToken: refreshToken,
      );
      this.refreshToken = token;
    } else {
      final token = await authRepository.rotateAccessToken(
        refreshToken: refreshToken,
      );
      accessToken = token;
    }
    notifyListeners();
  }

  void getSchedules({required DateTime date}) async {
    final resp = await scheduleRepository.getSchedules(
      date: date,
      accessToken: accessToken!,
    );
    print(resp);
    // map에 key(date)로 value(schedules)의 각각을 리턴
    cache.update(date, (value) => resp, ifAbsent: () => resp);
    notifyListeners();
  }

  void createSchedule({required ScheduleModel schedule}) async {
    // 등록할 schedule의 날짜를 key로 지정
    final targetDate = schedule.date;

    // 등록할 schedule의 id를 uuid로 임시 대체
    final uuid = Uuid();
    final tempId = uuid.v4();
    final newSchedule = schedule.copyWith(id: tempId);

    // 기존의 schedule에다가 newSchedule을 추가하고 다시 정렬
    cache.update(
      targetDate,
      (value) =>
          [...value, newSchedule]
            ..sort((a, b) => a.startTime.compareTo(b.startTime)),
      ifAbsent: () => [newSchedule],
    );

    notifyListeners(); //cache의 변경된 사항을 모든 위젯이 갱신함.

    // 미리 변경된 화면을 두고 데이터베이스에 가서 실제적 등록(눈속임)
    try {
      final savedSchedule = await scheduleRepository.createSchedule(
        schedule: schedule,
        accessToken: accessToken!,
      );

      // 데이터베이스 등록 후 실제 값으로 cache 업데이트 처리.
      cache.update(
        targetDate,
        (value) =>
            value
                .map((e) => e.id == tempId ? e.copyWith(id: savedSchedule) : e)
                .toList(),
      );
    } catch (e) {
      // 데이터베이스 등록 실패 후 새로운 newSchedule을 제외한 기존 schedule만 cache 업뎃
      cache.update(
        targetDate,
        (value) => value.where((e) => e.id != tempId).toList(),
      );
    }
    // 최종 사항으로 업뎃
    notifyListeners();
  }

  void deleteSchedule({required DateTime date, required String id}) async {
    // 삭제 전 해당 schedule 미리 복사해 놓는다.
    final targetSchedule = cache[date]!.firstWhere((e) => e.id == id);

    // where(filter 개념) 적용하여 해당 id를 제외한다.
    cache.update(
      date,
      (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    );
    notifyListeners();

    try {
      await scheduleRepository.deleteSchedule(
        id: id,
        accessToken: accessToken!,
      );
    } catch (e) { // 데이터베이스 삭제시 실패할 경우
      cache.update(
        date,
        (value) =>
            [...value, targetSchedule]
              ..sort((a, b) => a.startTime.compareTo(b.startTime)),
      );
    }
    notifyListeners();
  }

  void changeSelectedDate({required DateTime date}) {
    selectedDate = date;
    notifyListeners();
  }
}
