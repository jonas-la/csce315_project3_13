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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              cloud_functions_tester.getEmployeeByID(2);
            }, child: const Text("Test Firebase Function with parameter")),



            // t
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
