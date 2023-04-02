import 'package:csce315_project3_13/GUI/Pages/Login/Win_Login.dart';
import 'package:csce315_project3_13/Services/login_helper.dart';
import 'package:flutter/material.dart';


class Win_Create_Account extends StatefulWidget {
  static const String route = '/create-account';
  const Win_Create_Account({Key? key}) : super(key: key);

  @override
  State<Win_Create_Account> createState() => _Win_Create_AccountState();
}

class _Win_Create_AccountState extends State<Win_Create_Account> {

  String _page_name = "Create account";
  bool _show_password = false;

  late TextEditingController _username_controller;
  late TextEditingController _password_controller1;
  late TextEditingController _password_controller2;

  login_helper _login_helper_instance = login_helper();

  void _switch_show_password(){
    setState(() {
      _show_password = !_show_password;
    });
  }

  void _create_account({required BuildContext context}){

    if(_password_controller1.text == _password_controller2.text){
    //  If both passwords are the same calls the login helper function

      _login_helper_instance.create_account(context: context, user_email: _username_controller.text, user_password: _password_controller1.text);

    }else{
    //  If the passwords are different

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Entered different passwords'),
            content: const Text('Try again, and ensure your passwords match'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  // Perform some action here
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

    }

  }



  @override
  void initState() {
    super.initState();
    _username_controller = TextEditingController();
    _password_controller1 = TextEditingController();
    _password_controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _username_controller.dispose();
    _password_controller1.dispose();
    _password_controller2.dispose();
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
                  'Enter your email and password:',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _username_controller,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),),
              ),



              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _password_controller1,
                  obscureText: !_show_password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _password_controller2,
                  onSubmitted: (String pass_string){
                    _create_account(context: context);
                  },
                  obscureText: !_show_password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Re-enter Password',
                  ),),
              ),

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
                  _create_account(context: context);
                }, child: const Text("Create Account")),
              ),


            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
