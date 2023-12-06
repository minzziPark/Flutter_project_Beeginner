import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  DateTime date = DateTime.now();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          titleSpacing: 0,
          title: Column(
            children: [
              Container(
                width: 125,
                child: SvgPicture.asset(
                  'assets/images/Beeginner.svg',
                  width: 125,
                ),
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
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
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
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
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
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
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
            children: [
              TimerBuilder.periodic(
                const Duration(seconds: 1),
                builder: (context) {
                  return Container(
                    width: 242,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 226, 12, 1), // 배경색 설정
                      borderRadius: BorderRadius.circular(10.0), // radius 설정
                    ),
                    padding: const EdgeInsets.all(0.0), // 내부 여백 설정
                    child: Center(
                      child: Text(
                        'Today    |    ${DateFormat('yyyy.MM.dd.EEE').format(DateTime.now())}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // 텍스트 색상 설정
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 13.0),
              Container(
                width: 380,
                // height: 600,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
                  borderRadius: BorderRadius.circular(10.0), // radius 설정
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22.0, 23.0, 22.0, 0.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            child: SvgPicture.asset(
                              'assets/images/tip_write_line.svg',
                              height: 40,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  date = selectedDate;
                                  isChanged = true;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 버튼의 모양을 둥글게 설정
                              ),
                              shadowColor:
                                  Color.fromRGBO(0, 0, 0, 0.5), // 배경색 설정
                              primary: Color.fromRGBO(255, 255, 255, 1),
                              onPrimary: Color.fromRGBO(133, 133, 133, 1),
                              // elevation: 1,
                            ).copyWith(
                              splashFactory:
                                  NoSplash.splashFactory, // 눌림 효과의 색상 설정
                            ),
                            child: Container(
                              width: 280,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 0), // 내용의 패딩 설정
                              child: Text(
                                isChanged
                                    ? DateFormat('yyyy.MM.dd.EEE').format(date)
                                    : '날짜를 선택하세요.',
                                style: const TextStyle(
                                  color: Color(0xFF696969),
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  height: 0.06,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 0.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            child: SvgPicture.asset(
                              'assets/images/tip_write_line.svg',
                              height: 40,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 버튼의 모양을 둥글게 설정
                              ),
                              shadowColor:
                                  Color.fromRGBO(0, 0, 0, 0.5), // 배경색 설정
                              primary: Color.fromRGBO(255, 255, 255, 1),
                              onPrimary: Color.fromRGBO(133, 133, 133, 1),
                              // elevation: 1,
                            ).copyWith(
                              splashFactory:
                                  NoSplash.splashFactory, // 눌림 효과의 색상 설정
                            ),
                            child: Container(
                              width: 280,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 0), // 내용의 패딩 설정
                              child: const Text(
                                '총 근무시간을 선택하세요.',
                                style: TextStyle(
                                  color: Color(0xFF696969),
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  height: 0.06,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22.0, 0, 22, 0),
                      child: Text(
                        'MEMO',
                        style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10.0, 0),
                      child: TextField(
                        // controller: _descriptionController,
                        maxLines: 18,
                        decoration: const InputDecoration(
                          hintText: '내용을 입력하세요.',
                          hintStyle: TextStyle(
                            color: Color(0xFF696969),
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            height: 0.06,
                            letterSpacing: 0.10,
                          ),
                          counterText: '',
                          border: InputBorder.none, // 입력 필드의 테두리 제거
                          fillColor: Color.fromARGB(0, 249, 149, 149), // 배경색 제거
                          filled: true, // 배경을 채우도록 설정
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
