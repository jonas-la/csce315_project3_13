
import 'package:cloud_functions/cloud_functions.dart';
import 'package:csce315_project3_13/Services/login_helper.dart';
import 'package:csce315_project3_13/Services/order_processing_helper.dart';
import 'package:flutter/material.dart';
import '../../../Services/testing_cloud_functions.dart';
import '../Win_Manager_View.dart';

class Win_Functions_Test_Page extends StatefulWidget {
  static const String route = '/functions-test-page';
  const Win_Functions_Test_Page({super.key});

  @override
  State<Win_Functions_Test_Page> createState() => _Win_Functions_Test_Page_StartState();
}

class _Win_Functions_Test_Page_StartState extends State<Win_Functions_Test_Page> {


  testing_cloud_functions cloud_functions_tester = testing_cloud_functions();
  order_processing_helper order_helper = order_processing_helper();
  login_helper login_helper_instance = login_helper();

  
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
              cloud_functions_tester.getEmployees();
            }, child: const Text("Test Firebase Function")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              cloud_functions_tester.getEmployeeByID(2);
            }, child: const Text("Test Firebase Function with parameter")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              login_helper_instance.is_signed_in();
            }, child: const Text("Get logged in user")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              login_helper_instance.get_firebase_uid();
            }, child: const Text("Get UID")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              login_helper_instance.sign_out();
            }, child: const Text("Sign out")),
            const SizedBox(
              height: 20,
            ),





            // t
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
