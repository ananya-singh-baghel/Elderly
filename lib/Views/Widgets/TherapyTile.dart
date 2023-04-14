import 'package:code_silver/Models/searchResult.dart';
import 'package:flutter/material.dart';

class TherapyTile {
  Widget buildTile(SearchResult res, int index) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Text(res.results![index].name.toString(),
            style: TextStyle(color: Colors.green)),
        subtitle: Text(res.results![index].formattedAddress.toString()),
        isThreeLine: true,
      ),
    );
  }
}
