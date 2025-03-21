import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://akfs.my.id/planmudah/api/login';

  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      await saveToken(responseData["access_token"]);
      return null;
    } else {
      return "Gagal menghubungi server";
    }
  }
}

class RefershToken {
  static const String baseUrl = 'https://akfs.my.id/planmudah/api/refresh';

  static Future<Map<String, dynamic>?> refershToken() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        await saveToken(responseData["access_token"]);
        return null;
      } else {
        return null;
      }
    } catch (e) {
      print("Error API getCourierForCOD: $e");
      return null;
    }
  }
}

class Logout {
  static const String baseUrl = 'https://akfs.my.id/planmudah/api/logout';

  static Future<String?> logout() async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.remove('jwt_token');
      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('jwt_token');
        return null;
      } else {
        return "Gagal Logout";
      }
    } catch (e) {
      print("Error API getCourierForCOD: $e");
      return null;
    }
  }
}

class Register {
  static const String baseUrl = 'https://akfs.my.id/planmudah/api/register';

  static Future<String?> regis(
    String name,
    String email,
    String password,
  ) async {
    try {
      String? token = await getToken();
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        await saveToken(responseData["token"]);
        return null;
      } else {
        return "Gagal menghubungi server";
      }
    } catch (e) {
      print("Error API getCourierForCOD: $e");
      return null;
    }
  }
}

Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}
