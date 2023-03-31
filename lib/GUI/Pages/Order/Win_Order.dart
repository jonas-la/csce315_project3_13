import 'package:flutter/material.dart';


class Win_Order extends StatefulWidget {
  static const String route = '/order';
  const Win_Order({super.key});

  @override
  State<Win_Order> createState() => Win_Order_State();
}

class Win_Order_State extends State<Win_Order> {
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
          children: [
            Expanded(
                child: Container(
                  color: Colors.yellow,
                )
            ),
            Expanded(
                child: Container(
                  color: Colors.red,
                )
            ),
        ]
      )
    );
  }
}
