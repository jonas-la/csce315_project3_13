import 'package:cloud_functions/cloud_functions.dart';

class testing_cloud_functions{
  FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<void> getFruit() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('listFruit');
    final results = await callable();
    List fruit = results.data;  // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
    for(int i = 0; i < fruit.length; i++){
      print(fruit[i]);
    }
  }

  Future<void> getEmployees() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getTestResult');
    final results = await callable();
    // print(results.data);
  }

}