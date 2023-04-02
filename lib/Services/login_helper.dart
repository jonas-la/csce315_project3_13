import 'package:csce315_project3_13/GUI/Pages/Win_Manager_View.dart';
import 'package:csce315_project3_13/Models/employee.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login_helper{
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // late FirebaseFunctions my_functions;

  // login_helper(){
  //   my_functions = FirebaseFunctions.instance;
  // }


  void login({required BuildContext context, required String username, required String password}) async {
    bool sign_in_successful = await sign_in_email_password(user_email: username, user_password: password);
    if(sign_in_successful){
      navigate_to_landing(context: context);
    }else{
      print("Failed login");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign in failed'),
            content: Text('Username or password is incorrect.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
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


  Future<bool> sign_in_email_password({required String user_email, required String user_password}) async {
    //signs the user in with email and password

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user_email,
        password: user_password,
      );
      // Handle successful login
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<void> navigate_to_landing({required BuildContext context}) async {
    //TODO add functionality to navigate to correct page for user

    String user_uid = await get_firebase_uid();

    employee current_employee = await get_employee_by_uid(user_uid: user_uid);

    print("Current employee's role = ");
    print(current_employee.role);

    if(current_employee.role == "Manager"){
    //  TODO Add navigation to manager page

    }else if(current_employee.role == "Server"){
    //  TODO Add navigation to server page

    }else if(current_employee.role == "Customer"){
    //  TODO Add navigation to Customer page

    }else{
      // TODO Handle the edge case
      print("!!! The role was not one of the options");

    }

    // TODO remove when function complete
    Navigator.pushReplacementNamed(context, Win_Manager_View.route);
  }


  Future<employee> get_employee_by_uid({required String user_uid}) async {
    //TODO get employee from psql database

    employee employee_to_return = employee(id: 0, name: "", email: "", role: "", uid: "", hourly_rate: 0.0);

    employee_to_return = await get_employee_by_UID_database(user_uid);

    return employee_to_return;
  }


  Future<void> create_account({ required BuildContext context, required String user_email, required String user_password}) async {
    //signs the user in with email and password

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user_email, password: user_password);
      // Handle successful login
    } on FirebaseAuthException catch (e) {

      print('ERROR Could not create email');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Account creation failed'),
            content: const Text('Something went wrong, ensure email is valid and try again'),
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



  Future<void> reset_password({required String user_email, required BuildContext context}) async {
    //signs the user in with email and password

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user_email);
      // Handle successful login
    } on FirebaseAuthException catch (e) {

        print('ERROR Could not reset email');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Reset password failed'),
              content: const Text('Something went wrong, ensure email is correct and try again'),
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


  Future<bool> is_signed_in() async {
    // returns true if the user is signed in

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("Signed in as: ");
      print(user.email);
    }else{
      print("Not logged in");
    }

    return user != null;
  }


  Future<String> get_firebase_uid() async {
    // gets the UID of the signed in user from firebase users

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Signed in and UID is:");
      print(user.uid);
      return user.uid;
    }else{
      print("Not logged in");
      return "";
    }
  }

  Future<String> get_firebase_email() async {
    // gets the UID of the signed in user from firebase users

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Signed in and email is:");
      print(user.email);
      String user_email = "notemail@gmail.com";
      user_email = (user.email).toString();
      return user_email;
    }else{
      print("Not logged in");
      return "";
    }
  }


  Future<void> sign_out() async {
    //signs out the user
    await FirebaseAuth.instance.signOut();
  }

  Future<employee> get_employee_by_UID_hardcoded(String employee_uid) async {
    //TODO temporarily rely on this
    // Temporary function to get the hardcoded value

    Map<String, employee> employee_hash_map = {
      'RPhPjO2LQ2MMTHMwZS7N3JWFOAx2': employee(
        id: 1,
        name: 'Maharshi',
        email: '',
        role: 'Manager',
        uid: 'RPhPjO2LQ2MMTHMwZS7N3JWFOAx2',
        hourly_rate: 25.87,
      ),
      'wQI6aAGC4DYDHoNGXRNORnSnasb2': employee(
        id: 2,
        name: 'Jonas',
        email: '',
        role: 'Server',
        uid: 'wQI6aAGC4DYDHoNGXRNORnSnasb2',
        hourly_rate: 14.99,
      ),
      'FjOPjWpPRNYl2W6XqFymugBlKcs2': employee(
        id: 3,
        name: 'Tyler',
        email: '',
        role: 'Server',
        uid: 'FjOPjWpPRNYl2W6XqFymugBlKcs2',
        hourly_rate: 14.99,
      ),
      'kvrLmJjlxDgupk3IS6fgpO6KRM33': employee(
        id: 4,
        name: 'Freddy',
        email: '',
        role: 'Server',
        uid: 'kvrLmJjlxDgupk3IS6fgpO6KRM33',
        hourly_rate: 14.99,
      ),
      '2XkBeUBFQ9TjEYr2rOjwaqJkGFm2': employee(
        id: 5,
        name: 'Seth',
        email: '',
        role: 'Manager',
        uid: '2XkBeUBFQ9TjEYr2rOjwaqJkGFm2',
        hourly_rate: 25.87,
      ),
    };

    employee current_employee = employee(id: 0, name: "", email: "", role: "Customer", uid: employee_uid, hourly_rate: 0.0);

    if(employee_hash_map[employee_uid] != null){
      current_employee = employee_hash_map[employee_uid] as employee;
    }

    String employee_email = await get_firebase_email();

    print(employee_email);

    current_employee.email = employee_email;

    return current_employee;



    // print(employee_id);
      // print(employee_name);
      // print(employee_role);
      // print(employee_uid);
      // print(employee_hourly_rate);


      // int employee_id = int.parse(employee_id_string);
      // double employee_hourly_rate = double.parse(employee_hourly_rate_string);

      // return employee(id: employee_id, name: employee_name, email: employee_email, role: employee_role, uid: employee_uid, hourly_rate: employee_hourly_rate);


  }




