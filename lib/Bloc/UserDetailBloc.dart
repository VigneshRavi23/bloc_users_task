import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/Model/Users.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Constants/constants.dart';

class UserDetailBloc extends Cubit<UserData> {
  UserDetailBloc() : super(UserData());

  Future<void> fetchUsersDetail(int user_id) async {
    try {
      final response = await http.get(
          Uri.parse('${Constants.baseUrl}${Constants.fetchUsers}/$user_id'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final usersData = UserData.fromJson(jsonData["data"]);
        emit(usersData);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users');
    }
  }
}
