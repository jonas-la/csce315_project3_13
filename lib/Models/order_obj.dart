part of models_library;

class order_obj
{
  // All variables match the order_history table from the SQL database
  int transaction_id = 0;
  int order_taker_id = 0;
  List<int> item_ids_in_order = <int>[];
  double total_price = 0;
  String customer_name = "";
  String date_of_order = "";
  String status = "";

  // Constructor
  order_obj(int transaction_id, int order_taker_id, List<int> item_ids_in_order, double total_price, String customer_name, String date_of_order, String status)
  {
    this.transaction_id = transaction_id;
    this.order_taker_id = order_taker_id;
    this.item_ids_in_order = item_ids_in_order;
    this.total_price = total_price;
    this.customer_name = customer_name;
    this.date_of_order = date_of_order;
    this.status = status;
  }

  // Returns a comma-separated list of all the fields of the object, should be used when using VALUES() in SQL commands
  String get_values()
  {
    return "${this.transaction_id}, ${this.order_taker_id}, ${this.item_ids_in_order}, ${this.total_price}, '${this.customer_name}', '${this.date_of_order}', '${this.status}'";
  }
}