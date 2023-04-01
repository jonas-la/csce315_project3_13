import 'package:csce315_project3_13/Models/menu_item_obj.dart';
import 'package:csce315_project3_13/Services/menu_item_helper.dart';
import 'package:flutter/material.dart';

class Test_Page extends StatefulWidget {
  static const String route = '/test-page';
  const Test_Page({Key? key}) : super(key: key);

  @override
  State<Test_Page> createState() => _Test_PageState();
}

class _Test_PageState extends State<Test_Page> {


  @override
  void initState() {


    print("test");
    menu_item_helper helper = menu_item_helper();
    menu_item_obj menu_item = menu_item_obj(500, "dart test item", 50, 100, "dart item");
    helper.add_menu_item(menu_item);



    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
