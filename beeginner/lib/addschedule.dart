import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
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
    );
  }
}
