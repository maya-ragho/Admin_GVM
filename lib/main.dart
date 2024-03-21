import 'package:admin_gvm/startingScreen/loginScreen.dart';
import 'package:admin_gvm/startingScreen/onboarding_screen.dart';
import 'package:admin_gvm/startingScreen/signupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'Dashboard/Dashboard_Screen.dart';
import 'Form/listpage.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    Platform.isAndroid
        ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAhWGY_nmjO8Tt8B5vnOqjkbP4Sh19oRWo",

          appId: "1:760064406384:android:216c1b6934a81a1c2795b5",
          messagingSenderId: "760064406384",
          projectId: "gvm-project-d48af",
          storageBucket: 'gvm-project-d48af.appspot.com'),
    )
        : await Firebase.initializeApp();
    runApp(const MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
      initialRoute: OnboardingScreen.id,
      routes: {
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
        DashboardScreen.id: (context) => const DashboardScreen(),
        ListPages.id: (context) => const ListPages(),
      },
    );
  }
}


