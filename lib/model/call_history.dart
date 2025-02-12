class CallHistoryEntry {
  final String name;
  final String number;
  final DateTime timestamp;
  final CallType type;

  CallHistoryEntry({
    required this.name,
    required this.number,
    required this.timestamp,
    required this.type,
  });
}

enum CallType {
  incoming,
  outgoing,
  missed
}