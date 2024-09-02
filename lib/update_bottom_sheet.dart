import 'package:flutter/material.dart';
import 'package:realtime/home_page.dart';

TextEditingController nameController = TextEditingController();
TextEditingController snController = TextEditingController();
TextEditingController addresController = TextEditingController();
void upDateBottomSheet(BuildContext context, name, id, sn, addres) {
  nameController.text = name;
  snController.text = sn;
  addresController.text = addres;
  showModalBottomSheet(
    backgroundColor: Colors.blue[100],
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Edit Your DataBase",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: snController,
                decoration: const InputDecoration(
                  labelText: "S.N",
                ),
              ),
              TextField(
                controller: addresController,
                decoration: const InputDecoration(
                  labelText: "Addres",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  dataBaseReference.child(id).update({
                    'name': nameController.text.toString(),
                    'sn': snController.text.toString(),
                    'addres': addresController.text.toString(),
                  });

                  Navigator.of(context).pop();
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
