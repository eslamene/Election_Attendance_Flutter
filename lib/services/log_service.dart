class LogService {
  static final LogService _instance = LogService._internal();
  factory LogService() => _instance;
  LogService._internal();

  final List<String> _logs = [];

  void logScanAttempt(String userId) {
    _logs.add('Scan attempt: $userId at ${DateTime.now()}');
  }

  void logConfirmation(String userId, String modeId) {
    _logs.add('Confirmed: $userId, mode: $modeId at ${DateTime.now()}');
  }

  List<String> getLogs() => List.unmodifiable(_logs);
} 