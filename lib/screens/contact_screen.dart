import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../theme/theme_controller.dart';
import 'add_contact_screen.dart';
import '../model/contact.dart';
import 'contact_detail_screen.dart';

class ContactsScreen extends StatelessWidget {
  final ContactsController contactsController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone'),
        backgroundColor:
            themeController.isDarkMode ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.to(() => AddContactScreen()),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              onChanged: (value) {
                contactsController.searchContacts(value);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: contactsController.filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = contactsController.filteredContacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        contact.displayName.isNotEmpty
                            ? contact.displayName[0]
                            : '',

                      ),
                    ),
                    title: Text(contact.displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(contact.phoneNumber!),
                    onTap: () {
                      Get.to(() => ContactDetailScreen(contact: contact));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
