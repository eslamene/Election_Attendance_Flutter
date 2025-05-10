import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'حضور الجمعية العامة لمحكمة النقض';

  @override
  String get attendanceModes => 'أنماط الحضور';

  @override
  String get home => 'الرئيسيه';

  @override
  String get scanQrBarcode => 'مسح رمز QR/باركود';

  @override
  String get confirmUser => 'تأكيد المستخدم';

  @override
  String get settings => 'الإعدادات';

  @override
  String get selectAttendanceMode => 'اختر نمط الحضور';

  @override
  String get startScan => 'بدء المسح';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get apiEndpointConfig => 'إعداد نقطة نهاية API هنا.';

  @override
  String get scanError => 'فشل المسح أو رمز غير صالح.';

  @override
  String get userNotFound => 'المستخدم غير موجود.';

  @override
  String get attendanceSuccess => 'تم تأكيد الحضور!';

  @override
  String get attendanceFailed => 'فشل تأكيد الحضور. حاول مرة أخرى.';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get recentScans => 'المسحات الأخيرة';

  @override
  String get noScansYet => 'لم تقم بمسح حتى الآن';

  @override
  String get alreadyScanned => 'تم تسجيل حضور هذا المستخدم بالفعل لهذا النمط.';

  @override
  String get copyright => '© 2025 الانتخابات';

  @override
  String get apiEndpoint => 'نقطة نهاية API';

  @override
  String get saveApiEndpoint => 'حفظ نقطة نهاية API';

  @override
  String currentApiEndpoint(Object endpoint) {
    return 'الحالي: $endpoint';
  }

  @override
  String get clearHistory => 'مسح السجل';
}
