import 'package:flutter/material.dart';
import 'smoothie_order.dart';
import 'curr_order.dart';
import 'addon_order.dart';
import 'snack_order.dart';

class Win_Order extends StatefulWidget {
  static const String route = '/order';
  const Win_Order({super.key});

  @override
  State<Win_Order> createState() => Win_Order_State();
}

class Win_Order_State extends State<Win_Order> {
  // Todo: get smoothie names from database
  final List<String> Smoothie_names = ['smoothie1', 'smoothie2', 'smoothie3',
    'smoothie4', 'smoothie5', 'smoothie6', 'smoothie7', 'smoothie8', 'smoothie9',
    'smoothie10', 'smoothie11', 'smoothie12', 'smoothie13', 'smoothie14',
    'smoothie15','smoothie16', 'smoothie17', 'smoothie18', 'smoothie19',
    'smoothie20'];
  // Todo: get snack names from database
  final List<String> Snack_names = ['snacks1', 'snacks2', 'snacks3', 'snacks4',
    'snacks5', 'snacks6', 'snacks7', 'snacks8', 'snacks9', 'snacks10', 'snacks11',
    'snacks12', 'snacks13', 'snacks14', 'snacks15','snacks16', 'snacks17',
    'snacks18', 'snacks19', 'snacks20'];
  // Todo" get addon names from database
  final List<String> Addon_names = ['addon1', 'addon2', 'addon3', 'addon4',
    'addon5', 'addon6', 'addon7','addon8', 'addon9', 'addon10', 'addon11',
    'addon12', 'addon13', 'addon14', 'addon15', 'addon16', 'addon17', 'addon18',];

  // controls visibility between smoothies and snacks menu
  int _activeMenu = 0;

  //control visisbility of addons menu
  int _activeMenu2 = 0;

  // controls visibility of table (order or addon)
  int _activetable = 0;


  TextEditingController customer = TextEditingController();
  String _curr_customer = 'None';
  smoothie_order _curr_smoothie = smoothie_order(smoothie: 'ERROR', Size: 'ERROR', price: 0, table_index: 0);
  curr_order _current_order = curr_order();
  bool curr_editing = false;

  // data displayed on table
  final List<Map<String, dynamic>> _orderTable = [];
  final List<Map<String, dynamic>> _addonTable = [];

  // adds row to table
  void _addToOrder(String item, String size, double price) {
    final newRow = {
      'index': _orderTable.length + 1,
      'name': item,
      'size': size,
      'price': price.toStringAsFixed(2),
    };
    setState(() {
      _orderTable.add(newRow);
    });
  }

  void _addAddon(String item, double price) {
    final newRow = {
      'index': _addonTable.length + 1,
      'name': item,
      'price': price.toStringAsFixed(2),
    };
    setState(() {
      _addonTable.add(newRow);
    });
  }

