import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Container(
              width: 182,
              child: SvgPicture.asset(
                'assets/images/Beeginner.svg',
                width: 182,
              ),
            ),
            const SizedBox(height: 40.0),
            TextField(
              controller: _userEmailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                labelText: '이메일',
                prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // 텍스트 필드가 포커싱되었을 때 테두리 색상
                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // 텍스트 필드가 활성화되었을 때 테두리 색상
                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
              ),
              cursorColor: const Color.fromARGB(255, 78, 78, 78),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                labelText: '비밀번호',
                prefixIcon: Icon(Icons.lock_outlined, color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // 텍스트 필드가 포커싱되었을 때 테두리 색상
                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // 텍스트 필드가 활성화되었을 때 테두리 색상
                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
              ),
              cursorColor: const Color.fromARGB(255, 78, 78, 78),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
