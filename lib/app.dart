import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';
import 'login_email.dart';
import 'signup.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sotong',
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(
                builder: (context) => const SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/email_login':
            return MaterialPageRoute(builder: (context) => const EmailLoginPage());
          case '/signup':
            return MaterialPageRoute(builder: (context) => const SignupPage());
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 3초 뒤 로그인 페이지로 전환
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
