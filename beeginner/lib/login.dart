// import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'main.dart';

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
    var appState = context.watch<ApplicationState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 182,
              child: SvgPicture.asset(
                'assets/images/Beeginner.svg',
                width: 182,
              ),
            ),
            const SizedBox(height: 46.0),
            TextField(
              controller: _userEmailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                labelText: '이메일',
                prefixIcon: const Icon(Icons.email_outlined,
                    color: Color.fromARGB(255, 145, 145, 145)),
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.7,
                  ), // 텍스트 필드가 포커싱되었을 때 테두리 색상
                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 145, 145, 145),
                    width: 0.7,
                  ), // 텍스트 필드가 활성화되었을 때 테두리 색상
                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
              ),
              cursorColor: const Color.fromARGB(255, 78, 78, 78),
            ),
            const SizedBox(height: 13.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                labelText: '비밀번호',
                prefixIcon: const Icon(Icons.lock_outlined,
                    color: Color.fromARGB(255, 145, 145, 145)),
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.7,
                  ), // 텍스트 필드가 포커싱되었을 때 테두리 색상

                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 145, 145, 145),
                    width: 0.7,
                  ), // 텍스트 필드가 활성화되었을 때 테두리 색상
                  borderRadius: BorderRadius.circular(5.0), // 테두리의 radius
                ),
              ),
              cursorColor: Color.fromARGB(255, 35, 27, 175),
              obscureText: true,
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: 400, // Elevated 버튼 폭 설정
              child: ElevatedButton(
                child: const Text(
                  '로그인',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  try {
                    // ignore: unused_local_variable
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _userEmailController.text,
                            password:
                                _passwordController.text) //아이디와 비밀번호로 로그인 시도
                        .then((value) {
                      appState.emailVerified == true //이메일 인증 여부
                          ? Navigator.pushNamed(context, '/')
                          : print('이메일 확인 안댐');
                      return value;
                    });
                  } on FirebaseAuthException catch (e) {
                    //로그인 예외처리
                    if (e.code == 'user-not-found') {
                      print('등록되지 않은 이메일입니다');
                    } else if (e.code == 'wrong-password') {
                      print('비밀번호가 틀렸습니다');
                    } else {
                      print(e.code);
                    }
                  }
                  // Navigator.pushNamed(context, '/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 226, 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  fixedSize: Size.fromHeight(56),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            OverflowBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 90, // 텍스트 버튼 폭 설정
                  child: TextButton(
                    child: const Text(
                      '아이디 찾기',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      // _userEmailController.clear();
                      // _passwordController.clear();
                    },
                  ),
                ),
                const SizedBox(
                  width: 1, // 텍스트 버튼 폭 설정
                  child: Text('|'),
                ),
                SizedBox(
                  width: 110, // 텍스트 버튼 폭 설정
                  child: TextButton(
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_in');
                    },
                  ),
                ),
                const SizedBox(
                  width: 1, // 텍스트 버튼 폭 설정
                  child: Text('|'),
                ),
                SizedBox(
                  width: 80, // Elevated 버튼 폭 설정
                  child: TextButton(
                    child: const Text(
                      '회원가입',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 226, 12)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
