import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/UserBloc.dart';
import '../Model/Users.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserBloc _userBloc;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc();
    _userBloc.fetchUsers(_currentPage); // Fetch the initial page of users
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: BlocBuilder<UserBloc, Users>(
        bloc: _userBloc,
        builder: (context, users) {
          return ListView.builder(
            itemCount: users.data?.length ?? 0,
            itemBuilder: (context, index) {
              final user = users.data?[index];
              return InkWell(
                onTap: () {
                  int userId = user?.id ?? 1;
                  Navigator.pushNamed(context, '/user-detail',
                      arguments: userId);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 209, 234, 255),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user?.avatar ?? ''),
                    ),
                    title: Text('${user?.firstName} ${user?.lastName}'),
                    subtitle: Text('Email: ${user?.email}'),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: BlocBuilder<UserBloc, Users>(
            bloc: _userBloc,
            builder: (context, users) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _currentPage > 1
                        ? () {
                            setState(() {
                              _currentPage--;
                            });
                            _userBloc.fetchUsers(_currentPage);
                          }
                        : null,
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: (_currentPage < (users.totalPages ?? 0))
                        ? () {
                            setState(() {
                              _currentPage++;
                            });
                            _userBloc.fetchUsers(_currentPage);
                          }
                        : null,
                    child: const Text('Next'),
                  ),
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }
}
