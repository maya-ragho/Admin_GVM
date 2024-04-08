import 'dart:async';
import 'package:flutter/material.dart';
import 'loginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static String id = 'splachscreen';
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: h * 0.3,
            ),
            Image.asset(
              'assets/images/icon.png',
              height: h * 0.3,
              width: w * 0.3,
            ),
            const Text(
              'Guest Visitor Management',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.white,
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


