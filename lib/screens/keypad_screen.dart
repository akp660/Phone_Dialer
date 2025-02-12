import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/call_controller.dart';
import '../model/call_history.dart';
import '../theme/theme_controller.dart';
import 'calling_screen.dart';


class KeypadScreen extends StatelessWidget {
  final RxString number = ''.obs;
  final ThemeController themeController = Get.put(ThemeController());
  final CallController callController = Get.find();

  Widget _buildDialButton(String number, String letters) {
    return MaterialButton(
      onPressed: () => this.number.value += number,
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(fontSize: 24),
          ),
          Text(
            letters,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      // shape: CircleBorder(),
      // padding: EdgeInsets.all(5),
    );
  }

  void _makeCall() {
    if (number.value.isNotEmpty) {
      callController.addCall('Unknown', number.value, CallType.outgoing);
      Get.to(() => CallingScreen(name: 'Unknown', number: number.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => themeController.toggleTheme(),
                  color:
                      themeController.isDarkMode ? Colors.black : Colors.white,
                  icon: Icon(
                    themeController.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: themeController.isDarkMode
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(() => Text(
                          number.value,
                          style: TextStyle(fontSize: 36),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  IconButton(
                    icon: Icon(Icons.backspace),
                    onPressed: () {
                      if (number.value.isNotEmpty) {
                        number.value =
                            number.value.substring(0, number.value.length - 1);
                      }
                    },
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 2,
              children: [
                _buildDialButton('1', ''),
                _buildDialButton('2', 'ABC'),
                _buildDialButton('3', 'DEF'),
                _buildDialButton('4', 'GHI'),
                _buildDialButton('5', 'JKL'),
                _buildDialButton('6', 'MNO'),
                _buildDialButton('7', 'PQRS'),
                _buildDialButton('8', 'TUV'),
                _buildDialButton('9', 'WXYZ'),
                _buildDialButton('*', ''),
                _buildDialButton('0', '+'),
                _buildDialButton('#', ''),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child:
                  ElevatedButton(
                    onPressed: _makeCall,
                    child: Icon(Icons.call , color: Colors.white,),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.green,
                     ),

                  ),
              ),
          ],
        ),
      ),
    );
  }
}
