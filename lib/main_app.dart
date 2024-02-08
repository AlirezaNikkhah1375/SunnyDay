import 'package:flutter/material.dart';
import 'package:no_more_waste/screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/login.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Box boxLogin = Hive.box("login");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home: boxLogin.get("loginStatus") ?? false ? Home() : const Login(),
    );
  }
}
