import 'package:ch21_scheduler_token/model/schedule_model.dart';
import 'package:ch21_scheduler_token/repository/auth_repository.dart';
import 'package:ch21_scheduler_token/repository/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Flutter의 상태관리 패턴 중 하나인 Provider를 활용해 일정 데이터의 상태를 관리.
// ChangeNotifier를 상속할 경우 notifyListeners()를 호출하면 UI가 자동으로 갱신.
class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository scheduleRepository;
  final AuthRepository authRepository;

  String? accessToken;
  String? refreshToken;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // 날짜별로 일정들을 저장해 두는 임시 저장소(메모리 캐시:속도 개선 효과)
  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider({
    required this.scheduleRepository,
    required this.authRepository,
  }) : super() {}

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
    cache.update(date, (value) => resp, ifAbsent: () => resp);
    notifyListeners();
  }

  void createSchedule({required ScheduleModel schedule}) async {
    final targetDate = schedule.date;
    final uuid = Uuid();
    final tempId = uuid.v4();
    final newSchedule = schedule.copyWith(id: tempId);
    cache.update(
      targetDate,
      (value) =>
          [...value, newSchedule]
            ..sort((a, b) => a.startTime.compareTo(b.startTime)),
      ifAbsent: () => [newSchedule],
    );
    notifyListeners();
    try {
      final savedSchedule = await scheduleRepository.createSchedule(
        schedule: schedule,
        accessToken: accessToken!,
      );

      cache.update(
        targetDate,
        (value) =>
            value
                .map((e) => e.id == tempId ? e.copyWith(id: savedSchedule) : e)
                .toList(),
      );
    } catch (e) {
      cache.update(
        targetDate,
        (value) => value.where((e) => e.id != tempId).toList(),
      );
    }

    notifyListeners();
  }

  void deleteSchedule({required DateTime date, required String id}) async {
    final targetSchedule = cache[date]!.firstWhere((e) => e.id == id);
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
    } catch (e) {
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
