import 'package:flutter/material.dart';
import 'package:sqlfliteapp/sqflite/datamodel.dart';

class DataCard extends StatelessWidget {
  final DataModel data;

  const DataCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: IconButton(icon: Icon(Icons.edit), onPressed: () {  },)
          
          ),
        title: Text(data.title),
        subtitle: Text(data.subtitle),
        trailing: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.delete),
        ),
      ),
    );
  }
}
