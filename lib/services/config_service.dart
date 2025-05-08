import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConfigService {
  static const _apiEndpointKey = 'api_endpoint';
  static final ConfigService _instance = ConfigService._internal();
  factory ConfigService() => _instance;
  ConfigService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> setApiEndpoint(String endpoint) async {
    await _storage.write(key: _apiEndpointKey, value: endpoint);
  }

  Future<String?> getApiEndpoint() async {
    return await _storage.read(key: _apiEndpointKey);
  }
} 