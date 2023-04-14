import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuTile {
  Widget buildTile(String name, Color bgcolor) {
    return Container(
      decoration: BoxDecoration(
          color: bgcolor, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
