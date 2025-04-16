import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:isar/isar.dart';
import 'package:soul_talk/component/chat_text_field.dart';
import 'package:soul_talk/component/date_divider.dart';
import 'package:soul_talk/component/logo.dart';
import 'package:soul_talk/component/message.dart';
import 'package:soul_talk/model/message_model.dart';

final sampleData = [
  MessageModel(
    id: 1,
    isMine: true,
    message: '오늘 저녁으로 먹을 만한 메뉴 추천해줘!',
    point: 1,
    date: DateTime(2024, 11, 23),
  ),
  MessageModel(
    id: 2,
    isMine: false,
    message: '칼칼한 김치찜은 어때요!?',
    point: null,
    date: DateTime(2024, 11, 23),
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  bool isRunning = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Flutter에서 채팅 앱처럼 메시지를 스트리밍하여 실시간으로 화면에 표시하는 UI
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                // fireImmediately: true는 현재 상태를 바로 한 번 보내주는 옵션.구독하자마자 한 번 데이터 전송
                stream: GetIt.I<Isar>()
                    .messageModels
                    .where()
                    .watch(fireImmediately: true),
                builder: (context, snapshot) {
                  // snapshot.data는 현재 들어온 메시지 리스트를 담고 있음
                  final messages = snapshot.data ?? [];
                  // scrollToBottom()을 호출해서 새 메시지가 오면 자동으로 스크롤을 아래로 내려주는 기능
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) async => scrollToBottom());
                  return buildMessageList(messages); // 실제로 메시지 목록을 그리는 함수
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
              child: ChatTextField(
                error: error,
                loading: isRunning,
                onSend: handleSendMessage,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollToBottom() {
    if (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  handleSendMessage() async {
    if (controller.text.isEmpty) {
      setState(() => error = '메세지를 입력해주세요!');
      return;
    }

    int? currentModelMessageId;
    int? currentUserMessageId;

    final isar = GetIt.I<Isar>();
    final currentPrompt = controller.text; // 사용자가 입력한 메시지 저장

    try {
      // 메시지 전송 시작 준비
      setState(() {
        isRunning = true; // 메시지를 전송 중이라는 UI 표시
      });
      controller.clear();

      // 메시지 카운트 가져 오기
      final myMessagesCount =
          await isar.messageModels.filter().isMineEqualTo(true).count();
      // 사용자의 메시지를 DB에 저장
      currentUserMessageId = await isar.writeTxn(() async {
        return await isar.messageModels.put(
          MessageModel(
            isMine: true,
            message: currentPrompt,
            point: myMessagesCount + 1,
            date: DateTime.now(),
          ),
        );
      });

      // 최근 메시지 5개를 가져와 문맥 구성
      final contextMessages =
          await isar.messageModels.where().limit(5).findAll();
      final List<Content> promptContext = contextMessages
          .map(
            (e) => Content(
              e.isMine ? 'user' : 'model',
              [
                TextPart(e.message),
              ],
            ),
          )
          .toList();

      // Gemini 모델 설정
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyD78O8B3dKZshmaQQmgjBzWg5Kf9UXFBWg',
        systemInstruction: Content.system(
            '너는 이제부터 착하고 친절한 친구의 역할을 할거야. 앞으로 채팅을 하면서 긍정적인 말만 할 수 있도록 해줘. 이 메세지는 기억만 하고 여기엔 대답할 필요 없어.'),
      );

      String message = '';

      // 모델 응답을 스트리밍으로 받아오기
      model.generateContentStream(promptContext).listen(
            (event) async {
              // Gemini의 응답을 stream 형태로 받아오기 때문에, 메시지를 조금씩 이어붙임
              if (event.text != null) {
                message += event.text!;
              }

              // Isar DB에 그때그때 저장해서 UI에 점점 업데이트
              final MessageModel model = MessageModel(
                isMine: false,
                message: message,
                date: DateTime.now(),
              );

              // 이전 메시지 ID 있다면 해당 메시지 덮어 써서 실시간으로 텍스트 업데이트되는 것처럼 보임.
              if (currentModelMessageId != null) {
                model.id = currentModelMessageId!;
              }

              currentModelMessageId =
                  await isar.writeTxn<int>(() => isar.messageModels.put(model));
            },
            // 응답 완료 / 에러 처리
            onDone: () => setState(() {
              isRunning = false;
            }),
            // 모델 응답이 끝나면 로딩 상태 종료
            onError: (e) async {
              await isar.writeTxn(() async {
                return isar.messageModels.delete(currentUserMessageId!);
              });

              setState(() {
                error = e.toString();
                isRunning = false;
              });
            },
          );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // 채팅 메시지 목록을 그리는 위젯
  Widget buildMessageList(List<MessageModel> messages) {
    return ListView.separated(
      // 각 아이템 사이에 구분선(또는 여백) 넣음
      controller: scrollController, // 자동 스크롤 연동
      itemCount: messages.length + 1, // 전체 메시지  + 1(로고 같은 것 추가)
      itemBuilder: (context, index) => index == 0 // 각 인덱스에 어떤 위젯을 그릴지 정하는 함수
          ? buildLogo() // index 0 일 때
          : buildMessageItem(
              //  index 0 아닐 때
              message: messages[index - 1],
              prevMessage: index > 1 ? messages[index - 2] : null,
              index: index - 1,
            ),
      // 각 메시지 사이에 일정 간격을 넣어주는 역할
      separatorBuilder: (_, __) => const SizedBox(height: 16.0), //세로 간격 16픽셀 추가
    );
  }

  Widget buildLogo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Logo(),
      ),
    );
  }

  // 채팅 메시지 하나를 어떻게 그릴지 정하는 위젯
  // prevMessage가 있는 이유는, 날짜가 바뀌었을 때 날짜 구분선(DateDivider)을 넣기 위함
  Widget buildMessageItem({
    MessageModel? prevMessage, // 이전 메시지 (날짜 비교용)
    required MessageModel message, // 현재 메시지 (말풍선 출력용)
    required int index, // 현재 메시지 인덱스
  }) {
    final isMine = message.isMine; // 내가 보낸 메시지인지 확인
    // 날짜 구분선 표시 여부 판단
    final shouldDrawDateDivider =
        prevMessage == null || shouldDrawDate(prevMessage.date, message.date);

    return Column(
      children: [
        if (shouldDrawDateDivider) // 날짜 구분선 (선택적으로 표시)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DateDivider(date: message.date),
          ),
        Padding(
          // 메시지 말풍선, 실제 말풍선은 Message 위젯으로 표시
          padding: EdgeInsets.only(
              left: isMine ? 64.0 : 16.0, right: isMine ? 16.0 : 64.0),
          child: Message(
            alignLeft: !isMine, // 상대방 왼쪽, 나는 오른쪽
            message: message.message.trim(),
            point: message.point,
          ),
        ),
      ],
    );
  }

  bool shouldDrawDate(DateTime date1, DateTime date2) {
    return getStringDate(date1) != getStringDate(date2);
  }

  String getStringDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }
}
