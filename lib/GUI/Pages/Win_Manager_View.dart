import 'package:csce315_project3_13/GUI/Pages/Win_Login.dart';
import 'package:flutter/material.dart';

class Win_Manager_View extends StatefulWidget {
  const Win_Manager_View({Key? key}) : super(key: key);

  @override
  State<Win_Manager_View> createState() => _Win_Manager_ViewState();
}

class _Win_Manager_ViewState extends State<Win_Manager_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager View"),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Logged in',
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Win_Login()),
              );

            }, child: Text("Log out"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
