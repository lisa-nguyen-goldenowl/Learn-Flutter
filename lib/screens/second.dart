import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class SecondScreen extends StatelessWidget {
  final list = Get.arguments ?? [];

  @override
  Widget build(BuildContext context) {
    debugPrint('arguments: $list');
    return Scaffold(
        appBar: AppBar(
            title: Text('List Saved',
                style: TextStyle(fontSize: 18, color: Colors.white))),
        body: ListView.builder(itemBuilder: (context, i) {
          return _buildRow(list.toList()[i]);
        }));
  }

  Widget _buildRow(String text) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListTile(
          title: Text(text, style: TextStyle(fontSize: 20.0)),
        ));
  }
}
