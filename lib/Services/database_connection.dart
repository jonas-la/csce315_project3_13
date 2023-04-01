import '../Models/models_library.dart';
import 'package:cloud_functions/cloud_functions.dart';

class database_connection{

  Future<void> getEmployees() async {

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getEmployeesTest');

    final results = await callable();

    List resultsList = results.data;

    for(int i = 0; i < resultsList.length; i++){
      print(resultsList[i]);
    }
  }

  Future<void> getEmployeeByID(int employee_id) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getOneEmployeeByIdTest');

    final results = await callable.call({'employee_id':  employee_id});
    print(results.data);
  }


  Future<void> add_menu_item(menu_item_obj new_item) async
  {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addMenuItem');
    String values = new_item.get_values();
    await callable.call({'values':  values});
  }

}