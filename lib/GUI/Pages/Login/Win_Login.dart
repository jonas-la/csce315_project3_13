import 'package:csce315_project3_13/GUI/Pages/Login/Win_Reset_Password.dart';
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

  String _page_name = "Login";
  bool _show_password = false;

  late TextEditingController _username_controller;
  late TextEditingController _password_controller;

  login_helper _login_helper_instance = login_helper();

  void _switch_show_password(){
    setState(() {
      _show_password = !_show_password;
    });
  }

  void _login(BuildContext context){
    _login_helper_instance.login(context: context, username: _username_controller.text, password: _password_controller.text);
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
        title: Text(_page_name),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, Win_Reset_Password.route);
                }, child: const Text("Reset password")),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Enter your email and password:',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),

              TextField(
                controller: _username_controller,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),),

              TextField(
                 controller: _password_controller,
                 onSubmitted: (String pass_string){
                   _login(context);
                 },
                 obscureText: !_show_password,
                 decoration: const InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Password',
                 ),),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: _show_password,
                      onChanged: (changed_value){
                    _switch_show_password();
                  }),

                  Text("Show password"),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  _login(context);
                }, child: const Text("Login")),
              ),


            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
