import '../Helpers/menu_item_obj.dart';
import 'package:cloud_functions/cloud_functions.dart';

class menu_item_helper
{
  late FirebaseFunctions my_functions;

  menu_item_helper()
  {
    my_functions = FirebaseFunctions.instance;
  }

  Future<void> add_menu_item(menu_item_obj new_item) async
  {
    final HttpsCallable callable = my_functions.httpsCallable('addMenuItem');
    await callable.call(<String, dynamic>{
      'values': new_item.get_values(),
    });
  }
}
