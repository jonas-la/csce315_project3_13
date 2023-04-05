part of models_library;

class ingredient_obj
{
  // All variables match from the ingredients_table in the database
  int row_id = 0;
  String menu_item_name = "";
  String ingredient_name = "";
  int ingredient_amount = 0;

  // Constructor
  ingredient_obj(int row_id, String menu_item_name, String ingredient_name, int ingredient_amount)
  {
    this.row_id = row_id;
    this.menu_item_name = menu_item_name;
    this.ingredient_name = ingredient_name;
    this.ingredient_amount = ingredient_amount;
  }

  // Returns a comma-separated list of all the fields of the object, should be used when using VALUES() in SQL commands
  String get_values()
  {
    return "${this.row_id}, '${this.menu_item_name}', '${this.ingredient_name}', ${this.ingredient_amount}";
  }
}