import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/attendance_mode.dart';
import 'config_service.dart';
import 'package:flutter/services.dart' show rootBundle;

class ApiService {
  // Singleton pattern (optional)
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Placeholder for API endpoint
  String apiEndpoint = '';

  Future<User?> fetchUserById(String userId) async {
    // Check local config for test user
    try {
      final localJson = await rootBundle.loadString('assets/sample_users.json');
      final localData = jsonDecode(localJson) as Map<String, dynamic>;
      if (localData.containsKey(userId)) {
        return User.fromJson(localData[userId]);
      }
    } catch (_) {}
    try {
      final endpoint = await ConfigService().getApiEndpoint();
      if (endpoint == null || endpoint.isEmpty) return null;
      final url = Uri.parse('$endpoint/validate_user');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['user'] != null) {
          return User.fromJson(data['user']);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<AttendanceMode>> fetchAttendanceModes() async {
    //   try {
    //   final endpoint = await ConfigService().getApiEndpoint();
    //   if (endpoint == null || endpoint.isEmpty) return [];
    //   final url = Uri.parse('$endpoint/attendance_modes');
    //   final response = await http.get(url);
    //   if (response.statusCode == 200) {
    //     final data = jsonDecode(response.body);
    //     if (data['success'] == true && data['modes'] is List) {
    //       return (data['modes'] as List)
    //           .map((e) => AttendanceMode.fromJson(e))
    //           .toList();
    //     }
    //   }
    //   return [];
    // } catch (e) {
    //   return [];
    // }
    // Mocked data for testing
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return [
      AttendanceMode(id: '1', name: 'First Attend'),
      AttendanceMode(id: '2', name: 'Second Attend'),
    ];
  }

  Future<bool> confirmAttendance({
    required String userId,
    required String modeId,
  }) async {
    try {
      final endpoint = await ConfigService().getApiEndpoint();
      if (endpoint == null || endpoint.isEmpty) return false;
      final url = Uri.parse('$endpoint/confirm_attendance');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'modeId': modeId}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
} 