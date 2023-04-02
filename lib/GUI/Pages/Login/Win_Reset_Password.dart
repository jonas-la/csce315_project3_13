import 'package:csce315_project3_13/GUI/Pages/Login/Win_Login.dart';
import 'package:csce315_project3_13/Services/login_helper.dart';
import 'package:flutter/material.dart';


class Win_Reset_Password extends StatefulWidget {
  static const String route = '/reset-password';
  const Win_Reset_Password({Key? key}) : super(key: key);

  @override
  State<Win_Reset_Password> createState() => _Win_Reset_PasswordState();
}

class _Win_Reset_PasswordState extends State<Win_Reset_Password> {

  String _page_name = "Reset Password";

  late TextEditingController _email_controller;


  login_helper _login_helper_instance = login_helper();


  void _reset_password({required String user_email, required BuildContext context})async{
    await _login_helper_instance.reset_password(user_email: user_email, context: context);
    Navigator.pushReplacementNamed(context, Win_Login.route);
  }

  @override
  void initState() {
    super.initState();
    _email_controller = TextEditingController();

  }

  @override
  void dispose() {
    _email_controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page_name),
        actions: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, Win_Login.route);
                }, child: const Text("Back")),
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
                  'Enter your email',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),

              TextField(
                controller: _email_controller,
                onSubmitted: (my_text){
                  _reset_password(user_email: _email_controller.text, context: context);
                },
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),),




              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  _reset_password(user_email: _email_controller.text, context: context);
                }, child: const Text("Send reset email")),
              ),


            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
