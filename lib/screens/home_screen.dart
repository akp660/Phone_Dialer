import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/recent_screen.dart';

import 'contact_screen.dart';
import 'keypad_screen.dart';


class HomeScreen extends StatelessWidget {
  final RxInt currentIndex = 0.obs;

  final screens = [
    KeypadScreen(),
    RecentsScreen(),
    ContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[currentIndex.value]),
      bottomNavigationBar: Obx(
            () => NavigationBar(
          selectedIndex: currentIndex.value,
          onDestinationSelected: (index) => currentIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dialpad),
              label: 'Keypad',
            ),
            NavigationDestination(
              icon: Icon(Icons.access_time),
              label: 'Recents',
            ),
            NavigationDestination(
              icon: Icon(Icons.contacts),
              label: 'Contacts',
            ),
          ],
        ),
      ),
    );
  }
}