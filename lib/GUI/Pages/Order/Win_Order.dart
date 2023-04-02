import 'package:flutter/material.dart';
import 'smoothie_order.dart';

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

  double total_cost = 0.00;
  TextEditingController customer = TextEditingController();
  String curr_customer = 'None';
  smoothie_order curr_smoothie = smoothie_order(smoothie: 'ERROR', Size: 'ERROR');

  // data displayed on table
  final List<Map<String, dynamic>> _orderTable = [];
  final List<Map<String, dynamic>> _addonTable = [];

  // adds row to table
  void _addToOrder(String item, String size, double price) {
    final newRow = {
      'index': _orderTable.length + 1,
      'name': item,
      'size': size,
      'price': price,
    };
    setState(() {
      _orderTable.add(newRow);
    });
  }

  void _addAddon(String item, double price) {
    final newRow = {
      'index': _addonTable.length + 1,
      'name': item,
      'price': price,
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
                  curr_customer = customer.text;
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
                                            _orderTable.removeAt(rowIndex);
                                          });
                                        },
                                      ),
                                    ),
                                    // Todo: disable edit button for snacks
                                    DataCell(
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          setState(() {
                                          // Todo: readd to order
                                          Map<String, dynamic> item = _orderTable.elementAt(rowIndex);
                                          curr_smoothie = smoothie_order(smoothie: item['name'], Size: item['size']);
                                   //        _orderTable.removeAt(rowIndex);
                                          _activetable = 1;
                                          _activeMenu2 = 1;
                                   //       List<String> addons = curr_smoothie.getAddons();
                                    //     for(int i = 0; i < addons.length; ++i){
                                            // Todo: get addon price (possibly within an Addon class)
                                    //        _addAddon(addons.elementAt(i), 0.99);
                                    //      }
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
                                            _orderTable.removeAt(rowIndex);
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
                              // todo handle customer stuff
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
                                    '$curr_customer',
                                  )
                                ],
                              ),
                            ),
                        ),
                        Expanded(
                          child: Text(
                              "Total: " + total_cost.toStringAsFixed(2),
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
                              print("Process Order");
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
                                                  curr_smoothie = smoothie_order(smoothie: name, Size: 'medium');
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
                                            _addToOrder(name, '-', 12.99);
                                            print(name);
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
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          setState(() {
                                            if (curr_smoothie.getSize() == 'medium'){
                                              curr_smoothie.setSmoothieSize('large');
                                            }
                                            else if (curr_smoothie.getSize() == 'small'){
                                              curr_smoothie.setSmoothieSize('medium');
                                            }
                                            else if (curr_smoothie.getSize() == 'large'){
                                              curr_smoothie.setSmoothieSize('small');
                                            }
                                          });
                                          },
                                        child: Icon(Icons.arrow_drop_up)
                                    ),
                                    Center(
                                        child: Text(
                                        curr_smoothie.getSmoothie(),
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.redAccent,
                                          ),
                                        )
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          setState(() {
                                            if (curr_smoothie.getSize() == 'medium'){
                                              curr_smoothie.setSmoothieSize('small');
                                            }
                                            else if (curr_smoothie.getSize() == 'small'){
                                              curr_smoothie.setSmoothieSize('large');
                                            }
                                            else if (curr_smoothie.getSize() == 'large'){
                                              curr_smoothie.setSmoothieSize('medium');
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
                                          _addToOrder(curr_smoothie.getName(), curr_smoothie.getSize(), 0.99);
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
                                        curr_smoothie.addAddon(name);
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