import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ExampleButton({required VoidCallback onTap, String buttonName = ""}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
      ),
        child: Center(
          child: Stack(
            children: [
              Center(child: Text(buttonName)),
              Center(
                child: InkWell(
                onTap: (){
                  print("Tapped once");
                },
                  onDoubleTap: onTap,
            ),
              ),

            ],
          ),
        )),
  );
}