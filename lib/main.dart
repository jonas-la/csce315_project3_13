import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'GUI/Win_Login.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),

      // FutureBuilder(
      //   future: _initialization,
      //   builder: (context, snapshot){
      //     if(snapshot.hasError){
      //       print("Error");
      //     }
      //
      //     if(snapshot.connectionState == ConnectionState.done){
      //       //once it has loaded
      //       return MyHomePage();
      //     }
      //
      //     return CircularProgressIndicator();
      //   },
      //
      // ),
    );
  }
}

