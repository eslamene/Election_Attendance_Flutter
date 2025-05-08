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
      'recentScans': 'Recent Scans',
      'noScansYet': 'No scans yet',
      'alreadyScanned': 'This user\'s attendance has already been recorded for this mode.',
      'copyright': '© 2025 Elections',
      'apiEndpoint': 'API Endpoint',
      'saveApiEndpoint': 'Save API Endpoint',
      'currentApiEndpoint': 'Current: {endpoint}',
      'clearHistory': 'Clear History',
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
      'recentScans': 'المسحات الأخيرة',
      'noScansYet': 'لم تقم بمسح حتى الآن',
      'alreadyScanned': 'تم تسجيل حضور هذا المستخدم بالفعل لهذا النمط.',
      'copyright': '© 2025 الانتخابات',
      'apiEndpoint': 'نقطة نهاية API',
      'saveApiEndpoint': 'حفظ نقطة نهاية API',
      'currentApiEndpoint': 'الحالي: {endpoint}',
      'clearHistory': 'مسح السجل',
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
  String get recentScans => _t('recentScans');
  String get noScansYet => _t('noScansYet');
  String get alreadyScanned => _t('alreadyScanned');
  String get copyright => _t('copyright');
  String get apiEndpoint => _t('apiEndpoint');
  String get saveApiEndpoint => _t('saveApiEndpoint');
  String currentApiEndpoint(String endpoint) => _t('currentApiEndpoint').replaceAll('{endpoint}', endpoint);
  String get clearHistory => _t('clearHistory');
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