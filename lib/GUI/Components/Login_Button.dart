import 'package:csce315_project3_13/Constants/constants.dart';
import 'package:flutter/material.dart';

Widget Login_Button({required VoidCallback onTap, required String buttonName,Color textColor = Colors.white, double fontSize = 24.0, double buttonWidth = 130}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        height: 40,
        width: 130,
        decoration: BoxDecoration(
          color: k_active_color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Center(child: Text(buttonName,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),

              )),
              Center(
                child: InkWell(
                  onTap: onTap,
                ),
              ),

            ],
          ),
        )),
  );
}