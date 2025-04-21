import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class AuthRepository {
  // HTTP 요청을 위해 Dio 인스턴스를 생성, 데이터 접근(create, read, delete) 레이어
  final _dio = Dio();

  // Android에서는 에뮬레이터가 localhost에 접근 불가. 10.0.0.2를 localhost로 대체:API 서버 URL
  // node에서 돌아가는 로컬 아이피를 적용하면 됨.
  final _targetUrl =
      'http://${Platform.isAndroid ? '10.100.204.26' : 'localhost'}:3000/auth';

  // 회원 가입 요청을 보내고, 서버로부터 accessToken, refreshToken을 반환하는 비동기 함수.
  // Future에서 ()는 레코드라는 구조이고, {}는 2개의 값을 묶어서 튜플 형태로 반환 107p
  Future<({String refreshToken, String accessToken})> register({
    required String email,
    required String password,
  }) async {
    final result = await _dio.post(
      '$_targetUrl/register/email',
      data: {'email': email, 'password': password},
    );

    // 응답 처리 : 레코드 타입에 정의된 tuple 구조로 리턴.
    return (
      refreshToken: result.data['refreshToken'] as String,
      accessToken: result.data['accessToken'] as String,
    );
  }

  // 로그인을 통해서 새로운 refreshToken과 accessToken을 발급받음
  Future<({String refreshToken, String accessToken})> login({
    required String email,
    required String password,
  }) async {
    final emailAndPassword = '$email:$password';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final encoded = stringToBase64.encode(emailAndPassword);
    final result = await _dio.post(
      '$_targetUrl/login/email',
      options: Options(headers: {'authorization': 'Basic $encoded'},)
    );
    return (
      refreshToken: result.data['refreshToken'] as String,
      accessToken: result.data['accessToken'] as String,
    );
  }

  // Refresh Token을 Header에 담아서 Refresh Token 재발급 URL에 요청을 보냅니다.
  Future<String> rotateRefreshToken({required String refreshToken}) async {
    final result = await _dio.post(
      '$_targetUrl/token/refresh',
      options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
    );

    return result.data['refreshToken'] as String;
  }

  // Refresh Token을 Header에 담아서 Access Token 재발급 URL에 요청을 보냅니다.
  Future<String> rotateAccessToken({required String refreshToken}) async {
    final result = await _dio.post(
      '$_targetUrl/token/access',
      options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
    );

    return result.data['accessToken'] as String;
  }
}
