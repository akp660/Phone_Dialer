import 'package:get/get.dart';
import '../model/call_history.dart';

class CallController extends GetxController {
  final RxList<CallHistoryEntry> callHistory = <CallHistoryEntry>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockCallHistory();
  }

  void loadMockCallHistory() {
    callHistory.value = [
      CallHistoryEntry(
        name: "John Doe",
        number: "+1234567890",
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        type: CallType.incoming,
      ),
      CallHistoryEntry(
        name: "Jane Smith",
        number: "+1987654321",
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        type: CallType.outgoing,
      ),
      CallHistoryEntry(
        name: "Alice Johnson",
        number: "+1122334455",
        timestamp: DateTime.now().subtract(Duration(hours: 5)),
        type: CallType.missed,
      ),
    ];
  }

  void addCall(String name, String number, CallType type) {
    callHistory.insert(
      0,
      CallHistoryEntry(
        name: name,
        number: number,
        timestamp: DateTime.now(),
        type: type,
      ),
    );
  }
}