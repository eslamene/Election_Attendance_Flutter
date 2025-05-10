import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Attending the General Assembly of the Court of Cassation';

  @override
  String get attendanceModes => 'Attendance Modes';

  @override
  String get home => 'Main';

  @override
  String get scanQrBarcode => 'Scan QR/Barcode';

  @override
  String get confirmUser => 'Confirm User';

  @override
  String get settings => 'Settings';

  @override
  String get selectAttendanceMode => 'Select Attendance Mode';

  @override
  String get startScan => 'Start Scan';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get apiEndpointConfig => 'API endpoint config here.';

  @override
  String get scanError => 'Scan failed or invalid code.';

  @override
  String get userNotFound => 'User not found.';

  @override
  String get attendanceSuccess => 'Attendance confirmed!';

  @override
  String get attendanceFailed => 'Attendance failed. Please try again.';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get recentScans => 'Recent Scans';

  @override
  String get noScansYet => 'No scans yet';

  @override
  String get alreadyScanned => 'This user\'s attendance has already been recorded for this mode.';

  @override
  String get copyright => '© 2025 Elections';

  @override
  String get apiEndpoint => 'API Endpoint';

  @override
  String get saveApiEndpoint => 'Save API Endpoint';

  @override
  String currentApiEndpoint(Object endpoint) {
    return 'Current: $endpoint';
  }

  @override
  String get clearHistory => 'Clear History';
}
