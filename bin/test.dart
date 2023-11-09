import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

main() async {
  // ListOfGuitar listOfGuitar = await GuitarService().getGuitar();
  // print(listOfGuitar.guitars[0].name);

  ////////////////////////////////////////////////////////////
  var response = await http
      .get(Uri.parse("http://192.168.1.68:8000/instrument/guitarlist/"));
  var a = Utf8Decoder().convert(response.bodyBytes);
  print(a);
}

previousmain() async {
  AuthService authService = AuthService(); //object banayo

//logout ko lagi

// final logoutUrl = Uri.parse("http://127.0.0.1:8000/accounts/logout/");
// var response = await http.get(logoutUrl, headers: {
//   "Authorization": "Token fc981dade4a55b0eff4cdaa1439f33ddfcc6c01d"
// });

//logout
  var response = await http
      .get(Uri.parse("http://192.168.1.68:8000/accounts/user/"), headers: {
    "Authorization": " Token fc981dade4a55b0eff4cdaa1439f33ddfcc6c01d"
  });
  print(response.body);
}

/////////////////////////////////////////// login ko lagi

//login key: fc981dade4a55b0eff4cdaa1439f33ddfcc6c01d

// LoginResponse? loginResponse =
//     await authService.login("kabita7@gmail.com", "panthera1234");
// if (loginResponse != null) {
//   if (loginResponse.key != null) print(loginResponse.key);
//   if (loginResponse.non_field_errors != null)
//     loginResponse.non_field_errors!.forEach((element) {
//       print(element);
//     });
// }

//////////////////////////////////////// data content dekhaunaw ko lagiiii

// var response = await http
//     .get(Uri.parse("http://127.0.0.1:8000/accounts/user/"), headers: {
//   "Authorization": "Token fc981dade4a55b0eff4cdaa1439f33ddfcc6c01d"
// });
// print(response.body);

//// ////////////////////////////////////registration ko lagiiiii

// RegistrationResponse? registrationResponse = await authService.registration(
//     "sabita", "sabita7@gmail.com", "panthera1234", "panthera1234");
// if (registrationResponse != null) {
//   if (registrationResponse.email != null) {
//     registrationResponse.email!.forEach((element) {
//       print(element);
//     });
//   }
//   if (registrationResponse.username != null) {
//     registrationResponse.username!.forEach((element) {
//       print(element);
//     });
//   }
//   if (registrationResponse.non_field_errors != null) {
//     registrationResponse.non_field_errors!.forEach((element) {
//       print(element);
//     });
//   }
//   if (registrationResponse.password1 != null) {
//     registrationResponse.password1!.forEach((element) {
//       print(element);
//     });
//   }
//   if (registrationResponse.key != null) {
//     print(registrationResponse.key!);
//   }
// }

//////////////////////////////////////////////////////////////////////////////////////
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
