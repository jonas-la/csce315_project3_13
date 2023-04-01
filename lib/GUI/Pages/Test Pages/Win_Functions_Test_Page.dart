import 'package:csce315_project3_13/Services/database_connection.dart';
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

  database_connection dbc = database_connection();

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
              dbc.getEmployees();
            }, child: const Text("Test Firebase Function")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              dbc.getEmployeeByID(2);
            }, child: const Text("Test Firebase Function with parameter")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              menu_item_obj menu_item = menu_item_obj(500, "dart test item", 50.50, 100, "dart item");
              dbc.add_menu_item(menu_item);
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
