import 'package:flutter/material.dart';
import 'package:ch18_scheduler_sqlite/component/main_calendar.dart';
import 'package:ch18_scheduler_sqlite/component/schedule_card.dart';
import 'package:ch18_scheduler_sqlite/component/today_banner.dart';
import 'package:ch18_scheduler_sqlite/component/schedule_bottom_sheet.dart';
import 'package:ch18_scheduler_sqlite/const/colors.dart';
import 'package:get_it/get_it.dart';
import 'package:ch18_scheduler_sqlite/database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
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
            MainCalendar(
              selectedDate: selectedDate, // 선택된 날짜 전달하기
              // 날짜가 선택됐을 때 실행할 함수
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.length ?? 0,
                );
              },
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: StreamBuilder<List<Schedule>>(
                // 일정 정보가 Stream으로 제공되기 때문에 StreamBuilder 사용
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // 데이터가 없을 때
                    return Container();
                  }

                  return ListView.builder(
                    // 화면에 보이는 값들만 렌더링하는 리스트
                    itemCount: snapshot.data!.length, // 리스트에 입력할 값들의 총 개수
                    itemBuilder: (context, index) {
                      // 현재 index에 해당되는 일정
                      final schedule = snapshot.data![index];
                      // 위젯을 밀어서 삭제하는 기능을 제공 
                      return Dismissible(
                        // 유니크한 키값
                        key: ObjectKey(schedule.id),

                        // 밀기 방향 (오른쪽에서 왼쪽으로)
                        direction: DismissDirection.startToEnd,

                        // 밀기 했을 때 실행할 함수
                        onDismissed: (DismissDirection direction) {
                          GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 날짜 선택될 때마다 실행할 함수
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
