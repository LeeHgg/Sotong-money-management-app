import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Column(
        children: [
          Container(
            width: 393,
            height: 852,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 46,
                  top: 129,
                  child: Text(
                    '이메일을 입력하세요',
                    style: TextStyle(
                      color: const Color(0xFF231F1F),
                      fontSize: 28,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -2,
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 0,
                  child: Container(
                    width: 375,
                    height: 44,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(width: 375, height: 30, child: Stack()),
                        ),
                        Positioned(
                          left: 292,
                          top: 16,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 4,
                            children: [
                              Container(width: 20, height: 14, child: Stack()),
                              Container(width: 16, height: 14, child: Stack()),
                              Container(
                                width: 25,
                                height: 14,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 2,
                                      top: 3,
                                      child: Container(
                                        width: 19,
                                        height: 8,
                                        decoration: ShapeDecoration(
                                          color: Colors.black,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 298,
                          top: 8,
                          child: Container(width: 6, height: 6, child: Stack()),
                        ),
                        Positioned(
                          left: 21,
                          top: 12,
                          child: Container(
                            width: 54,
                            height: 21,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 11,
                                  top: 3,
                                  child: Container(width: 33, height: 15, child: Stack()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 46,
                  top: 200,
                  child: Container(
                    width: 294,
                    height: 57,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEDF4FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 25,
                          top: 17,
                          child: SizedBox(
                            width: 243,
                            child: Text(
                              'sotongofficial@naver.com',
                              style: TextStyle(
                                color: const Color(0xFF231F1F),
                                fontSize: 17,
                                fontFamily: 'Pretendard Variable',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 818,
                  child: Container(
                    width: 375,
                    height: 34,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 120,
                          top: 21,
                          child: Container(
                            width: 134,
                            height: 5,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 134,
                                    height: 5,
                                    decoration: ShapeDecoration(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 46,
                  top: 728,
                  child: Container(
                    width: 294,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 81, vertical: 13),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF0062FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          '다음',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
