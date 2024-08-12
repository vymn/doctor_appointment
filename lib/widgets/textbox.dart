import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(50)
        ),
        child: const TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17)),
        ),
      );
  }
}