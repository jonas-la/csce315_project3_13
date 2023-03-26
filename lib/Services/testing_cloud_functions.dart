import 'package:cloud_functions/cloud_functions.dart';

class testing_cloud_functions{
  FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<void> getEmployees() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getEmployeesTest');
    final results = await callable();
    List resultsList = results.data;
    for(int i = 0; i < resultsList.length; i++){
      print(resultsList[i]);
    }
  }

}