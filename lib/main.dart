import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_login/auth/Main_Page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}
