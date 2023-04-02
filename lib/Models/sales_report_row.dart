part of models_library;

class sales_report_row
{
  // All of the variables that will be displayed on the table that comes up when you run a sales report
  String type = "";
  int id = 0;
  String item_name = "";
  int amount_sold = 0;
  double total_revenue = 0;

  // Constructor
  sales_report_row(String type, int id, String item_name, int amount_sold, double total_revenue)
  {
    this.type = type;
    this.id = id;
    this.item_name = item_name;
    this.amount_sold = amount_sold;
    this.total_revenue = total_revenue;
  }
}