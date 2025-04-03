import 'dart:convert';
import 'dart:io';
// dart:io는 서버 및 콘솔 애플리케이션에서 사용 가능, 웹 환경 동작 불가.

void main() async {
  // 1. 파일 쓰기 (write)
  var file = File('example.txt'); // 파일 객체 생성
  // 파일에 문자열 쓰기 (기존 파일이 있으면 덮어쓰기)
  await file.writeAsString('Hello, Dart!\n');
  print('파일 작성 완료!');

  // 2. 파일 읽기 (read)
  if (await file.exists()) {
    String contents = await file.readAsString();
    print('파일 내용: $contents');
  } else {
    print('파일이 존재하지 않습니다.');
  }

  // 3. 파일에 내용 추가 (append)
  // 기존 내용 유지하고 새로운 내용 추가
  await file.writeAsString('추가된 내용\n', mode: FileMode.append);
  print('내용 추가 완료!');

  // 4. 파일 줄 단위 읽기 (read line by line)
  if (await file.exists()) {
    Stream<String> lines = file
        .openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter());

    await for (var line in lines) {
      print('읽은 줄: $line');
    }
  } else {
    print('파일이 존재하지 않습니다.');
  }

  // 5. 파일 삭제
  if (await file.exists()) {
    await file.delete();
    print('파일 삭제 완료!');
  } else {
    print('파일이 존재하지 않습니다.');
  }

  // 6. 디렉터리 생성 및 파일 목록 가져오기
  var dir = Directory('my_folder');

  if (!(await dir.exists())) {
    await dir.create(); // 디렉터리 생성
    print('디렉터리 생성 완료!');
  }

  // 디렉터리 내부 파일 목록 출력
  await for (var entity in dir.list()) {
    print(entity.path);
  }
}
