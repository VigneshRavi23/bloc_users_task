import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/Bloc/UserBloc.dart';
import 'package:task1/Bloc/UserDetailBloc.dart';
import 'package:task1/Constants/constants.dart';
import 'package:task1/Model/Users.dart';

class UserDetails extends StatefulWidget {
  final int? userId;

  UserDetails({this.userId});

  @override
  State<StatefulWidget> createState() => UserDetailState();
}

class UserDetailState extends State<UserDetails> {
  late UserDetailBloc _userBloc;
  int? userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _userBloc = UserDetailBloc();
    _userBloc.fetchUsersDetail(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: BlocBuilder<UserDetailBloc, UserData>(
          bloc: _userBloc,
          builder: (context, users) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          users.avatar ?? Constants.placeholder_image_url),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Text(
                      "${users.firstName} ${users.lastName}",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      "${users.email}",
                      style: const TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
