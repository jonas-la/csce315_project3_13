import 'package:csce315_project3_13/Services/order_processing_helper.dart';
import 'package:flutter/material.dart';
import '../../../Models/models_library.dart';
import '../../../Services/database_connection.dart';
import '../Win_Manager_View.dart';

class Win_Functions_Test_Page extends StatefulWidget {
  static const String route = '/functions-test-page';
  const Win_Functions_Test_Page({super.key});

  @override
  State<Win_Functions_Test_Page> createState() => _Win_Functions_Test_Page_StartState();
}

class _Win_Functions_Test_Page_StartState extends State<Win_Functions_Test_Page> {

  order_processing_helper order_helper = order_processing_helper();

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
            }, child: const Text("Test Firebase Function")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
            }, child: const Text("Test Firebase Function with parameter")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              order_obj order = order_obj(100000, 1, [1,2,3], 50.0, "bob", "3/3/23", "complete");
              order_helper.process_order(order);
            }, child: const Text("calc order ingredients")),
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
