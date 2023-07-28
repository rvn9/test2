import 'dart:convert';

import 'package:test_app2/data/remote/base_service.dart';
import 'package:test_app2/inejctor.dart';

class AuthService {
  final BaseService _baseService;
  const AuthService(this._baseService);

  factory AuthService.create() => AuthService(getIt.get());

  // http://restapi.adequateshop.com/api/authaccount/registration
  // {

  //             "name":"Developer",
  //             "email":"Developer5@gmail.com",
  //             "password":123456
  // }
  // http://restapi.adequateshop.com/api/authaccount/login
  // {
  // 	"email":"Developer5@gmail.com",
  // 	"password":123456
  // }

  //   {
//     "$id": "1",
//     "code": 0,
//     "message": "success",
//     "data": {
//         "$id": "2",
//         "Id": 7075,
//         "Name": "Developer",
//         "Email": "Developer5@gmail.com",
//         "Token": "02b869e4-ea45-4b5c-b764-642a39e95bb7"
//     }
// }
  Future<bool> signUp(
      {required String name,
      required String password,
      required String email}) async {
    final response =
        await _baseService.dio.post('authaccount/registration', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await _baseService.dio.post('authaccount/login', data: {
      'email': email,
      'password': password,
    });
    final Map<String, dynamic> result = json.decode(response.data);
    return result;
  }
}
