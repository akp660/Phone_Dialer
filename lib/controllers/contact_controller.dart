import 'package:get/get.dart';
import '../model/contact.dart';

class ContactsController extends GetxController {
  final RxList<Contact> contacts = <Contact>[].obs;
  final RxList<Contact> filteredContacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyContacts();
    filteredContacts.assignAll(contacts);
  }

  void loadDummyContacts() {
    contacts.addAll([
      Contact(id: '1', displayName: 'Abhijeet', phoneNumber: '+91 7255017217'),
    ]);
  }

  void addContact(String name, String number) {
    contacts.add(Contact(id: DateTime.now().toString(), displayName: name, phoneNumber: number));
    filteredContacts.assignAll(contacts);
  }

  void removeContact(String id) {
    contacts.removeWhere((contact) => contact.id == id);
    filteredContacts.assignAll(contacts);
  }

  void searchContacts(String query) {
    if (query.isEmpty) {
      filteredContacts.assignAll(contacts);
    } else {
      filteredContacts.assignAll(contacts.where((contact) =>
      contact.displayName.toLowerCase().contains(query.toLowerCase()) ||
          contact.phoneNumber!.contains(query)));
    }
  }
}