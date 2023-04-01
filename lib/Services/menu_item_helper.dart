import '../Models/menu_item_obj.dart';
import 'package:cloud_functions/cloud_functions.dart';

class menu_item_helper
{

  Future<void> add_menu_item(menu_item_obj new_item) async
  {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addMenuItem');
    String values = new_item.get_values();
    final result = await callable.call({'values':  values});

    print(result);

  }
}
