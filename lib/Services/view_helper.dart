import 'package:cloud_functions/cloud_functions.dart';

class view_helper {
  Future<List<String>> get_all_smoothie_names() async {

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getSmoothieNames');
    final smoothie_name_query = await callable();
    List result = smoothie_name_query.data;
    List<String> names = [];

    for (int i = 0; i < result.length; i++) {
      names.add(result[i]['menu_item']);
    }

    print(names);

    return names;
  }

  Future<String> get_item_price(String item_name) async
  {
    HttpsCallable getter = FirebaseFunctions.instance.httpsCallable('getItemPrice');
    final item_name_query = await getter.call({'menu_item_name': item_name});
    List<dynamic> data = item_name_query.data;
    String item_price = data[0]['menu_item_price'];

    return item_price;
  }

  Future<int> get_item_id(String item_name) async
  {
    HttpsCallable getter = FirebaseFunctions.instance.httpsCallable('getItemID');
    final item_name_query = await getter.call({'menu_item_name': item_name});
    List<dynamic> data = item_name_query.data;
    int item_id = data[0]['menu_item_id'];

    return item_id;
  }

  Future<List<String>> get_unique_smoothie_names() async {

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getSmoothieNames');
    final smoothie_name_query = await callable();
    List result = smoothie_name_query.data;
    List<String> names = [];
    String clipped_name = "";
    int unclipped_length = 0;

    for (int i = 0; i < result.length; i++) {
      if (result[i]['menu_item'].contains("small")) {
        unclipped_length = result[i]['menu_item'].length;
        clipped_name = result[i]['menu_item'].substring(0, unclipped_length - 6);
        names.add(clipped_name);
      }
    }

    print(names);

    return names;
  }

  Future<List<String>> get_addon_names() async {

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getAddonNames');
    final addon_name_query = await callable();
    List result = addon_name_query.data;
    List<String> names = [];

    for (int i = 0; i < result.length; i++) {
      names.add(result[i]['menu_item']);
    }

    print(names);

    return names;
  }

  Future<List<String>> get_snack_names() async {

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getSnackNames');
    final snack_name_query = await callable();
    List result = snack_name_query.data;
    List<String> names = [];

    for (int i = 0; i < result.length; i++) {
      names.add(result[i]['menu_item']);
    }

    print(names);

    return names;
  }
}