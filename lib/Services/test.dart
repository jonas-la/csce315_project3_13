
import '../Helpers/menu_item_obj.dart';
import 'menu_item_helper.dart';

void main()
{
  menu_item_helper helper = menu_item_helper();
  menu_item_obj menu_item = menu_item_obj(500, "dart test item", 50, 100, "dart item");
  helper.add_menu_item(menu_item);
}