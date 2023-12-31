import 'package:beeginner/controller/FirebaseController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/todolist.dart';
import 'package:beeginner/main.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final _todoController = TextEditingController();
  bool isTextFieldFocused = false;
  int num = 1;

  List<Widget> _buildGridCards(BuildContext context, List<Todo> todos) {
    if (todos.isEmpty) {
      return [const SizedBox.shrink()]; // 빈 목록일 경우 아무것도 표시하지 않음
    }

    return todos.map((todo) {
      if (todo.id != null && todo.uid == currentUser) {
        return Dismissible(
          key: Key(todo.id!),
          onDismissed: (direction) async {
            try {
              await FirebaseController.collection.doc(todo.id).delete();
              setState(() {
                todos.removeAt(todos.indexOf(todo));
              });
            } catch (e) {
              print("Error delete");
            }
          },
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
          ),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Stack(children: [
              Container(
                width: 380,
                height: 56,
                padding: const EdgeInsets.only(
                    top: 0, left: 16, right: 24, bottom: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (todos.contains(todo))
                      Container(
                        width: 40,
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFE20C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Text(
                                  '${todos.indexOf(todo) + 1}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    height: 0.09,
                                    letterSpacing: 0.15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                        child: Text(
                          todo.todoTitle,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Color(0xFF1D1B20),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0.09,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FirebaseController.collection.doc(todo.id).update(Todo(
                              id: todo.id,
                              todoTitle: todo.todoTitle,
                              checked: !todo.checked,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                            ).toJson(todo));
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (todo.checked)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFA06C46),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 16,
                                      ),
                                    ),
                                  if (!todo.checked)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFA06C46),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();
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
            Container(
              width: 380,
              padding: const EdgeInsets.fromLTRB(20, 40, 35, 0),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Beeginner님!',
                      style: TextStyle(
                        color: Color(0xFF1D1B20),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.06,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 380,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '오늘 할 일을 잊지않도록 도와줄게요 :)',
                            style: TextStyle(
                              color: Color(0xFF49454F),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13.0),
            Container(
              width: 380,
              height: 630,
              // decoration: BoxDecoration(
              //   color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
              //   borderRadius: BorderRadius.circular(10.0), // radius 설정
              // ),
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
    DocumentReference<Map<String, dynamic>> todoRef;
    String documentId;
    if (snapshot.data == null) return Container();

    List<Todo> todos = snapshot.data?.docs.map<Todo>((data) {
          Todo todo = Todo.fromJson(data.data() as Map<String, dynamic>);
          todo.id = todo.id;
          return todo;
        }).toList() ??
        [];

    return Column(
      children: [
        Container(
          height: 530,
          decoration: BoxDecoration(
            color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
            borderRadius: BorderRadius.circular(10.0), // radius 설정
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 1,
                  padding: const EdgeInsets.all(11.0),
                  childAspectRatio: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _buildGridCards(context, todos),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(210, 210, 210, 0.28), // 배경색 설정
            borderRadius: BorderRadius.circular(10.0), // radius 설정
          ),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Stack(children: [
              Container(
                width: 380,
                height: 70,
                padding: const EdgeInsets.only(
                    top: 0, left: 25, right: 35, bottom: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(255, 226, 12, 0.25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                          hintText: '할 일을 입력하세요.',
                          hintStyle: TextStyle(
                            color: Color(0xFF696969),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            height: 0.06,
                            letterSpacing: 0.10,
                          ),
                          counterText: '',
                          border: InputBorder.none,
                          fillColor: Color.fromARGB(0, 249, 149, 149),
                          filled: true,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        todoRef = await FirebaseFirestore.instance
                            .collection('todo')
                            .add({
                          'todoTitle': _todoController.text,
                          'checked': false,
                          'uid': FirebaseAuth.instance.currentUser!.uid,
                        });
                        documentId = todoRef.id;
                        FirebaseController.collection.doc(documentId).update(
                            Todo(
                                    id: documentId,
                                    todoTitle: _todoController.text,
                                    checked: false,
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .toJson(Todo(
                                    id: documentId,
                                    todoTitle: _todoController.text,
                                    checked: false,
                                    uid: FirebaseAuth
                                        .instance.currentUser!.uid)));
                        _todoController.text = '';
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: ShapeDecoration(
                                      color: Color.fromARGB(255, 121, 121, 121),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
