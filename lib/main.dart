import 'package:csce315_project3_13/Constants/constants.dart';
import 'package:csce315_project3_13/GUI/Pages/Login/Win_Create_Account.dart';
import 'package:csce315_project3_13/GUI/Pages/Login/Win_Reset_Password.dart';
import 'package:csce315_project3_13/GUI/Pages/Order/Win_Order.dart';
import 'package:csce315_project3_13/GUI/Pages/Test%20Pages/Win_Functions_Test_Page.dart';
import 'package:csce315_project3_13/GUI/Pages/Win_Manager_View.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'GUI/Pages/Login/Win_Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smoothie King App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes:  <String, WidgetBuilder>{
        Win_Login.route: (BuildContext context) => Win_Login(),
        Win_Reset_Password.route: (BuildContext context) => Win_Reset_Password(),
        Win_Create_Account.route: (BuildContext context) => Win_Create_Account(),
        Win_Manager_View.route: (BuildContext context) => Win_Manager_View(),
        Win_Functions_Test_Page.route: (BuildContext context) => Win_Functions_Test_Page(),
        Win_Order.route : (BuildContext context) => Win_Order(),
      },
      initialRoute: Win_Login.route,
    );
  }
}

