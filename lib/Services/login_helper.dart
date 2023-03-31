import 'package:csce315_project3_13/Models/employee.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login_helper{
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> modify_results(String employee_uid) async {
      // final my_results = await get_employee_by_UID(employee_uid);
      print("got employee");
  }

  Future<void> test_id() async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getOneEmployeeByIdTest');

// Call the function with the employee UID as input
    final results = await callable.call(<String, dynamic>{
      'employee_id': 2,
    });

// Extract the name of the employee from the data returned by the function
    List<dynamic> employeeData = results.data;
    String employeeName = employeeData[0]['employee_name'];
    print(employeeName);
  }

  Future<void> test_uid() async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getEmployeeByUID');

// Call the function with the employee UID as input
    final results = await callable.call(<String, dynamic>{
      'employee_uid': 'wQI6aAGC4DYDHoNGXRNORnSnasb2',
    });

// Extract the name of the employee from the data returned by the function
    List<dynamic> employeeData = results.data;
    String employeeName = employeeData[0]['employee_name'];
    print(employeeName);
  }

  Future<void> get_employee_by_UID(String employee_uid) async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getEmployeeByUID');

// Call the function with the employee UID as input
    final results = await callable.call(<String, dynamic>{
      'employee_uid': 'wQI6aAGC4DYDHoNGXRNORnSnasb2',
    });

// Extract the name of the employee from the data returned by the function
    List<dynamic> employeeData = results.data;
    String employeeName = employeeData[0]['employee_name'];
    print(employeeName);

    // employee got_employee = employee(id: results.data[0], name: name, email: email, role: role, uid: uid, hourly_rate: hourly_rate)
  }


  Future<bool> sign_in_email_password(String user_email, String user_password) async {
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


  Future<bool> is_signed_in() async {
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
    await FirebaseAuth.instance.signOut();
  }
}