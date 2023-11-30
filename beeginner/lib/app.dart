import 'package:beeginner/main.dart';
import 'package:beeginner/schedule.dart';
import 'package:beeginner/tip.dart';
import 'package:beeginner/tip_write.dart';
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
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/login':
            page = !appState.loggedIn ? const LoginPage() : const TodoPage();
            break;
          case '/':
            page = const TodoPage();
            break;
          case '/schedule':
            page = const SchedulePage();
            break;
          case '/tip':
            page = const TipPage();
            break;
          case '/tip_write':
            page = const TipWritePage();
            break;
          default:
            page = const SizedBox(); // Handle unknown routes if needed
        }

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Disable any transition
            return child;
          },
          // Optional: Override the transition duration
          transitionDuration: const Duration(milliseconds: 0),
        );
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
