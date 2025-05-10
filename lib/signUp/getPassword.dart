import 'package:flutter/material.dart';

class GetPasswordPage extends StatefulWidget {
  const GetPasswordPage({Key? key}) : super(key: key);

  @override
  _GetPasswordPageState createState() => _GetPasswordPageState();
}

class _GetPasswordPageState extends State<GetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(); // _passwordController로 변경
  final _focusNode = FocusNode(); // FocusNode 추가
  String _password = '';

  // 비밀번호 입력값 검증 함수
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    if (value.length < 6) {
      return '비밀번호는 6자리 이상이어야 합니다';
    }
    return null;
  }

  @override
  void dispose() {
    // FocusNode와 TextEditingController를 정리
    _focusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면이 자동으로 조정되도록 설정
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 46,
                    top: 129,
                    child: Text(
                      '비밀번호를 입력하세요',
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _passwordController, // _passwordController로 변경
                            focusNode: _focusNode, // FocusNode를 연결
                            obscureText: true, // 비밀번호 입력을 숨기기
                            decoration: InputDecoration(
                              hintText: '비밀번호를 입력하세요',
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            onSaved: (value) {
                              _password = value ?? '';
                            },
                            validator: _validatePassword, // 비밀번호 검증 함수 호출
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 81, vertical: 13),
                decoration: ShapeDecoration(
                  color: const Color(0xFF0062FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      Navigator.of(context).pushNamed('/getUserInfo');
                    }
                  },
                  child: Center(
                    child: Text(
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
