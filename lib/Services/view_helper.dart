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