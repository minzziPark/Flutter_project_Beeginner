import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class GetDay extends StatelessWidget {
  const GetDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (context) {
              return Text(
                DateFormat('yyyy.MM.dd.EEEE').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
