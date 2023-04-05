import 'dart:collection';
import '../Models/models_library.dart';
import 'package:cloud_functions/cloud_functions.dart';

class general_helper
{
  Future<String> get_item_name(int menu_item_id) async
  {
    HttpsCallable getter = FirebaseFunctions.instance.httpsCallable('getMenuItemName');
    final item_name_query = await getter.call({'menu_item_id': menu_item_id});
    List<dynamic> data = item_name_query.data;
    String menu_item = data[0]['menu_item'];

    return menu_item;
  }
  
  Future<String> get_item_type(int menu_item_id) async
  {
    HttpsCallable getter = FirebaseFunctions.instance.httpsCallable('getMenuItemType');
    final item_name_type = await getter.call({'menu_item_id': menu_item_id});
    List<dynamic> data = item_name_type.data;
    String type = data[0]['type'];

    return type;
  }

  Future<Map<String, int>> get_smoothie_ingredients(int menu_item_id) async
  {
    Map<String, int> ingredients = HashMap();
    HttpsCallable get_ingredients = FirebaseFunctions.instance.httpsCallable('getMenuItemIngredients');
    String item_name = await get_item_name(menu_item_id);
    final query = await get_ingredients.call({'menu_item_name': item_name});
    List<dynamic> data = query.data;
    for (int i = 0; i < data.length; i++) {
      String ing_name = data[i]['ingredient_name'];
      int amount = data[i]['ingredient_amount'];
      ingredients[ing_name] = amount;
    }
    return ingredients;
  }

  Future<int> get_total_amount_inv_stock(String ingredient) async
  {
    List<dynamic> data = await get_amount_inv_stock(ingredient);
    int total = 0;
    for(int i = 0; i < data.length; ++i) {
      total += data[i]['amount_inv_stock'] as int;
    }
    return total;
  }

  Future<List<dynamic>> get_amount_inv_stock(String ingredient) async
  {
    HttpsCallable get_amt_in_stock = FirebaseFunctions.instance.httpsCallable('getAmountInvStock');
    dynamic res = await get_amt_in_stock.call({'ingredient': ingredient});
    return res.data;
  }

  Future<int> get_ingredient_row_id(String menu_item_name, String ingredient_name) async
  {
    HttpsCallable getter = FirebaseFunctions.instance.httpsCallable('getIngredientRowId');
    final res = await getter.call({
      'menu_item_name': menu_item_name,
      'ingredient_name': ingredient_name
    });
    return (res.data[0]['row_id'] as int);
  }

}