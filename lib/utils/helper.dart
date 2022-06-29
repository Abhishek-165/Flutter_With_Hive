import 'package:databaseapp/models/person.dart';
import 'package:databaseapp/services/extension.dart';
import 'package:databaseapp/services/hive_provider.dart';
import 'package:flutter/material.dart';

TextEditingController nameController = TextEditingController();
TextEditingController ageController = TextEditingController();
showCustomModalSheet(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text("Add New Person",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(hintText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            ageController.text.isNotEmpty) {
                          Navigator.pop(context);
                          HiveProvider().getInstance().insert(Person(
                              nameController.text,
                              ageController.text.toIntParse()));
                          nameController.clear();
                          ageController.clear();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
