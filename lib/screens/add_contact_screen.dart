import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';

class AddContactScreen extends StatelessWidget {
  final ContactsController contactsController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.blueAccent,
                ),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: numberController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.call,
                  color: Colors.blueAccent,
                ),
                labelText: 'Phone',
              ),
              keyboardType: TextInputType.phone,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            numberController.text.isNotEmpty) {
                          contactsController.addContact(
                              nameController.text, numberController.text);
                          Get.back();
                        } else {
                          Get.snackbar('Error', 'Please fill in all fields');
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
