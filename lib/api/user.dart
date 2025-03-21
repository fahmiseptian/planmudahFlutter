import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailUser {
  static const String baseUrl = 'https://akfs.my.id/planmudah/api/user';

  static Future<String?> detail() async {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData["success"] == true) {
        return responseData["data"];
      } else {
        return null;
      }
    } else {
      return "Gagal menghubungi server";
    }
  }
}

class UpdateUser {
  static const String baseUrl = 'https://akfs.my.id/planmudah/api/user/update';

  static Future<String?> userUpdate(String name) async {
    String? token = await getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"name": name}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData["success"] == true) {
        return responseData["message"];
      } else {
        return null;
      }
    } else {
      return "Gagal menghubungi server";
    }
  }
}

class ChangePassword {
  static const String baseUrl =
      'https://akfs.my.id/planmudah/api/user/change-password';

  static Future<String?> changePassword(
    String passwordOld,
    String passwordNew,
  ) async {
    String? token = await getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "passwordNew": passwordNew,
        "passwordOld": passwordOld,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData["success"] == true) {
        return responseData["message"];
      } else {
        return null;
      }
    } else {
      return "Gagal menghubungi server";
    }
  }
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}
