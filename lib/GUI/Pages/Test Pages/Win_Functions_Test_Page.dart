import 'package:csce315_project3_13/Services/menu_item_helper.dart';
import 'package:flutter/material.dart';
import '../../../Models/menu_item_obj.dart';
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
  menu_item_helper menu_cloud_tester = menu_item_helper();

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
              menu_item_obj menu_item = menu_item_obj(500, "dart test item", 50.50, 100, "dart item");
              menu_cloud_tester.add_menu_item(menu_item);
            }, child: const Text("Add menu item to database")),
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