  // creates a popip screen asking for user info (currently, just the name)
  void customerInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customer Information'),
          content: TextFormField(
            controller: customer,
            decoration: InputDecoration(hintText: 'Type here...'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
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
  Widget build(BuildContext context) {
    // half of the width of the current screen, used to align table
    final double width = MediaQuery.of(context).size.width / 2;
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
                      Visibility(
                        visible: _activetable == 0,
                        child: Container(
                          width: width,
                          alignment: Alignment.topCenter,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              DataTable(
                                columnSpacing: 0,
                                columns: [
                                  DataColumn(label: Text('Index'),),
                                  DataColumn(label: Text('Name'),),
                                  DataColumn(label: Text('Size')),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Delete')),
                                  DataColumn(label: Text('Edit')),
                                ],
                                rows: _orderTable.map((rowData) {
                                  final rowIndex = _orderTable.indexOf(rowData);
                                  return DataRow(cells: [
                                    DataCell(Text('${rowData['index']}')),
                                    DataCell(Text('${rowData['name']}')),
                                    DataCell(Text('${rowData['size']}')),
                                    DataCell(Text('${rowData['price']}')),
                                    DataCell(
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            Map<String, dynamic> item = _orderTable.elementAt(rowIndex);
                                            // Todo: find a more efficient way to change indexes
                                            _current_order.remove(item['index']);
                                            _orderTable.removeAt(rowIndex);
                                            for (int i = rowIndex; i < _orderTable.length; i++) {
                                              _orderTable[i]['index'] = i + 1;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    // Todo: disable edit button for snacks
                                    DataCell(
                                      rowData['size'] == '-' ? IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          if (rowData['size'] != '-') {
                                            setState(() {
                                              Map<String,
                                                  dynamic> item = _orderTable
                                                  .elementAt(rowIndex);
                                              _curr_smoothie =
                                                  _current_order.remove(
                                                      item['index']);
                                              _activetable = 1;
                                              _activeMenu2 = 1;
                                              _addonTable.clear();
                                              for (addon_order addon in _curr_smoothie
                                                  .getAddons()) {
                                                _addAddon(
                                                    addon.name, addon.price);
                                              }
                                            });
                                          }
                                        },
                                      ) : Container(),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _activetable == 1,
                        child: Container(
                          width: width,
                          alignment: Alignment.topCenter,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              DataTable(
                                columnSpacing: 0,
                                columns: [
                                  DataColumn(label: Text('Index'),),
                                  DataColumn(label: Text('Name'),),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Delete')),
                                ],
                                rows: _addonTable.map((rowData) {
                                  final rowIndex = _addonTable.indexOf(rowData);
                                  return DataRow(cells: [
                                    DataCell(Text('${rowData['index']}')),
                                    DataCell(Text('${rowData['name']}')),
                                    DataCell(Text('${rowData['price']}')),
                                    DataCell(
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            _addonTable.removeAt(rowIndex);
                                            _curr_smoothie.removeAddon(rowIndex);
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
                                  Icon(
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
                          child: Text(
                              'Total: ${_current_order.price.toStringAsFixed(2)}',
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
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.logout,
                              ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _orderTable.clear();
                              });
                              print("Cancel Order");
                            },
                            child: Icon(
                              Icons.cancel_outlined,
                            ),
                          ),
                        ),
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
                            child: Icon(
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
                                    child: Text("Smoothies"),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                    onPressed: (){
                                      setState(() {
                                        _activeMenu = 1;
                                      });
                                    },
                                    child: Text("Snacks"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
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
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: 4,
                                        padding: EdgeInsets.all(10),
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        children: Smoothie_names
                                        // Todo: create custom button class
                                            .map((name) => ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  //Todo: get price of medium smoothie
                                                  double med_price = 5.59;
                                                  _curr_smoothie = smoothie_order(smoothie: name,
                                                      Size: 'medium', price: med_price,
                                                      table_index: _orderTable.length + 1,
                                                  );
                                                  _activeMenu2 = 1;
                                                  _activetable = 1;
                                                });
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Expanded(child: SizedBox(height: 5,)),
                                                  Text(
                                                    name,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 25,),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Expanded(child: SizedBox(height: 5,)),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      // Todo: get price of item
                                                      5.59.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white30,
                                                        fontSize: 15,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )).toList(),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
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
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: 4,
                                        padding: EdgeInsets.all(10),
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        children: Snack_names
                                        // Todo: create custom button class
                                            .map((name) => ElevatedButton(
                                          onPressed: () {
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
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Expanded(child: SizedBox(height: 5,)),
                                              Text(
                                                name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 25,),
                                                textAlign: TextAlign.center,
                                              ),
                                              const Expanded(child: SizedBox(height: 5,)),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  // Todo: get price of item
                                                  3.99.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white30,
                                                    fontSize: 15,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              )
                                            ],
                                          ),
                                        )).toList(),
                                      ),
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
                                  child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        _activeMenu2 = 0;
                                        _activetable = 0;
                                        _addonTable.clear();
                                      });
                                    },
                                    child: Icon(Icons.arrow_back),
                                  ),
                                ),
                              ),
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
                                        child: Icon(Icons.arrow_drop_up)
                                    ),
                                    Text(
                                    _curr_smoothie.getSmoothie(),
                                      style: TextStyle(
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
                                        child: Icon(Icons.arrow_drop_down)
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          // Todo: get smoothie price
                                          double smoothie_price = 5.59;
                                          _curr_smoothie.setSmoothiePrice(smoothie_price);
                                          if (curr_editing)
                                            {
                                              Map<String, dynamic> newRow = {
                                                'index': _curr_smoothie.table_index,
                                                'name': _curr_smoothie.smoothie,
                                                'size': _curr_smoothie.Size,
                                                'price': _curr_smoothie.getCost(),
                                              };
                                              _addonTable.insert(_curr_smoothie.table_index - 1, {newRow} as Map<String, dynamic>);
                                            }
                                          else {
                                            _addToOrder(
                                                _curr_smoothie.getName(),
                                                _curr_smoothie.getSize(),
                                                _curr_smoothie.getCost());
                                            _current_order.addSmoothie(
                                                _curr_smoothie);
                                          }
                                          _activeMenu2 = 0;
                                          _activetable = 0;
                                          _addonTable.clear();
                                        });
                                      },
                                      child: Text("Add to Order")
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            thickness: 30,
                            interactive: true,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              primary: true,
                              child: Container(
                                color: Colors.pink,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 4,
                                  padding: EdgeInsets.all(10),
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  children: Addon_names
                                  // Todo: create custom button class
                                      .map((name) => ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        // Todo: get addon price
                                        double addon_price = 0.99;
                                        addon_order new_addon = addon_order(name: name, price: addon_price, amount: 1);
                                        _curr_smoothie.addAddon(new_addon);
                                        // Todo: get addon price
                                        _addAddon(name, 0.99);
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(child: SizedBox(height: 5,)),
                                        Text(
                                          name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 25,),
                                          textAlign: TextAlign.center,
                                        ),
                                        Expanded(child: SizedBox(height: 5,)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            // Todo: get price of item
                                            3.99.toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      ],
                                    ),
                                  )).toList(),
                                ),
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