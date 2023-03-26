import 'package:csce315_project3_13/Services/testing_dart_psql.dart';
import 'package:flutter/material.dart';
import '../../Services/testing_cloud_functions.dart';
import 'Win_Manager_View.dart';

class Win_Functions_Test_Page extends StatefulWidget {
  const Win_Functions_Test_Page({super.key});

  @override
  State<Win_Functions_Test_Page> createState() => _Win_Functions_Test_Page_StartState();
}

class _Win_Functions_Test_Page_StartState extends State<Win_Functions_Test_Page> {

  testing_cloud_functions cloud_functions_tester = testing_cloud_functions();

  testing_dart_psql dart_psql_tester = testing_dart_psql();


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test functions page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Win_Manager_View()),
              );
            }, child: const Text("Login")),

            ElevatedButton(onPressed: (){
              cloud_functions_tester.getEmployees();
            }, child: const Text("Test Firebase Function")),

            ElevatedButton(onPressed: (){
              dart_psql_tester.connectToPostgreSQL();
            }, child: const Text("Test Dart PSQL")),


            // t
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
