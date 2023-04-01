class inventory_item_obj
{
  // All variables match the inventory SQL table
  int inv_order_id = 0;
  int inv_item_id = 0;
  String ingredient = "";
  int amount_inv_stock = 0;
  int amount_ordered = 0;
  String unit = "";
  String date_ordered = "";
  String expiration_date = "";
  int conversion = 0;

  // Constructor
  inventory_item_obj(int inv_order_id, int inv_item_id, String ingredient, int amount_inv_stock, int amount_ordered, String unit, String date_ordered, String expiration_date, int conversion)
  {
    this.inv_order_id = inv_order_id;
    this.inv_item_id = inv_item_id;
    this.ingredient = ingredient;
    this.amount_inv_stock = amount_inv_stock;
    this.amount_ordered = amount_ordered;
    this.unit = unit;
    this.date_ordered = date_ordered;
    this.expiration_date = expiration_date;
    this.conversion = conversion;
  }

  // Returns a comma-separated list of all the fields of the object, should be used when using VALUES() in SQL commands
  String get_values()
  {
    return "${this.inv_order_id}, ${this.inv_item_id}, '${this.ingredient}', ${this.amount_inv_stock}, ${this.amount_ordered}, '${this.unit}', '${this.date_ordered}', '${this.expiration_date}', ${this.conversion}";
  }
}