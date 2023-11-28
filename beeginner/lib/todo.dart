import 'package:beeginner/controller/FirebaseController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/todolist.dart';
import 'package:beeginner/main.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _todoController = TextEditingController();
  bool isTextFieldFocused = false;

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
          Container(
            width: 380,
            height: 56,
            padding:
                const EdgeInsets.only(top: 0, left: 16, right: 24, bottom: 0),
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
                            checked: !todo.checked)
                        .toJson(todo));
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
                                        borderRadius: BorderRadius.circular(2)),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Color.fromARGB(255, 255, 255, 255),
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
                                        borderRadius: BorderRadius.circular(2)),
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
    DocumentReference<Map<String, dynamic>> todoRef;
    String documentId;
    if (snapshot.data == null) return Container();

    List<Todo> todos = snapshot.data?.docs.map<Todo>((data) {
          Todo todo = Todo.fromJson(data.data() as Map<String, dynamic>);
          todo.id = todo.id;
          return todo;
        }).toList() ??
        [];

    int numberOfTodos = todos.length;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 380,
            padding: EdgeInsets.fromLTRB(35, 40, 35, 0),
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
                          text: '의 할 일이 남아있어요!\n',
                          style: TextStyle(
                            color: Color(0xFF49454F),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                            letterSpacing: 0.25,
                          ),
                        ),
                        const TextSpan(
                          text: '잊지않도록 도와줄게요 :)',
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
          GridView.count(
            crossAxisCount: 1,
            padding: const EdgeInsets.all(11.0),
            childAspectRatio: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _buildGridCards(context, todos),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
            color: Color.fromRGBO(230, 224, 233, 1),
          ),
          Card(
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                        child: Container(
                          width: 150,
                          child: TextField(
                            controller: _todoController,
                            decoration: const InputDecoration(
                              hintText: '할 일을 입력하세요.',
                              border: InputBorder.none, // border 없애기
                              focusedBorder:
                                  InputBorder.none, // 포커스된 상태에서의 border 없애기
                            ),
                            style: const TextStyle(
                              color: Color(0xFF1D1B20),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0.09,
                              letterSpacing: 0.50,
                            ),
                            onTap: () {
                              setState(() {
                                isTextFieldFocused = true;
                              });
                            },
                          ),
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
                        });
                        documentId = todoRef.id;
                        FirebaseController.collection.doc(documentId).set(Todo(
                                id: documentId,
                                todoTitle: _todoController.text,
                                checked: false)
                            .toJson(Todo(
                                id: documentId,
                                todoTitle: _todoController.text,
                                checked: false)));
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
        ],
      ),
    );
  }
}
