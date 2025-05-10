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
    // try {
    //   final localJson = await rootBundle.loadString('assets/sample_users.json');
    //   final localData = jsonDecode(localJson) as Map<String, dynamic>;
    //   if (localData.containsKey(userId)) {
    //     return User.fromJson(localData[userId]);
    //   }
    // } catch (_) {}
    try {
      final endpoint = await ConfigService().getApiEndpoint();
      if (endpoint == null || endpoint.isEmpty) return null;
      final url = Uri.parse('$endpoint/api/person-info/findByReferenceNumber');
      Map<String,dynamic> user = {};
      user['referenceNumber'] = userId;
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},

        body: jsonEncode(user),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
          return User.fromJson(data);

      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<AttendanceMode>> fetchAttendanceModes() async {
      try {
      final endpoint = await ConfigService().getApiEndpoint();
      if (endpoint == null || endpoint.isEmpty) return [];
      final url = Uri.parse('$endpoint/api/attendance-type/findall');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
          return (data as List)
              .map((e) => AttendanceMode.fromJson(e))
              .toList();

      }
      return [];
    } catch (e) {
      return [];
    }
    // Mocked data for testing
    // await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    // return [
    //   AttendanceMode(id: '1', name: 'First Attend'),
    //   AttendanceMode(id: '2', name: 'Second Attend'),
    // ];
  }

  Future<String> confirmAttendance({
    required String userId,
    required String modeId,
  }) async {
    try {
      final endpoint = await ConfigService().getApiEndpoint();
      if (endpoint == null || endpoint.isEmpty) return 'failed';
      final url = Uri.parse('$endpoint/api/attendance');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'personInfo': {'referenceNumber':userId}, 'type': {'id':modeId}}),
      );
      if (response.statusCode == 200) {
        return  'success';
      }
      else if (response.statusCode == 400){
        return  jsonDecode(response.body)['message'].toString();

      }
      return '';
    } catch (e) {
      return 'failed';
    }
  }
} 