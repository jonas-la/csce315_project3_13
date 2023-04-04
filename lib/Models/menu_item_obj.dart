part of models_library;

class menu_item_obj
{
  // Variables match SQL table menu_items
  int menu_item_id = 0;
  String menu_item = "";
  double item_price = 0;
  int amount_in_stock = 0;
  String type = "";
  String status = "";
  List<String> ingredients = <String>[];

  // Constructor
  menu_item_obj(int menu_item_id, String menu_item, double item_price, int amount_in_stock, String type, String status, List<String> ingredients)
  {
    this.menu_item_id = menu_item_id;
    this.menu_item = menu_item;
    this.item_price = item_price;
    this.amount_in_stock = amount_in_stock;
    this.type = type;
    this.status = status;
    this.ingredients = ingredients;
  }

  // Returns a comma-separated list of all the fields of the object, should be used when using VALUES() in SQL commands
  String get_values()
  {
    return "${this.menu_item_id}, '${this.menu_item}', ${this.item_price}, ${this.amount_in_stock}, '${this.type}', '${this.status}'";
  }
}