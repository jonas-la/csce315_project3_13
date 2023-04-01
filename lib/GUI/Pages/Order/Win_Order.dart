import 'package:flutter/material.dart';


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
  final List<String> Addon_names = ['addon1', 'addon2', 'addon3', 'addon4',
    'addon5', 'addon6', 'addon7','addon8', 'addon9', 'addon10', 'addon11',
    'addon12', 'addon13', 'addon14', 'addon15', 'addon16', 'addon17', 'addon18',];

  int _activeMenu = 0;
  int _activeMenu2 = 0;

  final List<Map<String, dynamic>> _tableData = [];

  void _addRow() {
    final name = 'An Item';
    final price = double.tryParse('2.99') ?? 0.0;
    final index = _tableData.length + 1;
    final newRow = {
      'index': index,
      'name': name,
      'price': price,
    };
    setState(() {
      _tableData.add(newRow);
    });
  }


  @override
  Widget build(BuildContext context) {
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
              child:  Container(
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
                        DataColumn(label: Text('Edit')),
                      ],
                      rows: _tableData.map((rowData) {
                        final rowIndex = _tableData.indexOf(rowData);
                        return DataRow(cells: [
                          DataCell(Text('${rowData['index']}')),
                          DataCell(Text('${rowData['name']}')),
                          DataCell(Text('${rowData['price']}')),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _tableData.removeAt(rowIndex);
                                });
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.edit_attributes_sharp),
                              onPressed: () {
                                print('Edit item');
                              },
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ],
                ),
              ),
             // child: Container(
             //   color: Colors.yellow,
             //   // Todo: add table functionality
             // ),
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
                                    child: Text("Snacks")
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
                                        crossAxisCount: 3,
                                        padding: EdgeInsets.all(10),
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        children: Smoothie_names
                                        // Todo: create custom button class
                                            .map((name) => ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _activeMenu2 = 1;
                                                });
                                              },
                                              child: Text(
                                                  name,
                                                style: TextStyle(fontSize: 24,),
                                                textAlign: TextAlign.center,
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
                                        crossAxisCount: 3,
                                        padding: EdgeInsets.all(10),
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        children: Snack_names
                                        // Todo: create custom button class
                                            .map((name) => ElevatedButton(
                                          onPressed: () {
                                            _addRow();
                                            print(name);
                                          },
                                          child: Text(
                                            name,
                                            style: TextStyle(fontSize: 24,),
                                            textAlign: TextAlign.center,
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
                                child: ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      _activeMenu2 = 0;
                                    });
                                  },
                                  child: Text("Back Button"),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        _activeMenu2 = 0;
                                      });
                                    },
                                    child: Text("Add to Order")
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
                                  crossAxisCount: 3,
                                  padding: EdgeInsets.all(10),
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  children: Addon_names
                                  // Todo: create custom button class
                                      .map((name) => ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _activeMenu2 = 0;
                                      });
                                    },
                                    child: Text(
                                      name,
                                      style: TextStyle(fontSize: 24,),
                                      textAlign: TextAlign.center,
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