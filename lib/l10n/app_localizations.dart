import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'appTitle': 'Judges Election Attendance',
      'attendanceModes': 'Attendance Modes',
      'scanQrBarcode': 'Scan QR/Barcode',
      'confirmUser': 'Confirm User',
      'settings': 'Settings',
      'selectAttendanceMode': 'Select Attendance Mode',
      'startScan': 'Start Scan',
      'confirm': 'Confirm',
      'cancel': 'Cancel',
      'apiEndpointConfig': 'API endpoint config here.',
      'scanError': 'Scan failed or invalid code.',
      'userNotFound': 'User not found.',
      'attendanceSuccess': 'Attendance confirmed!',
      'attendanceFailed': 'Attendance failed. Please try again.',
      'changeLanguage': 'Change Language',
    },
    'ar': {
      'appTitle': 'تسجيل الحضور للوكيل',
      'attendanceModes': 'أنماط الحضور',
      'scanQrBarcode': 'مسح رمز QR/باركود',
      'confirmUser': 'تأكيد المستخدم',
      'settings': 'الإعدادات',
      'selectAttendanceMode': 'اختر نمط الحضور',
      'startScan': 'بدء المسح',
      'confirm': 'تأكيد',
      'cancel': 'إلغاء',
      'apiEndpointConfig': 'إعداد نقطة نهاية API هنا.',
      'scanError': 'فشل المسح أو رمز غير صالح.',
      'userNotFound': 'المستخدم غير موجود.',
      'attendanceSuccess': 'تم تأكيد الحضور!',
      'attendanceFailed': 'فشل تأكيد الحضور. حاول مرة أخرى.',
      'changeLanguage': 'تغيير اللغة',
    },
  };

  String _t(String key) => _localizedValues[locale.languageCode]?[key] ?? key;

  String get appTitle => _t('appTitle');
  String get attendanceModes => _t('attendanceModes');
  String get scanQrBarcode => _t('scanQrBarcode');
  String get confirmUser => _t('confirmUser');
  String get settings => _t('settings');
  String get selectAttendanceMode => _t('selectAttendanceMode');
  String get startScan => _t('startScan');
  String get confirm => _t('confirm');
  String get cancel => _t('cancel');
  String get apiEndpointConfig => _t('apiEndpointConfig');
  String get scanError => _t('scanError');
  String get userNotFound => _t('userNotFound');
  String get attendanceSuccess => _t('attendanceSuccess');
  String get attendanceFailed => _t('attendanceFailed');
  String get changeLanguage => _t('changeLanguage');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 