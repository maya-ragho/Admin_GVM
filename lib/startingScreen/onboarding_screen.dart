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
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/reception.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Your content here
              Image.asset(
                'assets/images/icon.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20.0),
              Text(
                'Guest Visitor Management',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
