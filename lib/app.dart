import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'models/sign_up_info.dart';
import 'screens/auth/welcome_auth_screen.dart';
import 'screens/auth/login/login_email.dart';
import 'screens/home/home.dart';
import 'screens/auth/signUp/getEmail.dart';
import 'screens/auth/signUp/getPassword.dart';
import 'screens/auth/signUp/getUserInfo.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sotong',
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/getUserInfo':
            final args = settings.arguments;
            if (args is SignUpInfo) {
              return MaterialPageRoute(
                builder: (context) => GetUserInfoPage(signUpInfo: args),
              );
            }
            // arguments가 null이거나 타입이 안 맞을 때
            return _errorRoute();
          case '/getPassword':
            final args = settings.arguments as SignUpInfo;
            if (args is SignUpInfo) {
              return MaterialPageRoute(
                builder: (context) => GetPasswordPage(signUpInfo: args),
              );
            }
            return _errorRoute();
          case '/getEmail':
            return MaterialPageRoute(builder: (context) => const GetEmailPage());
          case '/splash':
            return MaterialPageRoute(builder: (context) => const SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/email_login':
            return MaterialPageRoute(builder: (context) => const EmailLoginPage());
          case '/':
            return MaterialPageRoute(builder: (context) => const HomePage());
          default:
            return null;
        }
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}

Route _errorRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: Text('오류')),
      body: Center(
        child: Text('잘못된 접근입니다.'),
      ),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 3초 뒤 로그인 페이지로 전환
    WidgetsBinding.instance.addPostFrameCallback((_) { // Flutter의 위젯 트리가 빌드된 후에 특정 작업을 수행하도록 예약하는 기능
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(_createRoute());
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
            'sotong_svg/sotong logo.svg',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
