import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realtime/creat_bottom_sheet.dart';
import 'package:realtime/update_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final dataBaseReference = FirebaseDatabase.instance.ref("StoreData");
var uuid = const Uuid();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Real Time DataBase'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: dataBaseReference,
              itemBuilder: (context, snapshot, animat, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        snapshot.child('name').value.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(snapshot.child('addres').value.toString()),
                      leading: CircleAvatar(
                          child: Text(snapshot.child('sn').value.toString())),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                upDateBottomSheet(
                                  context,
                                  snapshot.child('name').value.toString(),
                                  snapshot.child('id').value.toString(),
                                  snapshot.child('sn').value.toString(),
                                  snapshot.child('addres').value.toString(),
                                );
                              },
                              leading: const Icon(Icons.edit),
                              title: const Text("Edit"),
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                dataBaseReference
                                    .child(
                                        snapshot.child('id').value.toString())
                                    .remove();
                              },
                              leading: const Icon(Icons.delete),
                              title: const Text("Delete"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          creatBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
