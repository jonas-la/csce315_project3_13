import 'dart:collection';
import 'package:csce315_project3_13/Services/general_helper.dart';
import '../Models/models_library.dart';
import 'package:cloud_functions/cloud_functions.dart';

class order_processing_helper
{
  general_helper gen_helper = general_helper();

  Future<List<String>> process_order(order_obj order) async
  {
    Map<String, int> ingredient_amounts = await get_ingredient_totals(order.item_ids_in_order);
    List<String> invalid_items = await is_order_valid(ingredient_amounts);
    if(invalid_items.isEmpty) {
      for(MapEntry entry in ingredient_amounts.entries) {
        await inventory_decrement(entry.key, entry.value);
      }
      await push_to_table(order.get_values());
      await push_to_table(order.get_values());
    }

    return invalid_items;
  }

  // Takes in an order_obj.item_ids_in_order, and will return a list of ints of item ids that do not have enough stock
  // If this list is empty, then the order is valid!
  Future<List<String>> is_order_valid(Map<String, int> ingredient_amounts) async
  {
    List<String> invalid_items = [];

    for(MapEntry entry in ingredient_amounts.entries) {
      int total = await gen_helper.get_total_amount_inv_stock(entry.key);
      await gen_helper.get_amount_inv_stock(entry.key);
      if(total < entry.value) {
        invalid_items.add(entry.key);
      }
    }

    return invalid_items;

  }


  // Returns false if the item requested does not have enough stock to decrement by
  Future<void> inventory_decrement(String ingredient, int amount_used) async
  {
    int amount_left_to_decrement = amount_used;
    HttpsCallable setter = FirebaseFunctions.instance.httpsCallable('updateInventoryRow');
    List<dynamic> inventory_item_amounts = await gen_helper.get_amount_inv_stock(ingredient);

    while(amount_left_to_decrement > 0) {
      if(inventory_item_amounts[0]['amount_inv_stock'] < amount_left_to_decrement) {
        await setter.call({
          'inv_order_id': inventory_item_amounts[0]['inv_order_id'],
          'new_amount' : 0
        });
        amount_left_to_decrement -= inventory_item_amounts[0]['amount_inv_stock'] as int;
        inventory_item_amounts.removeAt(0);
      } else {
        await setter.call({
          'inv_order_id': inventory_item_amounts[0]['inv_order_id'],
          'new_amount' : ((inventory_item_amounts[0]['amount_inv_stock'] as int) - amount_left_to_decrement)
        });
        amount_left_to_decrement = 0;
      }
    }

  }

  Future<Map<String, int>> get_ingredient_totals(List<int> items) async
  {
    Map<String, int> ingredient_amounts = HashMap();

    for(int item_id in items) {
      String item_name = await gen_helper.get_item_name(item_id);
      String item_type = await gen_helper.get_item_type(item_id);
      if (item_type == "smoothie") {
        HttpsCallable get_ingredients = FirebaseFunctions.instance.httpsCallable('getMenuItemIngredients');
        final ingredients = await get_ingredients.call({'menu_item_name': item_name});
        List<dynamic> data = ingredients.data;
        for (int i = 0; i < data.length; i++) {
          String ing_name = data[i]['ingredient_name'];
          int amount = data[i]['ingredient_amount'];
          ingredient_amounts.update(ing_name, (value) => value + amount, ifAbsent: () => amount);
        }
      }
      else {
        ingredient_amounts.update(item_name, (value) => ++value, ifAbsent: () => 1);
      }
    }

    return ingredient_amounts;

  }

  Future<void> push_to_table(String values) async
  {
    HttpsCallable adder = FirebaseFunctions.instance.httpsCallable('insertIntoOrderHistory');
    await adder.call({'values': values});
  }
}