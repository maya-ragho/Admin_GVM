import 'dart:io';

import 'package:admin_gvm/Dashboard/profilepage.dart';
import 'package:admin_gvm/startingScreen/loginScreen.dart';
import 'package:admin_gvm/startingScreen/onboarding_screen.dart';
import 'package:admin_gvm/startingScreen/signupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Dashboard/Dashboard_Screen.dart';
import 'Dashboard/forwordscreen.dart';
import 'Form/listpage.dart';

//
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}
Future<void> main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
   // await Firebase.initializeApp();
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
      initialRoute: OnboardingScreen.id,
      routes: {
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
        ListPages.id: (context) => const ListPages(
              id: null,
            ),
        // ForgotPasswordPage.id: (context) =>  ForgotPasswordPage(key: null,),
        Profilepage.id: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is String) {
            return Profilepage(args);
          }
          // Handle other cases if needed
          return const Profilepage(
              ''); // Provide a default value or handle the case as per your app logic
        },
        ForwordScreen.id: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is String) {
            return ForwordScreen(args);
          }
          // Handle other cases if needed
          return const ForwordScreen(
              ''); // Provide a default value or handle the case as per your app logic
        },
      },
    );
  }
}
