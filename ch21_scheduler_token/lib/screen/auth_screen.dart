import 'package:ch21_scheduler_token/component/login_text_field.dart';
import 'package:ch21_scheduler_token/const/colors.dart';
import 'package:ch21_scheduler_token/provider/schedule_provider.dart';
import 'package:ch21_scheduler_token/screen/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // formKey: 폼 검증(유효성 검사, 저장 등)을 제어하기 위한 키
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    // ScheduleProvider를 사용하기 위해 첫번째로 인스턴스 만듦.
    final provider = context.watch<ScheduleProvider>();

    return Scaffold(
      body: Padding(
        // EdgeInsets: padding,margin과 같이 크기 조정할때 자주 사용하는 클래스
        // symmetric: 대칭적인 의미로 horizontal, vertical 기준으로 여백지정 가능
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'asset/img/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              const SizedBox(height: 16.0),
              LoginTextField(
                onSaved: (val) {
                  email = val!;
                },
                validator: (val) {
                  if (val?.isEmpty ?? true) {
                    return '이메일을 입력해주세요.';
                  }

                  /* 정규식: 이메일 검사
                  ^           → 문자열 시작
                  [\w-\.]+    → 영어/숫자/언더바/하이픈/점이 1글자 이상
                  @           → @ 기호 (이메일 필수!)
                  ([\w-]+\.)+ → 도메인 (ex. naver. / google.)
                  [\w-]{2,4}  → 최상위 도메인 (ex. com, net, co.kr)
                  $           → 문자열 끝    */
                  RegExp reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                  if (!reg.hasMatch(val!)) {
                    return '이메일 형식이 올바르지 않습니다.';
                  }
                  return null;
                },
                hintText: '이메일',
              ),
              const SizedBox(height: 8.0),
              LoginTextField(
                onSaved: (val) {
                  password = val!;
                },
                obscureText: true,
                validator: (val) {
                  if (val?.isEmpty ?? true) {
                    return '비밀번호를 입력해주세요.';
                  }

                  if (val!.isEmpty || val.length > 8) {
                    return '비밀번호는 1~8자 사이로 입력 해주세요!';
                  }
                  return null;
                },
                hintText: '비밀번호',
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: SECONDARY_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                onPressed: () async {
                  onRegisterPress(provider);
                },
                child: Text('회원가입'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: SECONDARY_COLOR,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
                onPressed: () async {
                  onLoginPress(provider);
                },
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onRegisterPress(ScheduleProvider provider) async {
    // 입력한 email, password 값들이 비정상적일 경우 false 반환
    if (!saveAndValidateForm()) return;

    String? message;

    try {
      await provider.register(email: email, password: password);
    } on DioException catch (e) { // repository 문제 발생
      message = e.response?.data['message'] ?? '알 수 없는 오류가 발생했습니다.';
    } catch (e) { // provider 문제 발생
      message = '알 수 없는 오류가 발생했습니다.';
    } finally {
      if (message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      } else {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  onLoginPress(ScheduleProvider provider) async {
    if (!saveAndValidateForm()) return;

    String? message;

    try {
      await provider.login(email: email, password: password);
    } on DioException catch (e) {
      message = e.response?.data['message'] ?? '알 수 없는 오류가 발생했습니다.';
    } catch (e) {
      message = '알 수 없는 오류가 발생했습니다.';
    } finally {
      if (message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      } else {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  bool saveAndValidateForm() {
    if (!formKey.currentState!.validate()) return false;
    formKey.currentState!.save();
    return true;
  }
}
