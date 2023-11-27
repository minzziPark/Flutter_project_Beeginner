import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/todolist.dart';
import 'package:beeginner/main.dart';

// import 'components/appbar.dart';
// import 'components/getday.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context, List<Todo> todos) {
    var appState = context.watch<ApplicationState>();
    if (todos.isEmpty) {
      return const <Card>[];
    }

    return todos.map((todo) {
      return Card(
        color: Colors.transparent,
        elevation: 0,
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        todo.todoTitle,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    snapshots() => FirebaseFirestore.instance.collection('todo').snapshots();

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
                              255, 226, 12, 1), // 아래 border 색상 설정
                          width: 3.0, // 아래 border 두께 설정
                        ),
                      ),
                    ),
                    child: TextButton(
                      child: const Text(
                        '오늘의 할 일',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {},
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
            Container(
              width: 380,
              height: 500,
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
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data == null) return Container();

    List<Todo> todos = snapshot.data?.docs.map<Todo>((data) {
          Todo todo = Todo.fromJson(data.data() as Map<String, dynamic>);
          todo.id = todo.id;
          return todo;
        }).toList() ??
        [];

    int numberOfTodos = todos.length;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24.0),
          child: SizedBox(
            width: 400,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: '오늘 총 ',
                    style: TextStyle(
                      color: Color(0xFF49454F),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      letterSpacing: 0.25,
                    ),
                  ),
                  TextSpan(
                    text: '$numberOfTodos개', // 변수를 사용
                    style: const TextStyle(
                      color: Color(0xFF49454F),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: 0.25,
                    ),
                  ),
                  const TextSpan(
                    text: '의 할 일이 남아있어요!\n잊지않도록 도와줄게요 :)',
                    style: TextStyle(
                      color: Color(0xFF49454F),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      letterSpacing: 0.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: GridView.count(
                crossAxisCount: 1,
                padding: const EdgeInsets.all(11.0),
                childAspectRatio: 6,
                children: _buildGridCards(context, todos))),
      ],
    );
  }
}
