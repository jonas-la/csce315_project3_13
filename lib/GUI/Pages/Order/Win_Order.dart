import 'package:flutter/material.dart';
import '../../../Services/view_helper.dart';
import '../Login/Win_Login.dart';
import 'smoothie_order.dart';
import 'curr_order.dart';
import 'addon_order.dart';
import 'snack_order.dart';

class Win_Order extends StatefulWidget {
  static const String route = '/order';
  Win_Order({super.key});

  @override
  State<Win_Order> createState() => Win_Order_State();
}

class Win_Order_State extends State<Win_Order> with AutomaticKeepAliveClientMixin {
  // Todo: get smoothie names from database
  final Future<List<String>> Smoothie_names = view_helper().get_unique_smoothie_names();
  // Todo: get snack names from database
  final Future<List<String>> Snack_names = view_helper().get_snack_names();
  // Todo" get addon names from database
  final Future<List<String>> Addon_names = view_helper().get_addon_names();

  // controls visibility between smoothies and snacks menu
  int _activeMenu = 0;

  //control visibility of addons menu
  int _activeMenu2 = 0;

  // controls visibility of table (order or addon)
  int _active_table = 0;


  TextEditingController customer = TextEditingController();
  String _curr_customer = 'None';
  smoothie_order _curr_smoothie = smoothie_order(smoothie: 'ERROR', Size: 'ERROR', price: 0, table_index: 0);
  curr_order _current_order = curr_order();
  bool _curr_editing = false;

  // data displayed on tables
  final List<Map<String, String>> _orderTable = [];
  final List<Map<String, String>> _addonTable = [];

  // adds row to order table
  void _addToOrder(String item, String size, double price) {
    final newRow = {
      'index': (_orderTable.length + 1).toString(),
      'name': item,
      'size': size,
      'price': price.toStringAsFixed(2),
    };
    setState(() {
      _orderTable.add(newRow);
    });
  }

  // add addon to addon table
  void _addAddon(String item, double price) {
    final newRow = {
      'index': (_addonTable.length + 1).toString(),
      'name': item,
      'price': price.toStringAsFixed(2),
    };
    setState(() {
      // limit addons to 8
      if (_addonTable.length < 8) {
        _addonTable.add(newRow);
      }
    });
  }

