import 'package:flutter/material.dart';
import '../Win_Manager_View.dart';
import '../Order/Win_Order.dart';


class Win_Login extends StatefulWidget {
  static const String route = '/login';
  const Win_Login({super.key});

  @override
  State<Win_Login> createState() => _Win_LoginState();
}

class _Win_LoginState extends State<Win_Login> {

  String page_name = "Login Window";

  late TextEditingController _username_controller;
  late TextEditingController _password_controller;

  void _login(BuildContext context){
    Navigator.pushNamed(context, Win_Manager_View.route);
  }

  @override
  void initState() {
    super.initState();
    _username_controller = TextEditingController();
    _password_controller = TextEditingController();
  }

  @override
  void dispose() {
    _username_controller.dispose();
    _password_controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(page_name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter your username and password:',
            ),
            TextField(
              controller: _username_controller,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),),
        TextField(
          controller: _password_controller,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),),
            ElevatedButton(onPressed: (){
              _login(context);
            }, child: const Text("Login")),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, Win_Order.route);
              }, child: Text('Order')),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
