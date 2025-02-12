import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/call_controller.dart';
import '../controllers/contact_controller.dart';
import '../model/call_history.dart';
import '../model/contact.dart';
import '../theme/theme_controller.dart';
import 'calling_screen.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;
  final ContactsController contactsController = Get.find();
  final ThemeController themeController = Get.put(ThemeController());
  final CallController callController = Get.find();

  ContactDetailScreen({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: themeController.isDarkMode
                      ? Colors.black
                      : Colors.white, //Theme.of(context).primaryColor,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      child: Text(
                        contact.displayName[0],
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          contact.displayName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mobile ${contact.phoneNumber}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.call,
                        label: 'Call',
                        color: Colors.green,
                        onTap: () => _makeCall(contact.phoneNumber!),
                      ),
                      _buildActionButton(
                        icon: Icons.message,
                        label: 'Message',
                        color: Colors.blue,
                        onTap: () {},
                      ),
                      _buildActionButton(
                        icon: Icons.video_call,
                        label: 'Meet',
                        color: Colors.purple,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  ListTile(
                    title: Text('History'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Storage locations'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
        ],
        onTap: (index) => _handleBottomNavTap(index, context),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }

  void _handleBottomNavTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        // contactsController.toggleFavorite(contact.id);
        break;

      case 1:
        _showDeleteDialog(context);
        break;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Contact'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              contactsController.removeContact(contact.id);
              Navigator.pop(context);
              Get.back();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _makeCall(String number) {
    callController.addCall(contact.displayName, number, CallType.outgoing);

    Get.to(() => CallingScreen(
          name: contact.displayName,
          number: number,
        ));
  }
}
