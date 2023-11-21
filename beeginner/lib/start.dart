import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 182,
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/Beeginner.svg',
              width: 182,
            ),
          ),
        ),
      ),
    );
  }
}
