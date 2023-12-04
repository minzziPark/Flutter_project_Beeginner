import 'package:beeginner/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailContoroller = TextEditingController();
  final _passwordContoroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력하세요.';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return '유효한 이메일 주소를 입력하세요.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력하세요.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            semanticLabel: 'back',
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
        title: const Text(
          '회원가입',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w100,
            height: 0,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color.fromRGBO(230, 224, 233, 1),
              height: 0.5,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(34.0, 30.0, 322, 0),
              child: Text(
                '이메일',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: Container(
                  width: 370,
                  height: 50,
                  child: TextFormField(
                    controller: _emailContoroller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x00D9D9D9),
                      hintText: '이메일 주소',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.50,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFCBCBCB)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 41, 41, 41)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(34.0, 17.0, 322, 0),
              child: Text(
                '비밀번호',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: Container(
                  width: 370,
                  height: 50,
                  child: TextFormField(
                    controller: _passwordContoroller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x00D9D9D9),
                      hintText: '8~16자리 숫자, 영문자, 특수문자',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.50,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFCBCBCB)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 41, 41, 41)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 500),
              child: Center(
                  child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      UserCredential _credential =
                          await _firebaseAuth.createUserWithEmailAndPassword(
                              email: _emailContoroller.text,
                              password: _passwordContoroller.text);
                      if (_credential.user != null) {
                        // user = _credential.user;
                      }
                    } on FirebaseAuthException catch (error) {
                      // logger.e(error.code);
                      String? _errorCode;
                      switch (error.code) {
                        case "email-already-in-use":
                          _errorCode = error.code;
                          break;
                        case "invalid-email":
                          _errorCode = error.code;
                          break;
                        case "weak-password":
                          _errorCode = error.code;
                          break;
                        case "operation-not-allowed":
                          _errorCode = error.code;
                          break;
                        default:
                          _errorCode = null;
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                child: Container(
                  width: 370,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD0D0D7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '회원가입', // 원하는 텍스트로 변경
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255), // 텍스트의 색상 설정
                      ),
                    ),
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
