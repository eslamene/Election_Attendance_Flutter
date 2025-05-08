import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'services/api_service.dart';
import 'models/user.dart';
import 'widgets/user_card.dart';
import 'models/attendance_mode.dart';
import 'widgets/mode_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/config_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

void main() {
  runApp(const AttendanceApp());
}

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) {
    return MaterialApp(
            title: 'Judges Election Attendance',
      theme: ThemeData(
        useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFFFD700), // Gold
                brightness: Brightness.light,
                primary: const Color(0xFFFFD700), // Gold
                secondary: const Color(0xFFFFD700),
                background: Colors.white,
                surface: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF181818),
                elevation: 0,
                centerTitle: true,
              ),
              cardTheme: CardTheme(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFFFFD700), width: 1),
                ),
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFFFD700)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2),
                ),
                labelStyle: const TextStyle(color: Color(0xFF181818)),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                  textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
                  elevation: 2,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFFFFD700),
                unselectedItemColor: Color(0xFF181818),
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                elevation: 10,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            ),
            locale: localeProvider.locale,
            supportedLocales: [
              const Locale('en'),
              const Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: '/',
            routes: {
              '/': (context) => const MainScaffold(),
              '/confirm': (context) => const ConfirmScreen(),
            },
          );
        },
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: _screens[_selectedIndex],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 12,
          borderRadius: BorderRadius.circular(40),
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 14,
              unselectedFontSize: 13,
              selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.poppins(),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: _selectedIndex == 0
                      ? Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.home, color: Colors.black, size: 28),
                        )
                      : Icon(Icons.home_outlined, color: Colors.black54, size: 28),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 1
                      ? Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.settings, color: Colors.black, size: 28),
                        )
                      : Icon(Icons.settings_outlined, color: Colors.black54, size: 28),
                  label: loc.settings,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Scan History Model & Store ---
class ScanHistoryItem {
  final String userId;
  final String userName;
  final String modeName;
  final DateTime timestamp;
  final String? photoUrl;
  ScanHistoryItem({
    required this.userId,
    required this.userName,
    required this.modeName,
    required this.timestamp,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'modeName': modeName,
    'timestamp': timestamp.toIso8601String(),
    'photoUrl': photoUrl,
  };

  static ScanHistoryItem fromJson(Map<String, dynamic> json) => ScanHistoryItem(
    userId: json['userId'],
    userName: json['userName'],
    modeName: json['modeName'],
    timestamp: DateTime.parse(json['timestamp']),
    photoUrl: json['photoUrl'],
  );
}

class ScanHistoryStore {
  static const _key = 'scan_history';

  static Future<List<ScanHistoryItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.map((e) => ScanHistoryItem.fromJson(Map<String, dynamic>.from(jsonDecode(e)))).toList();
  }

  static Future<void> add(ScanHistoryItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    list.insert(0, jsonEncode(item.toJson()));
    if (list.length > 20) list.removeLast(); // Keep only last 20
    await prefs.setStringList(_key, list);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

// --- HomeScreen Modern Redesign ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedModeId;
  String? _selectedModeName;
  List<ScanHistoryItem> _history = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSelectedMode();
    _loadHistory();
  }

  Future<void> _loadSelectedMode() async {
    final settings = await SettingsStore.load();
    setState(() {
      _selectedModeId = settings.selectedModeId;
      _selectedModeName = settings.selectedModeName;
    });
  }

  Future<void> _loadHistory() async {
    final history = await ScanHistoryStore.load();
    setState(() {
      _history = history;
    });
  }

