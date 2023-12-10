import 'package:beeginner/controller/TipController.dart';
import 'package:beeginner/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

import 'model/tiplist.dart';

class TipWritePage extends StatefulWidget {
  const TipWritePage({super.key});

  @override
  State<TipWritePage> createState() => _TipWritePageState();
}

class _TipWritePageState extends State<TipWritePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();
    DocumentReference<Map<String, dynamic>> tipRef;
    String documentId;

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
                              230, 224, 233, 1), // 아래 border 색상 설정
                          width: 0.1, // 아래 border 두께 설정
                        ),
                      ),
                    ),
                    child: TextButton(
                      child: const Text(
                        '일정표',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/schedule');
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
                  width: MediaQuery.of(context).size.width / 3,
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
                      child: const Text('꿀 팁',
                          style: TextStyle(color: Colors.black)),
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
              height: 630,
              decoration: BoxDecoration(
                color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
                borderRadius: BorderRadius.circular(10.0), // radius 설정
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 23.0, 22.0, 13.0),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          child: SvgPicture.asset(
                            'assets/images/tip_write_line.svg',
                            height: 35,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: '제목을 입력하세요.',
                              hintStyle: TextStyle(
                                color: Color(0xFF696969),
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                height: 0.06,
                                letterSpacing: 0.10,
                              ),
                              counterText: '',
                              border: InputBorder.none, // 입력 필드의 테두리 제거
                              fillColor:
                                  Color.fromARGB(0, 249, 149, 149), // 배경색 제거
                              filled: true, // 배경을 채우도록 설정
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 0.5,
                    color: Color.fromRGBO(230, 224, 233, 1),
                  ),
                  const SizedBox(height: 20),
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
                      controller: _descriptionController,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Container를 눌렀을 때 이전 페이지로 이동하는 코드를 추가
                      Navigator.pop(
                          context); // 예시로 현재 페이지를 닫는 코드 (pop을 사용하여 이전 페이지로 이동)
                    },
                    child: Container(
                      width: 183,
                      height: 43,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(255, 243, 156, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            height: 0.11,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime now = DateTime.now();
                      Timestamp createTime = Timestamp.fromDate(now);
                      if (createTime != null) {
                        try {
                          tipRef = await FirebaseFirestore.instance
                              .collection('tip')
                              .add({
                            'tipTitle': _titleController.text,
                            'description': _descriptionController.text,
                            'star': false,
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            // 'createTime':
                            //     Timestamp.fromDate(createTimeDateTime),
                          });
                          documentId = tipRef.id;
                          TipController.collection.doc(documentId).update(Tip(
                                  id: documentId,
                                  tipTitle: _titleController.text,
                                  description: _descriptionController.text,
                                  star: false,
                                  uid: FirebaseAuth.instance.currentUser!.uid)
                              .toJson(Tip(
                                  id: documentId,
                                  tipTitle: _titleController.text,
                                  description: _descriptionController.text,
                                  star: false,
                                  uid:
                                      FirebaseAuth.instance.currentUser!.uid)));
                        } catch (e) {
                          print("Error updating document: $e");
                        }
                      }
                      Navigator.pushNamed(context, '/tip');
                    },
                    child: Container(
                      width: 183,
                      height: 43,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFE20C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '저장',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            height: 0.11,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