//  These are functions to revisit once I figure out what is going on with firebase cloud functios
// TODO figure out how to query for an employee with firebase functions

  Future<employee> get_employee_by_UID_database(String employee_uid) async {
    //TODO get this working
    //It currently has an internal firebase error each time I call it

    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getEmployeeByUID');

    try{
      // Call the function with the employee UID as input
      final results = await callable.call(<String, dynamic>{
        'employee_uid': employee_uid,
      });

      // Extract the name of the employee from the data returned by the function
      List<dynamic> employeeData = results.data;
      int employee_id = employeeData[0]['employee_id'];
      String employee_name = employeeData[0]['employee_name'];
      String employee_role = employeeData[0]['employee_role'];
      double employee_hourly_rate = employeeData[0]['hourly_rate'];

      print(employee_id);
      print(employee_name);
      print(employee_role);
      print(employee_uid);
      print(employee_hourly_rate);

      String employee_email = await get_firebase_email();

      print(employee_email);

      // int employee_id = int.parse(employee_id_string);
      // double employee_hourly_rate = double.parse(employee_hourly_rate_string);

      return employee(id: employee_id, name: employee_name, email: employee_email, role: employee_role, uid: employee_uid, hourly_rate: employee_hourly_rate);

    }catch(e){
      print("Could not get employee by uid from database");
      print("error was");
      print(e);


      return employee(id: 0, name: "", email: "", role: "Customer", uid: employee_uid, hourly_rate: 0.0);
    }

    }


//   Future<void> modify_results(String employee_uid) async {
//     // final my_results = await get_employee_by_UID(employee_uid);
//     print("got employee");
//   }
//
//   Future<void> test_id() async {
//     try{
//       final HttpsCallable callable = my_functions.httpsCallable('getOneEmployeeByIdTest');
//
// // Call the function with the employee UID as input
//       final results = await callable.call(<String, dynamic>{
//         'employee_id': 2,
//       });
//
// // Extract the name of the employee from the data returned by the function
//       List<dynamic> employeeData = results.data;
//       String employeeName = employeeData[0]['employee_name'];
//       print(employeeName);
//     }catch(e){
//       print(e);
//     }
//
//   }
//
//   Future<void> test_uid() async {
//     final HttpsCallable callable = my_functions.httpsCallable('getEmployeeByUID');
//
// // Call the function with the employee UID as input
//     final results = await callable.call(<String, dynamic>{
//       'employee_uid': 'wQI6aAGC4DYDHoNGXRNORnSnasb2',
//     });
//
// // Extract the name of the employee from the data returned by the function
//     List<dynamic> employeeData = results.data;
//     String employeeName = employeeData[0]['employee_name'];
//     print(employeeName);
//   }
//

}