  void _startScan() async {
    if (_selectedModeId == null) {
      _showErrorModal(AppLocalizations.of(context)!.selectAttendanceMode);
      return;
    }
    final loc = AppLocalizations.of(context)!;
    String scanResult = '';
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#FFD700',
        loc.cancel,
        true,
        ScanMode.BARCODE,
      );
    } catch (e) {
      scanResult = '';
    }
    if (!mounted) return;
    scanResult = scanResult.trim();
    if (scanResult == '-1' || scanResult.isEmpty) {
      // User cancelled
      return;
    }
    // Validate: must be a 12-digit number
    if (!RegExp(r'^\d{12}$').hasMatch(scanResult)) {
      _showErrorModal(loc.scanError);
      return;
    }
    // Check for duplicate scan
    final history = await ScanHistoryStore.load();
    final modeName = await _getModeName(_selectedModeId!);
    final alreadyScanned = history.any((item) => item.userId == scanResult && item.modeName == modeName);
    if (alreadyScanned) {
      _showErrorModal(loc.userNotFound + '\n' + 'This user has already been scanned for this attendance mode.');
      return;
    }
    setState(() {}); // To show loading if needed
    final user = await ApiService().fetchUserById(scanResult);
    if (user == null) {
      _showErrorModal(loc.userNotFound);
      return;
    }
    if (!mounted) return;
    // Show user info in bottom sheet, confirm adds to history
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24, right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserCard(user: user),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: Text(loc.confirm),
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(loc.cancel),
            ),
          ],
        ),
      ),
    );
    if (confirmed == true) {
      // Add to scan history
      await ScanHistoryStore.add(ScanHistoryItem(
        userId: user.id,
        userName: user.name,
        modeName: modeName ?? '',
        timestamp: DateTime.now(),
        photoUrl: user.photoUrl,
      ));
      _loadHistory();
    }
  }

  Future<String?> _getModeName(String modeId) async {
    final modes = await ApiService().fetchAttendanceModes();
    return modes.firstWhere((m) => m.id == modeId, orElse: () => AttendanceMode(id: '', name: '')).name;
  }

  void _showErrorModal(String message) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(ScanHistoryItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          backgroundImage: (item.photoUrl != null && item.photoUrl!.isNotEmpty)
              ? NetworkImage(item.photoUrl!)
              : null,
          child: (item.photoUrl == null || item.photoUrl!.isEmpty)
              ? Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
              : null,
        ),
        title: Text(item.userName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        subtitle: Text('${item.modeName} • ${_formatTime(item.timestamp)}'),
        trailing: Text(item.userId, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    if (now.difference(dt).inDays == 0) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dt.year}/${dt.month}/${dt.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Judges Election Attendance', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 26)),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          if (_history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Clear History',
              onPressed: () async {
                await ScanHistoryStore.clear();
                _loadHistory();
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedModeName != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text('${loc.selectAttendanceMode}: $_selectedModeName', style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87)),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text('Recent Scans', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Expanded(
              child: _history.isEmpty
                  ? Center(child: Text('No scans yet', style: GoogleFonts.poppins(color: Colors.black38)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: _history.length,
                      itemBuilder: (context, i) => _buildHistoryCard(_history[i]),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
              child: Center(
                child: Text('© 2025 Elections', style: GoogleFonts.poppins(fontSize: 12, color: Colors.black45)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startScan,
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
        label: Text(loc.startScan, style: const TextStyle(color: Colors.black)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  bool _isLoading = false;
  String? _resultMessage;

  Future<void> _confirmAttendance(User user, String modeId) async {
    setState(() {
      _isLoading = true;
      _resultMessage = null;
    });
    final success = await ApiService().confirmAttendance(userId: user.id, modeId: modeId);
    setState(() {
      _isLoading = false;
      _resultMessage = success
          ? AppLocalizations.of(context)!.attendanceSuccess
          : AppLocalizations.of(context)!.attendanceFailed;
    });
    if (success) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final user = args != null ? args['user'] as User? : null;
    final modeId = args != null ? args['modeId'] as String? : null;
    return Scaffold(
      appBar: AppBar(title: Text(loc.confirmUser)),
      body: user == null || modeId == null
          ? Center(child: Text(loc.userNotFound))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserCard(user: user),
                  const SizedBox(height: 24),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else ...[
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: Text(loc.confirm),
                      onPressed: () => _confirmAttendance(user, modeId),
                    ),
                    if (_resultMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(_resultMessage!, style: TextStyle(color: Colors.green)),
                    ],
                  ],
                ],
              ),
            ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<AttendanceMode> _modes = [];
  String? _selectedModeId;
  String? _selectedModeName;
  String? _apiEndpoint;
  bool _isLoading = false;
  final _apiController = TextEditingController();
  String _selectedLanguage = 'ar';
  final List<Map<String, dynamic>> _languages = [
    {'code': 'ar', 'label': 'العربية', 'icon': Icons.language},
    {'code': 'en', 'label': 'English', 'icon': Icons.language},
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _fetchModes();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language_code') ?? 'ar';
    });
  }

  Future<void> _saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);
  }

  void _onLanguageChanged(String? code) {
    if (code == null) return;
    setState(() {
      _selectedLanguage = code;
    });
    Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale(code));
    _saveLanguage(code);
  }

  Future<void> _loadSettings() async {
    final settings = await SettingsStore.load();
    setState(() {
      _selectedModeId = settings.selectedModeId;
      _selectedModeName = settings.selectedModeName;
      _apiEndpoint = settings.apiEndpoint;
      _apiController.text = _apiEndpoint ?? '';
    });
  }

  Future<void> _fetchModes() async {
    setState(() => _isLoading = true);
    final modes = await ApiService().fetchAttendanceModes();
    setState(() {
      _modes = modes;
      _isLoading = false;
    });
  }

  void _onModeChanged(String? id) {
    final mode = _modes.firstWhere((m) => m.id == id, orElse: () => _modes.first);
    setState(() {
      _selectedModeId = mode.id;
      _selectedModeName = mode.name;
    });
    SettingsStore.saveMode(mode.id, mode.name);
  }

  void _onApiEndpointSaved() async {
    await SettingsStore.saveApiEndpoint(_apiController.text.trim());
    setState(() {
      _apiEndpoint = _apiController.text.trim();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.attendanceSuccess)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.settings)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(loc.changeLanguage, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _languages.map((lang) {
                        final isSelected = _selectedLanguage == lang['code'];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => _onLanguageChanged(lang['code']),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(lang['icon'], color: isSelected ? Colors.black : Colors.black54, size: 20),
                                  const SizedBox(width: 6),
                                  Text(
                                    lang['label'],
                                    style: GoogleFonts.poppins(
                                      color: isSelected ? Colors.black : Colors.black54,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(loc.selectAttendanceMode, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ModeSelector(
                    modes: _modes,
                    selectedModeId: _selectedModeId,
                    onChanged: _onModeChanged,
                  ),
                  const SizedBox(height: 32),
                  Text('API Endpoint', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _apiController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'API Endpoint',
                      hintText: 'https://your-api-url',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _onApiEndpointSaved,
                    child: Text('Save API Endpoint'),
                  ),
                  if (_apiEndpoint != null && _apiEndpoint!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text('Current: $_apiEndpoint', style: const TextStyle(fontSize: 12)),
                  ],
                ],
              ),
            ),
    );
  }
}

// SettingsStore for persisting mode and API endpoint
class SettingsStore {
  static const _modeIdKey = 'selected_mode_id';
  static const _modeNameKey = 'selected_mode_name';
  static const _apiEndpointKey = 'api_endpoint';
  final String? selectedModeId;
  final String? selectedModeName;
  final String? apiEndpoint;
  SettingsStore({this.selectedModeId, this.selectedModeName, this.apiEndpoint});

  static Future<SettingsStore> load() async {
    final storage = ConfigService();
    final apiEndpoint = await storage.getApiEndpoint();
    final prefs = await SharedPreferences.getInstance();
    return SettingsStore(
      selectedModeId: prefs.getString(_modeIdKey),
      selectedModeName: prefs.getString(_modeNameKey),
      apiEndpoint: apiEndpoint,
    );
  }

  static Future<void> saveMode(String id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeIdKey, id);
    await prefs.setString(_modeNameKey, name);
  }

  static Future<void> saveApiEndpoint(String endpoint) async {
    final storage = ConfigService();
    await storage.setApiEndpoint(endpoint);
  }
}

// Update UserCard for modern light/gold look
class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              backgroundImage: user.photoUrl.isNotEmpty ? NetworkImage(user.photoUrl) : null,
              child: user.photoUrl.isEmpty
                  ? Icon(Icons.person, size: 36, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('ID: ${user.id}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
