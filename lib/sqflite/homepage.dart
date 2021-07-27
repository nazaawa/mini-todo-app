import 'package:flutter/material.dart';
import 'package:sqlfliteapp/sqflite/Datacart.dart';
import 'package:sqlfliteapp/sqflite/database.dart';

import 'package:sqlfliteapp/sqflite/datamodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  List<DataModel> datas = [];

  bool fetching = true;
  late DB db;

  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
  }

  void getData2() async {
    datas = await db.getData();

    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: fetching
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) => DataCard(data: datas[index]),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: showDialogue,
          child: Icon(Icons.add),
        ));
  }

  void showDialogue() async {
    return showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'title'),
                  ),
                  TextFormField(
                    controller: subtitleController,
                    decoration: InputDecoration(labelText: 'Subtitle'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    DataModel dataLocal = DataModel(
                        title: titleController.text,
                        subtitle: subtitleController.text);
                    db.insertData(dataLocal);
                    setState(() {
                      datas.add(dataLocal);
                    });

                    Navigator.pop(context);
                    titleController.clear();
                    subtitleController.clear();
                    print(titleController.text);
                  },
                  child: Text("Save"))
            ],
          );
        },
        context: context);
  }
}
