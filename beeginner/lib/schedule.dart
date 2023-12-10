import 'package:beeginner/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var _focusedDay = DateTime.now();

  double _calculateProgressPercentage() {
    int totalDaysInMonth = DateTime(
      _focusedDay.year,
      _focusedDay.month + 1,
      0,
    ).day;
    double progressPercentage = _focusedDay.day / totalDaysInMonth;
    return progressPercentage;
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    Future<List<DateTime>> fetchDatesFromFirebase() async {
      List<DateTime> dateList = [];

      try {
        QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('schedule').get();

        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in snapshot.docs) {
          if (document['uid'] == currentUser) {
            Timestamp timestamp = document['date'];
            DateTime date = timestamp.toDate();
            dateList.add(date);
          }
        }
        // print(dateList);
      } catch (e) {
        print("Error fetching dates from Firebase: $e");
      }

      return dateList;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        titleSpacing: 0,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 125),
                Expanded(
                  child: Container(
                    width: 125,
                    child: SvgPicture.asset(
                      'assets/images/Beeginner.svg',
                      width: 125,
                    ),
                  ),
                ),
                SizedBox(
                  width: 125,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 25.0, 0),
                      child: InkWell(
                        onTap: () {
                          // 탭을 감지하여 로그아웃 확인 모달창 띄우기
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(1),
                                title: Text(
                                  '로그아웃',
                                  style: TextStyle(color: Colors.black),
                                ),
                                content: Text(
                                  '정말 로그아웃하시겠습니까?',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 71, 71, 71)),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // 모달창 닫기
                                    },
                                    child: Text(
                                      '취소',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      appState.changeLoggedIn(false);
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: Text(
                                      '로그아웃',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(
                              230, 224, 233, 1), // 아래 border 색상 설정
                          width: 0.1, // 아래 border 두께 설정
                        ),
                      ),
                    ),
                    child: TextButton(
                      child: const Text(
                        '오늘의 할 일',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.transparent;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3, // 텍스트 버튼 폭 설정
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(
                              255, 226, 12, 1), // 아래 border 색상 설정
                          width: 3.0, // 아래 border 두께 설정
                        ),
                      ),
                    ),
                    child: TextButton(
                      child: const Text(
                        '일정표',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {},
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.transparent;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(
                              230, 224, 233, 1), // 아래 border 색상 설정
                          width: 0.1, // 아래 border 두께 설정
                        ),
                      ),
                    ),
                    child: TextButton(
                      child: const Text('꿀 팁',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/tip');
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.transparent;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
              color: Color.fromRGBO(230, 224, 233, 1),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 10),
              child: Container(
                width: 400,
                height: 75,
                decoration: ShapeDecoration(
                  color: Color.fromARGB(70, 192, 192, 192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                      child: Text('이번 달도 이만큼 달려왔어요!🏃‍♀️ 남은 날도 파이팅🤠'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: LinearPercentIndicator(
                        width: 390,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2000,
                        percent: _calculateProgressPercentage(),
                        center: Text(
                            "${(_calculateProgressPercentage() * 100).toStringAsFixed(1)}%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Color.fromRGBO(255, 226, 12, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 380,
              child: FutureBuilder<List<DateTime>>(
                future: fetchDatesFromFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return TableCalendar(
                      focusedDay: _focusedDay,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2030),
                      selectedDayPredicate: (day) {
                        return snapshot.data!.any((date) =>
                            DateFormat('yyyy-MM-dd').format(date) ==
                            DateFormat('yyyy-MM-dd').format(day));
                      },
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0x3F929292),
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16.0,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFFA06C46), // 선택된 날짜의 배경색
                          shape: BoxShape.circle, // 선택된 날짜의 모양
                          // borderRadius: BorderRadius.circular(5.0), // 선택된 날짜의 모양 설정
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false, // 이 버튼을 보이지 않게 합니다.
                      ),
                    );
                  }
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 380,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0x47D2D2D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/add_schedule');
                    },
                    child: Container(
                      width: 380,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
                        borderRadius: BorderRadius.circular(10.0), // radius 설정
                      ),
                      child: Center(
                        child: Text("+ 일정 추가하기"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
