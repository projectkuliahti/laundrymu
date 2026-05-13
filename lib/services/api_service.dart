import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // GANTI DENGAN IP LAPTOP KAMU (cek via ipconfig)
  static const String baseUrl = 'https://muzzle-chirping-sixfold.ngrok-free.dev/api';

  // ─── LOGIN ───
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': 'Flutter_Android',
        }),
      );

      // Parse response body DULU, biar bisa dipakai di mana saja
      Map<String, dynamic> responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        return {'success': false, 'message': 'Response bukan JSON valid'};
      }

      if (response.statusCode == 200) {
        if (responseData['success'] == true && responseData['data'] != null) {
          final token = responseData['data']['token'];
          if (token != null && token.toString().isNotEmpty) {
            await _saveToken(token.toString());
            return {'success': true, 'data': responseData['data']};
          }
        }
        // Jika success=false dari Laravel
        return {'success': false, 'message': responseData['message'] ?? 'Login gagal'};
      } else if (response.statusCode == 401) {
        return {'success': false, 'message': responseData['message'] ?? 'Email atau password salah'};
      } else if (response.statusCode == 422) {
        return {'success': false, 'message': 'Validasi gagal: ${responseData['errors'] ?? ''}'};
      }
      
      return {'success': false, 'message': responseData['message'] ?? 'Login gagal'};

    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  // ─── GET SERVICES ───
  static Future<Map<String, dynamic>> getServices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/services'),
        headers: {'Content-Type': 'application/json'},
      );

      Map<String, dynamic> responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        return {'success': false, 'message': 'Response bukan JSON valid'};
      }

      if (response.statusCode == 200 && responseData['success'] == true) {
        return {'success': true, 'data': responseData['data']};
      }
      
      return {'success': false, 'message': responseData['message'] ?? 'Gagal mengambil data'};

    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  // ─── GET ORDERS (Protected) ───
  static Future<Map<String, dynamic>> getOrders() async {
    final token = await _getToken();
    if (token == null || token.isEmpty) {
      return {'success': false, 'message': 'Belum login'};
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        return {'success': false, 'message': 'Response bukan JSON valid'};
      }

      if (response.statusCode == 200 && responseData['success'] == true) {
        return {'success': true, 'data': responseData['data']};
      } else if (response.statusCode == 401) {
        await _clearToken(); // Token invalid, hapus
        return {'success': false, 'message': 'Sesi habis, silakan login ulang'};
      }
      
      return {'success': false, 'message': responseData['message'] ?? 'Gagal mengambil pesanan'};

    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  // ─── LOGOUT ───
  static Future<bool> logout() async {
    final token = await _getToken();
    if (token == null) return false;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        await _clearToken();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // ─── HELPER: Simpan/Ambil/Hapus Token ───
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}