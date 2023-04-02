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


  // -Adds a menu item to the database
  // -A menu_item_obj will get passed in, this object mirrors a row from the menu_items table
  // -If the menu item is a smoothie, it will get added three different times (small, medium, large)
  //    and will add its ingredients to the ingredients_table table
  // -If it is not a smoothie, then it will just be added as is to the menu_items table
  Future<void> add_menu_item(menu_item_obj new_item) async
  {
    HttpsCallable getItemID = FirebaseFunctions.instance.httpsCallable('getLastMenuItemID');
    HttpsCallable getIngrID = FirebaseFunctions.instance.httpsCallable('getLastIngredientsTableID');
    HttpsCallable addMenuItem = FirebaseFunctions.instance.httpsCallable('addMenuItem');

    final itemIDQuery = await getItemID();
    List<dynamic> data = itemIDQuery.data;
    int new_id = data[0]['menu_item_id'];

    if(new_item.type == "smoothie")
    {
      final ingrIDQuery = await getIngrID();
      data = ingrIDQuery.data;
      int last_ingr_id = data[0]['row_id'];

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
          for(String ingredient in new_item.ingredients) {
            last_ingr_id += 1;
            ingredient_obj ingr_obj = ingredient_obj(last_ingr_id, new_item.menu_item, ingredient, i);
            add_ingredient_row(ingr_obj);
          }
        }
        else if(i == 2)
        {
          new_item.menu_item = smoothie_name +  " medium";
          new_item.item_price = item_price;
          new_item.amount_in_stock = amount_in_stock;
          for(String ingredient in new_item.ingredients) {
            last_ingr_id += 1;
            ingredient_obj ingr_obj = ingredient_obj(last_ingr_id, new_item.menu_item, ingredient, i);
            add_ingredient_row(ingr_obj);
          }
        }
        else
        {
          new_item.menu_item = smoothie_name +  " large";
          new_item.item_price = item_price + 2;
          new_item.amount_in_stock = amount_in_stock * 2 ~/ 3;
          for(String ingredient in new_item.ingredients) {
            last_ingr_id += 1;
            ingredient_obj ingr_obj = ingredient_obj(last_ingr_id, new_item.menu_item, ingredient, i);
            add_ingredient_row(ingr_obj);
          }
        }
        String values = new_item.get_values();
        await addMenuItem.call({'values':  values});
      }
    }
    else
    {
      new_item.menu_item_id = new_id + 1;
      String values = new_item.get_values();
      await addMenuItem.call({'values':  values});
    }

  }

  // Simply takes in an ingredient_obj which mirrors a row from the ingredients_table table
  //    and adds it to the database
  Future<void> add_ingredient_row(ingredient_obj ingr_obj) async
  {
    HttpsCallable addIngredient = FirebaseFunctions.instance.httpsCallable('insertIntoIngredientsTable');
    await addIngredient.call({'values': ingr_obj.get_values()});
  }

  Future<void> edit_ingredient_row(int row_id, int new_amount) async
  {
    HttpsCallable editIngredient = FirebaseFunctions.instance.httpsCallable('updateIngredientsTableRow');
    await editIngredient.call({
      'row_id': row_id,
      'new_amount': new_amount
    });
  }

  // Deletes a single row from the ingredients_table table specified by row_id
  Future<void> delete_ingredient_row(int row_id) async
  {
    HttpsCallable deleteIngredient = FirebaseFunctions.instance.httpsCallable('deleteIngredientsTableRow');
    await deleteIngredient.call({'row_id': row_id});
  }

}