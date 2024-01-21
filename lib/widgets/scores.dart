import 'package:flutter/material.dart';

Widget scores(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(40.0),
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 26.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.0),
      ),
      child: Column(
        children: [
          Text(title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
              height: 4.0,
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ]
      )
    )
  );
}