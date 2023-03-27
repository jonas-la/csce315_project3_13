import 'package:cloud_functions/cloud_functions.dart';

class testing_cloud_functions{

  // This creates an instance of the FirebaseFunctions class we can use to call functions
  FirebaseFunctions functions = FirebaseFunctions.instance;

  // In Dart, Future is a return type that means at some point the value will be given
  // the type of what is actually returned should be specified in <>
  // async should be added a key word
  Future<void> getEmployees() async {

    //This creates an object of the firebase function we want
    //The name of the function is passed as a string
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getEmployeesTest');

    //This calls the function and stores the result
    final results = await callable();

    //This converts the data returned to a List (basically a vector)
    List resultsList = results.data;

    //This iterates through the list and prints its values
    for(int i = 0; i < resultsList.length; i++){
      print(resultsList[i]);
    }
  }

  Future<void> getEmployeeByID(int employee_id) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getOneEmployeeByIdTest');

    //This passes the value into the firebase function
    final results = await callable.call({'employee_id':  employee_id});
    print(results.data);
  }

}