import 'package:flutter/material.dart';
import 'package:test_api_token/component/main_calendar.dart';
import 'package:test_api_token/component/schedule_card.dart';
import 'package:test_api_token/component/today_banner.dart';
import 'package:test_api_token/component/schedule_bottom_sheet.dart';
import 'package:test_api_token/const/colors.dart';
import 'package:provider/provider.dart';
import 'package:test_api_token/provider/schedule_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,DateTime.now().month,DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    // main함수에서 생성된 Provider의 인스턴스를 호출
    final provider = context.read<ScheduleProvider>();
    provider.getSchedules(date: selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    // 프로바이더 변경이 있을 때마다 build() 함수 재실행
    final provider = context.watch<ScheduleProvider>();
    final selectedDate = provider.selectedDate; // 선택된 날짜 가져오기
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // 새 일정 버튼
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            // BottomSheet 열기
            context: context,
            isDismissible: true, // 배경 탭했을 때 BottomSheet 닫기
            isScrollControlled: true,
            builder:
                (_) => ScheduleBottomSheet(
                  selectedDate: selectedDate, // 선택된 날짜 (selectedDate) 넘겨주기
                ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        // 시스템 UI 피해서 UI 구현하기
        child: Column(
          // 달력과 리스트를 세로로 배치
          children: [
            Text("test_api_token"),
            MainCalendar(
              selectedDate: selectedDate, // 선택된 날짜 전달하기
              // 날짜가 선택됐을 때 실행할 함수
              onDaySelected:
                  (selectedDate, focusedDate) =>
                      onDaySelected(selectedDate, focusedDate, context),
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              // 배너 추가하기
              selectedDate: selectedDate,
              count: 0,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  // 삭제할 때 왼쪽에서 오른쪽으로 밀 때
                  return Dismissible(
                    key: ObjectKey(schedule.id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (DismissDirection direction) {
                      provider.deleteSchedule(
                        date: selectedDate,
                        id: schedule.id,
                      ); //
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: ScheduleCard(
                        startTime: schedule.startTime,
                        endTime: schedule.endTime,
                        content: schedule.content,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(date: selectedDate);
    provider.getSchedules(date: selectedDate);
  }
}
