import 'package:csce315_project3_13/GUI/Pages/Test%20Pages/Win_Functions_Test_Page.dart';
import 'package:csce315_project3_13/Services/login_helper.dart';
import 'package:flutter/material.dart';
import '../Win_Manager_View.dart';

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

  login_helper login_helper_instance = login_helper();

  void _login(BuildContext context) async {
    bool sign_in_successful = await login_helper_instance.signInWithEmailAndPassword(_username_controller.text, _password_controller.text);
    if(sign_in_successful){
      Navigator.pushNamed(context, Win_Functions_Test_Page.route);
    }else{
      print("Failed login");
    }

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
          onSubmitted: (String pass_string){
            _login(context);
          },
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),),
            ElevatedButton(onPressed: (){
              _login(context);
            }, child: const Text("Login"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
