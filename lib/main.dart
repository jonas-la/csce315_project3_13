import 'package:csce315_project3_13/GUI/Pages/Win_Manager_View.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'GUI/Pages/Win_Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smoothie King App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes:  <String, WidgetBuilder>{
        Win_Login.route: (BuildContext context) => Win_Login(),
        Win_Manager_View.route: (BuildContext context) => Win_Manager_View(),
      },
      initialRoute: Win_Login.route,
    );
  }
}

