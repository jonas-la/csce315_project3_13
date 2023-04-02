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

  void navigate_to_landing({required BuildContext context}){
    //TODO add functionality to navigate to correct page for user
    Navigator.pushReplacementNamed(context, Win_Manager_View.route);
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

  Future<bool> reset_password({required String user_email, required BuildContext context}) async {
    //signs the user in with email and password

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user_email);
      // Handle successful login
      return true;
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



      return false;
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


  Future<void> sign_out() async {
    //signs out the user
    await FirebaseAuth.instance.signOut();
  }



//  These are functions to revisit once I figure out what is going on with firebase cloud functios
// TODO figure out how to query for an employee with firebase functions

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
//   Future<void> get_employee_by_UID(String employee_uid) async {
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
//
//     // employee got_employee = employee(id: results.data[0], name: name, email: email, role: role, uid: uid, hourly_rate: hourly_rate)
//   }
}