import 'dart:async'; // 비동기 처리용
import 'dart:io'; // 플랫폼 정보 확인용
import 'package:dio/dio.dart'; // HTTP 통신을 위한 DIO 패키지

import 'package:ch19_scheduler_api/model/schedule_model.dart';

class ScheduleRepository {
  // HTTP 요청을 위해 Dio 인스턴스를 생성, 데이터 접근(create, read, delete) 레이어
  final _dio = Dio();

  // Android에서는 에뮬레이터가 localhost에 접근 불가. 10.0.0.2를 localhost로 대체:API 서버 URL
  // node에서 돌아가는 로컬 아이피를 적용하면 됨.
  final _targetUrl =
      'http://${Platform.isAndroid ? '10.100.204.26' : 'localhost'}:3000/schedule';

  // 특정 날짜에 해당되는 일정 리스트를 서버에서 가져 올 때
  Future<List<ScheduleModel>> getSchedules({required DateTime date}) async {
    final resp = await _dio.get(
      _targetUrl,
      queryParameters: {
        'date':
            '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
      },
    );

    // 응답 처리 : 응답받은 json배열을 ScheduleModel 리스트로 변환
    return resp.data
        .map<ScheduleModel>((x) => ScheduleModel.fromJson(json: x))
        .toList();
  }

  // 새로운 일정을 서버에 생성할 때
  Future<String> createSchedule({required ScheduleModel schedule}) async {
    final json = schedule.toJson(); // 모델을 json으로 변환
    final resp = await _dio.post(_targetUrl, data: json); // POST 요청
    return resp.data?['id']; // 요청 결과 ScheduleModel의 id 받음
  }

  // 특정 ID를 가진 일정을 삭제
  Future<String> deleteSchedule({required String id}) async {
    final resp = await _dio.delete(_targetUrl, data: {'id': id});

    return resp.data?['id']; // 삭제된 ID값 반환
  }
}
