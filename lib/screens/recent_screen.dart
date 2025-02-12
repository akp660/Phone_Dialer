import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/call_controller.dart';
import '../model/call_history.dart';
import 'package:intl/intl.dart';
import 'calling_screen.dart';

class RecentsScreen extends StatelessWidget {
  final CallController callController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
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
      body: Obx(
        () => ListView.builder(
          itemCount: callController.callHistory.length,
          itemBuilder: (context, index) {
            final call = callController.callHistory[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: _getCallColor(call.type),
                child: Icon(
                  _getCallIcon(call.type),
                  color: Colors.white,
                ),
              ),
              title: Text(
                call.name == 'Unknown' ? call.number :call.name ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    _getCallDirectionIcon(call.type),
                    size: 16,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4),
                  Text(_formatDate(call.timestamp)),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.call),
                color: Theme.of(context).primaryColor,
                onPressed: () => _makeCall(call.name, call.number),
              ),
              onTap: () => _showCallDetails(context, call),
            );
          },
        ),
      ),
    );
  }

  IconData _getCallIcon(CallType type) {
    switch (type) {
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.incoming:
        return Icons.call_received;
      case CallType.missed:
        return Icons.call_missed;
    }
  }

  IconData _getCallDirectionIcon(CallType type) {
    switch (type) {
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.incoming:
        return Icons.call_received;
      case CallType.missed:
        return Icons.call_missed;
    }
  }

  Color _getCallColor(CallType type) {
    switch (type) {
      case CallType.outgoing:
        return Colors.green;
      case CallType.incoming:
        return Colors.blue;
      case CallType.missed:
        return Colors.red;
    }
  }

  String _formatDate(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final date = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (date == today) {
      return 'Today ${DateFormat('h:mm a').format(timestamp)}';
    } else if (date == yesterday) {
      return 'Yesterday ${DateFormat('h:mm a').format(timestamp)}';
    } else {
      return DateFormat('MMM d, h:mm a').format(timestamp);
    }
  }

  void _makeCall(String name, String number) {
    callController.addCall(name, number, CallType.outgoing);
    Get.to(() => CallingScreen(name: name, number: number));
  }

  void _showCallDetails(BuildContext context, CallHistoryEntry call) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(call.name),
              subtitle: Text(call.number),
              leading: CircleAvatar(
                child: Text(call.name[0]),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.call),
              title: Text('Call'),
              onTap: () {
                Navigator.pop(context);
                _makeCall(call.name, call.number);
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Send message'),
              onTap: () {
                // Implement message functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add to contacts'),
              onTap: () {
                // Implement add to contacts
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
