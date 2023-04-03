import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Win_Loading_Page extends StatefulWidget {
  static const String route = '/loading';
  const Win_Loading_Page({Key? key}) : super(key: key);

  @override
  State<Win_Loading_Page> createState() => _Win_Loading_PageState();
}

class _Win_Loading_PageState extends State<Win_Loading_Page> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading..."),
      ),
      body: Container(
        child: Center(
          child: const SpinKitRing(color: Colors.red),
        ),
      ),
    );
  }
}
