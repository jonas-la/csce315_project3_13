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
    HttpsCallable getID = FirebaseFunctions.instance.httpsCallable('getLastMenuItemID');
    HttpsCallable add = FirebaseFunctions.instance.httpsCallable('addMenuItem');

    final results = await getID();
    List<dynamic> data = results.data;
    int new_id = data[0]['menu_item_id'];

    if(new_item.type == "smoothie")
    {
      String smoothie_name = new_item.menu_item;
      double item_price = new_item.item_price;
      int amount_in_stock = new_item.amount_in_stock;
      for(int i = 1; i <= 3; i++)
      {
        new_item.menu_item_id = new_id + i;
        if(i == 1)
        {
          new_item.menu_item = smoothie_name +  " small";
          new_item.item_price = item_price - 2.40;
          new_item.amount_in_stock = amount_in_stock * 2;
        }
        else if(i == 2)
        {
          new_item.menu_item = smoothie_name +  " medium";
          new_item.item_price = item_price;
          new_item.amount_in_stock = amount_in_stock;
        }
        else
        {
          new_item.menu_item = smoothie_name +  " large";
          new_item.item_price = item_price + 2;
          new_item.amount_in_stock = amount_in_stock * 2 ~/ 3;
        }
        String values = new_item.get_values();
        await add.call({'values':  values});
      }
    }
    else
    {
      new_item.menu_item_id = new_id + 1;
      String values = new_item.get_values();
      await add.call({'values':  values});
    }

  }

}