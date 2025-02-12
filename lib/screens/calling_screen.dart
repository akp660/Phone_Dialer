import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
import '../theme/theme_controller.dart';

class CallingScreen extends StatelessWidget {
  final ContactsController contactController = Get.put(ContactsController());
  final ThemeController themeController = Get.put(ThemeController());
  final RxBool isSpeakerOn = false.obs;
  final RxBool isMuted = false.obs;
  final RxBool isBluetoothOn = false.obs;
  final String name;
  final String number;

  CallingScreen({
    super.key,
    required this.name,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor:
              themeController.isDarkMode ? Colors.black : Colors.white,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: themeController.isDarkMode
                    ? [
                        Colors.purple.withOpacity(0.3),
                        Colors.blue.withOpacity(0.3),
                        Colors.black,
                      ]
                    : [
                        Colors.purple.withOpacity(0.1),
                        Colors.blue.withOpacity(0.1),
                        Colors.white,
                      ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => themeController.toggleTheme(),
                      color: themeController.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      icon: Icon(
                        themeController.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: themeController.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Text(
                    'Calling...',
                    style: TextStyle(
                      color: themeController.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    name ?? 'No Contact',
                    style: TextStyle(
                      color: themeController.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    number ?? 'No Number',
                    style: TextStyle(
                      color: themeController.isDarkMode
                          ? Colors.white70
                          : Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: themeController.isDarkMode
                          ? Colors.grey[900]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              icon: Icons.add_call,
                              label: 'Add call',
                              onTap: () {},
                            ),
                            _buildActionButton(
                              icon: Icons.videocam,
                              label: 'Video call',
                              onTap: () {},
                            ),
                            _buildActionButton(
                              icon: Icons.bluetooth,
                              label: 'Bluetooth',
                              onTap: () => isBluetoothOn.toggle(),
                              isActive: isBluetoothOn,
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              icon: Icons.volume_up,
                              label: 'Speaker',
                              onTap: () => isSpeakerOn.toggle(),
                              isActive: isSpeakerOn,
                            ),
                            _buildActionButton(
                              icon: Icons.mic_off,
                              label: 'Mute',
                              onTap: () => isMuted.toggle(),
                              isActive: isMuted,
                            ),
                            _buildActionButton(
                              icon: Icons.dialpad,
                              label: 'Keypad',
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              onPressed: () => Get.back(),
                              backgroundColor: Colors.red,
                              child: Icon(Icons.call_end, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    RxBool? isActive,
  }) {
    return Obx(() {
      final active = isActive?.value ?? false;
      return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: active
                    ? (themeController.isDarkMode ? Colors.white : Colors.black)
                    : (themeController.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[300]),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: active
                    ? (themeController.isDarkMode ? Colors.black : Colors.white)
                    : (themeController.isDarkMode
                        ? Colors.white
                        : Colors.black),
                size: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: active
                    ? (themeController.isDarkMode ? Colors.white : Colors.black)
                    : (themeController.isDarkMode
                        ? Colors.grey
                        : Colors.grey[600]),
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    });
  }
}
