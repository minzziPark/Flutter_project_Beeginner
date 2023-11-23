import 'package:beeginner/todo.dart';
import 'package:beeginner/login.dart';
import 'package:flutter/material.dart';

class BeeginnerApp extends StatelessWidget {
  const BeeginnerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beeginner',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const TodoPage(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