  // creates a popup asking for user info (currently, just the name)
  void customerInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Customer Information'),
          content: TextFormField(
            controller: customer,
            decoration: const InputDecoration(hintText: 'Type here...'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _curr_customer = customer.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget buttonGrid(BuildContext context, Future<List<String>> button_names, String type){
    return FutureBuilder<List<String>>(
      future: button_names,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<String> smoothieNames = snapshot.data!;
          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            padding: const EdgeInsets.all(10),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: smoothieNames.map((name) => ElevatedButton(
              onPressed: () {
                if (type == "Smoothie" ) {
                setState(() {
                  //Todo: get price of medium smoothie
                  double med_price = 5.59;
                  _curr_smoothie = smoothie_order(smoothie: name,
                    Size: 'medium', price: med_price,
                    table_index: _orderTable.length + 1,
                  );
                  _activeMenu2 = 1;
                  _active_table = 1;
                });
                }
                if (type == 'Snack') {
                  // todo: get price of snack using name
                  double snack_price = 1.99;
                  snack_order snack = snack_order(
                    name: name,
                    price: snack_price,
                    table_index: _orderTable.length + 1,
                  );
                  _addToOrder(name, '-', snack_price);
                  setState(() {
                    _current_order.addSnack(snack);
                  });
                  if (type == 'Addon'){
                    setState(() {
                      // Todo: get addon price
                      double addon_price = 0.99;
                      addon_order new_addon = addon_order(name: name, price: addon_price, amount: 1);
                      _curr_smoothie.addAddon(new_addon);
                      // Todo: get addon price
                      _addAddon(name, 0.99);
                    });
                  }
                }

              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 22,),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )).toList(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor: Colors.white,
          title: SizedBox(
            height: 80,
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
            ),
          ),
          centerTitle: true,
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              child:  Column(
                children: <Widget>[
                  Stack(
                    children: [
                      // Order table
                      Visibility(
                        visible: _active_table == 0,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              DataTable(
                                columnSpacing: 0,
                                columns: const [
                                  DataColumn(label: Text('Index'),),
                                  DataColumn(label: Text('Name'),),
                                  DataColumn(label: Text('Size')),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Edit')),
                                  DataColumn(label: Text('Delete')),
                                ],
                                rows: _orderTable.map((rowData) {
                                  final rowIndex = _orderTable.indexOf(rowData);
                                  return DataRow(cells: [
                                    DataCell(Text('${rowData['index']}')),
                                    DataCell(Text('${rowData['name']}')),
                                    DataCell(Text('${rowData['size']}')),
                                    DataCell(Text('${rowData['price']}')),
                                    DataCell(
                                      rowData['size'] != '-' ? IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          if (rowData['size'] != '-') {
                                            setState(() {
                                              Map<String,
                                                  dynamic> item = _orderTable
                                                  .elementAt(rowIndex);
                                              _orderTable.removeAt(rowIndex);
                                              _curr_smoothie =
                                                  _current_order.remove(
                                                      int.parse(item['index']));
                                              _active_table = 1;
                                              _activeMenu2 = 1;
                                              _addonTable.clear();
                                              for (addon_order addon in _curr_smoothie
                                                  .getAddons()) {
                                                _addAddon(
                                                    addon.name, addon.price);
                                              }
                                              _curr_editing = true;
                                            });
                                          }
                                        },
                                      ) : Container(),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            Map<String, dynamic> item = _orderTable.elementAt(rowIndex);
                                            // Todo: find a more efficient way to change indexes
                                            _current_order.remove(int.parse(item['index']));
                                            _orderTable.removeAt(rowIndex);
                                            _current_order.reorderIndexes(rowIndex + 1);
                                            for (int i = rowIndex; i < _orderTable.length; i++) {
                                              _orderTable[i]['index'] = (i + 1).toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Addon table, appears when adding or editing smoothie in order
                      Visibility(
                        visible: _active_table == 1,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              DataTable(
                                columnSpacing: 0,
                                columns: const [
                                  DataColumn(label: Text('Index'),),
                                  DataColumn(label: Text('Name'),),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Delete')),
                                ],
                                rows: _addonTable.map((rowData) {
                                  final rowIndex = _addonTable.indexOf(rowData);
                                  return DataRow(cells: [
                                    // Todo: add amount column
                                    DataCell(Text('${rowData['index']}')),
                                    DataCell(Text('${rowData['name']}')),
                                    DataCell(Text('${rowData['price']}')),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            _addonTable.removeAt(rowIndex);
                                            _curr_smoothie.removeAddon(rowIndex);
                                            for (int i = rowIndex; i < _addonTable.length; i++) {
                                              _addonTable[i]['index'] = (i + 1).toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox(height: 1,),),
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              customerInfo();
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 75,
                                ),
                                Text(
                                  '$_curr_customer',
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Total: ${_current_order.price.toStringAsFixed(2)}',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              print("Logged Out");
                              Navigator.pushReplacementNamed(context, Win_Login.route);
                            },
                            child: const Icon(
                              Icons.logout,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _current_order.clear();
                                _orderTable.clear();
                              });
                              print("Cancel Order");
                            },
                            child: const Icon(
                              Icons.cancel_outlined,
                            ),
                          ),
                        ),
                        // Todo: Process order
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              List<smoothie_order> smoothies= _current_order.getSmoothies();
                              List<snack_order> snacks = _current_order.getSnacks();
                              //todo: process order
                              print("Snacks purchased:  ");
                              for (snack_order snack in snacks)
                              {
                                print("   ${snack.name}");
                              }
                              print("Smoothies purchased: ");
                              for (smoothie_order smoothie in smoothies)
                              {
                                print("   ${smoothie.getSmoothie()}");
                                List<addon_order> addons = smoothie.getAddons();
                                print("    With Addons: ");
                                for (addon_order addon in addons)
                                {
                                  print("        " + addon.name);
                                }
                              }
                            },
                            child: const Icon(
                              Icons.monetization_on,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Navigation between smoothie and snack button grids
            Expanded(
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: _activeMenu2 == 0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      _activeMenu = 0;
                                    });
                                  },
                                  child: const Text("Smoothies"),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      _activeMenu = 1;
                                    });
                                  },
                                  child: const Text("Snacks"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              // smoothie button grid
                              Visibility(
                                visible: _activeMenu == 0,
                                child: Scrollbar(
                                  thickness: 30,
                                  interactive: true,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    primary: true,
                                    child: Container(
                                      color: Colors.pink,
                                      child: buttonGrid(context, Smoothie_names, "Smoothie"),
                                    ),
                                  ),
                                ),
                              ),

                              // snack button grid
                              Visibility(
                                visible: _activeMenu == 1,
                                child: Scrollbar(
                                  thickness: 30,
                                  interactive: true,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    primary: true,
                                    child: Container(
                                      color: Colors.pink,
                                      child: buttonGrid(context, Snack_names, "Snacks"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _activeMenu2 == 1,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                  // back button is disabled when editing smoothie
                                  child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        // if currently editing, add smoothie back to order
                                        double smoothie_price = 5.59;
                                        _curr_smoothie.setSmoothiePrice(smoothie_price);

                                        // if currently editing smoothie, insert it to previous index
                                        if (_curr_editing)
                                        {
                                          Map<String, String> newRow = {
                                            'index': _curr_smoothie.table_index.toString(),
                                            'name': _curr_smoothie.smoothie,
                                            'size': _curr_smoothie.Size,
                                            'price': _curr_smoothie.getCost().toStringAsFixed(2),
                                          };
                                          _orderTable.insert(_curr_smoothie.table_index - 1, newRow);
                                          _current_order.addSmoothie(_curr_smoothie);
                                          _curr_editing = false;
                                        }

                                        _activeMenu2 = 0;
                                        _active_table = 0;
                                        _addonTable.clear();
                                      });
                                    },
                                    child: const Icon(Icons.arrow_back),
                                  ),
                                ),
                              ),

                              // widget used to cycle through smoothie sizes
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          setState(() {
                                            if (_curr_smoothie.getSize() == 'medium'){
                                              _curr_smoothie.setSmoothieSize('large');
                                            }
                                            else if (_curr_smoothie.getSize() == 'small'){
                                              _curr_smoothie.setSmoothieSize('medium');
                                            }
                                            else if (_curr_smoothie.getSize() == 'large'){
                                              _curr_smoothie.setSmoothieSize('small');
                                            }
                                          });
                                        },
                                        child: const Icon(Icons.arrow_drop_up)
                                    ),
                                    Text(
                                      _curr_smoothie.getSmoothie(),
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          setState(() {
                                            if (_curr_smoothie.getSize() == 'medium'){
                                              _curr_smoothie.setSmoothieSize('small');
                                            }
                                            else if (_curr_smoothie.getSize() == 'small'){
                                              _curr_smoothie.setSmoothieSize('large');
                                            }
                                            else if (_curr_smoothie.getSize() == 'large'){
                                              _curr_smoothie.setSmoothieSize('medium');
                                            }
                                          });
                                        },
                                        child: const Icon(Icons.arrow_drop_down)
                                    ),
                                  ],
                                ),
                              ),

                              // Adds smoothie with addons to order
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                  child: !_curr_editing ? ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          // Todo: get smoothie price using name
                                          double smoothie_price = 5.59;
                                          _curr_smoothie.setSmoothiePrice(smoothie_price);
                                          _addToOrder(
                                              _curr_smoothie.getName(),
                                              _curr_smoothie.getSize(),
                                              _curr_smoothie.getCost());
                                          _current_order.addSmoothie(
                                              _curr_smoothie);
                                          _activeMenu2 = 0;
                                          _active_table = 0;
                                          _addonTable.clear();
                                        });
                                      },
                                      child: const Text("Add to Order")
                                  ) : Container(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Addon table
                        Expanded(
                          child: Scrollbar(
                            thickness: 30,
                            interactive: true,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              primary: true,
                              child: Container(
                                color: Colors.pink,
                                child: buttonGrid(context, Addon_names, 'Addon')
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}