import 'package:test_api_token/component/login_text_field.dart';
import 'package:test_api_token/const/colors.dart';
import 'package:test_api_token/provider/schedule_provider.dart';
import 'package:test_api_token/screen/auth_screen.dart';
import 'package:test_api_token/screen/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  // formKey: 폼 검증(유효성 검사, 저장 등)을 제어하기 위한 키
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String rePassword = '';
  String mobile = '';
  String name = '';
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    // ScheduleProvider를 사용하기 위해 첫번째로 인스턴스 만듦.
    final provider = context.watch<ScheduleProvider>();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            // EdgeInsets: padding,margin과 같이 크기 조정할때 자주 사용하는 클래스
            // symmetric: 대칭적인 의미로 horizontal, vertical 기준으로 여백지정 가능
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50.0),
                    Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          "Join",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: PRIMARY_COLOR,
                            fontSize: 36.0,
                          ),
                        ),
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
                        RegExp reg = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{1,4}$',
                        );

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
                    const SizedBox(height: 8.0),
                    LoginTextField(
                      onSaved: (val) {
                        rePassword = val!;
                      },
                      obscureText: true,
                      validator: (val) {
                        if (val?.isEmpty ?? true) {
                          return '비밀번호 재입력를 입력해주세요.';
                        }

                        if (val!.isEmpty || val.length > 8) {
                          return '비밀번호는 1~8자 사이로 입력 해주세요!';
                        }
                        return null;
                      },
                      hintText: '비밀번호 재입력',
                    ),
                    const SizedBox(height: 8.0),
                    LoginTextField(
                      onSaved: (val) {
                        name = val!;
                      },
                      validator: (val) {
                        if (val?.isEmpty ?? true) {
                          return '이름을 입력해주세요.';
                        }
                        return null;
                      },
                      hintText: '이름',
                    ),
                    const SizedBox(height: 8.0),
                    LoginTextField(
                      onSaved: (val) {
                        nickname = val!;
                      },
                      validator: (val) {
                        if (val?.isEmpty ?? true) {
                          return '닉네임을 입력해주세요.';
                        }
                        return null;
                      },
                      hintText: '닉네임',
                    ),
                    const SizedBox(height: 8.0),
                    LoginTextField(
                      onSaved: (val) {
                        mobile = val!;
                      },
                      validator: (val) {
                        if (val?.isEmpty ?? true) {
                          return '모바일을 입력해주세요.';
                        }
                        return null;
                      },
                      hintText: '모바일',
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: SECONDARY_COLOR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () async {
                        onRegisterJoin(provider);
                      },
                      child: Text('회원등록'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: SECONDARY_COLOR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) => AuthScreen()));
                      },
                      child: Text('로그인 가기'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onRegisterJoin(ScheduleProvider provider) async {
    // 입력한 값들이 비정상 적일 경우 false 반환
    if (!saveAndValidateForm()) return;

    // 비밀번호와 재입력된 비밀번호가 일치하는지 확인
    if (password != rePassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('비밀번호가 일치하지 않습니다.')));
      return;
    }

    String? message;

    try {
      await provider.register(email: email, password: password);
    } on DioException catch (e) {
      // repository 문제 발생
      message = e.response?.data['message'] ?? '알 수 없는 오류가 발생했습니다.';
    } catch (e) {
      // provider 문제 발생
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
