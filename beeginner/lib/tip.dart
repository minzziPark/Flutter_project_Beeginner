import 'package:beeginner/controller/TipController.dart';
import 'package:beeginner/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/tiplist.dart';

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final _tipContoroller = TextEditingController();

  void _showTipDetailsModal(BuildContext context, Tip tip) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1), // 배경색 설정
            borderRadius: BorderRadius.circular(10.0), // radius 설정
          ),
          width: 380,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tip.tipTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '작성일: ${DateFormat('yyyy.MM.dd').format(tip.createTime!.toDate())}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                tip.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // 원하는 다른 내용 추가 가능
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    snapshots() => FirebaseFirestore.instance.collection('tip').snapshots();
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
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/tip_write');
              },
              child: Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
                  borderRadius: BorderRadius.circular(10.0), // radius 설정
                ),
                child: Center(
                  child: Text("+ 새로 작성하기"),
                ),
              ),
            ),
            const SizedBox(height: 13.0),
            Container(
              width: 380,
              height: 600,
              decoration: BoxDecoration(
                color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
                borderRadius: BorderRadius.circular(10.0), // radius 설정
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: snapshots(),
                builder: _builder,
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data == null) return Container();

    List<Tip> tips = snapshot.data?.docs.map<Tip>((data) {
          Tip tip = Tip.fromJson(data.data() as Map<String, dynamic>);
          tip.id = tip.id;
          return tip;
        }).toList() ??
        [];

    return SingleChildScrollView(
      child: Column(children: [
        GridView.count(
          crossAxisCount: 1,
          padding: const EdgeInsets.all(11.0),
          childAspectRatio: 6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: tips.map((tip) => _buildCard(context, tip)).toList(),
        ),
      ]),
    );
  }

  Widget _buildCard(BuildContext context, Tip tip) {
    if (tip.id != null) {
      return Dismissible(
        key: Key(tip.id!),
        onDismissed: (direction) async {
          try {
            await TipController.collection.doc(tip.id).delete();
          } catch (e) {
            print("Error delete");
          }
        },
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
        ),
        child: InkWell(
            onTap: () {
              _showTipDetailsModal(context, tip);
            },
            child: Card(
              color: Color.fromARGB(0, 255, 255, 255),
              elevation: 0,
              child: Stack(children: [
                Container(
                  width: 380,
                  height: 66,
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 16, bottom: 20),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tip.tipTitle,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color(0xFF1D1B20),
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                height: 0.09,
                                letterSpacing: 0.50,
                              ),
                            ),
                            const SizedBox(height: 17.0),
                            Text(
                              tip.createTime != null
                                  ? DateFormat('yyyy.MM.dd')
                                      .format(tip.createTime!.toDate())
                                  : 'N/A',
                              // maxLines: 1,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color(0xFF1D1B20),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                height: 0.12,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ],
                        ),
                        if (tip.star == true)
                          InkWell(
                            onTap: () async {
                              if (tip.createTime != null) {
                                try {
                                  DateTime createTimeDateTime =
                                      tip.createTime!.toDate();
                                  await TipController.collection
                                      .doc(tip.id)
                                      .update({
                                    'tipTitle': tip.tipTitle,
                                    'star': !tip.star,
                                    'description': tip.description,
                                    'createTime': Timestamp.fromDate(
                                        createTimeDateTime), // Convert to Timestamp
                                    // 나머지 필드도 필요한대로 업데이트해주세요.
                                  });
                                } catch (e) {
                                  print("Error updating document: $e");
                                }
                              }
                            },
                            child: const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 23,
                            ),
                          ),
                        if (tip.star == false)
                          InkWell(
                            onTap: () async {
                              if (tip.createTime != null) {
                                try {
                                  DateTime createTimeDateTime =
                                      tip.createTime!.toDate();
                                  await TipController.collection
                                      .doc(tip.id)
                                      .update({
                                    'tipTitle': tip.tipTitle,
                                    'star': !tip.star,
                                    'description': tip.description,
                                    'createTime': Timestamp.fromDate(
                                        createTimeDateTime), // Convert to Timestamp
                                    // 나머지 필드도 필요한대로 업데이트해주세요.
                                  });
                                } catch (e) {
                                  print("Error updating document: $e");
                                }
                              }
                            },
                            child: const Icon(
                              Icons.star_border_outlined,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 23,
                            ),
                          ),
                      ]),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: Color.fromRGBO(230, 224, 233, 1),
                  ),
                ),
              ]),
            )),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
