import 'package:flutter/material.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/models/authentication.dart';

class UsersDetailsPage extends StatefulWidget {
  const UsersDetailsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UsersDetailsPageState createState() => _UsersDetailsPageState();
}

class _UsersDetailsPageState extends State<UsersDetailsPage> {
  List<AuthenticationModels> users = [];

  @override
  void initState() {
    super.initState();

    fetchUsers();
  }

  void fetchUsers() async {
    List<AuthenticationModels> fetchedUsers =
        await AuthenticationDb.singleton.getUsers();

    fetchedUsers.sort((a, b) => b.username.compareTo(a.username));

    setState(() {
      users = fetchedUsers;
    });
  }

  void deleteUserAndShowSnackbar(String userId) {
    AuthenticationDb.singleton.deleteUsers(userId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User deleted successfully'),
        duration: Duration(seconds: 3),
      ),
    );

    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        deleteUserAndShowSnackbar(users[index].id);
                      },
                      icon: const Icon(Icons.delete)),
                  title: Text('Name: ${users[index].name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${users[index].username}'),
                      Text('Password: ${users[index].password}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
