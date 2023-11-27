import 'package:beeginner/main.dart';
import 'package:beeginner/schedule.dart';
import 'package:beeginner/tip.dart';
import 'package:beeginner/todo.dart';
import 'package:beeginner/login.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BeeginnerApp extends StatelessWidget {
  const BeeginnerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ApplicationState>();
    return MaterialApp(
      title: 'Beeginner',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) =>
            !appState.loggedIn ? const LoginPage() : const TodoPage(),
        '/': (BuildContext context) => const TodoPage(),
        '/schedule': (BuildContext context) => const SchedulePage(),
        '/tip': (BuildContext context) => const TipPage(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
