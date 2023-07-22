import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Constants/constants.dart';
import '../Model/Users.dart';

class UserBloc extends Cubit<Users> {
  UserBloc() : super(Users());

  Future<void> fetchUsers(int page) async {
    try {
      final response = await http.get(
          Uri.parse('${Constants.baseUrl}${Constants.fetchUsers}?page=$page'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final users = Users.fromJson(jsonData);
        emit(users);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users');
    }
  }
}
