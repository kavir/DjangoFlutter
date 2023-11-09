import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final registrationUri = Uri.parse("http://192.168.1.68:8000/registration/");
  final loginUri = Uri.parse("http://192.168.1.68:8000/accounts/login/");
  final logoutUrl = Uri.parse("http://192.168.1.68:8000/accounts/logout/");
  Future<RegistrationResponse?> registration(
      String username, String password1, String password2, String email) async {
    var response = await http.post(registrationUri, body: {
      "username": username,
      "email": email,
      "password1": password1,
      "password2": password2,
    });
    //print(response.body);
    return RegistrationResponse.fromJson(jsonDecode(response.body));
  }

  Future<LoginResponse?> login(String usernameOremail, String password) async {
    var response = await http.post(loginUri, body: {
      "username": usernameOremail,
      "password": password,
    });
    print(response.body);
    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}

class RegistrationResponse {
  List<dynamic>? non_field_errors;
  List<dynamic>? password1;
  List<dynamic>? username;
  List<dynamic>? email;
  dynamic key;

  RegistrationResponse(
      {this.email,
      this.key,
      this.non_field_errors,
      this.password1,
      this.username});

  factory RegistrationResponse.fromJson(mapOfBody) {
    return RegistrationResponse(
      email: mapOfBody["email"],
      key: mapOfBody["key"],
      non_field_errors: mapOfBody["non_field_errors"],
      password1: mapOfBody["password1"],
      username: mapOfBody["username"],
    );
  }
}

class LoginResponse {
  dynamic key;
  List<dynamic>? non_field_errors;
  LoginResponse({this.key, this.non_field_errors});

  factory LoginResponse.fromJson(mapOfBody) {
    return LoginResponse(
      key: mapOfBody['key'],
      non_field_errors: mapOfBody['non_field_errors'],
    );
  }
}


