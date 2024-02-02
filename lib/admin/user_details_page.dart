import 'package:flutter/material.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_class/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';

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
        duration: Duration(seconds:2),
      ),
    );

    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwidget(title: AppStrings.userDetails),
      body: BackgroundColor(
        child: users.isEmpty
            ? const Center(child: Text('No users'))
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: IconButton(
                        onPressed: () {
                          deleteUserAndShowSnackbar(users[index].id);
                        },
                        icon: const Icon(Icons.delete)),
                    title: Text('Username: ${users[index].username}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('email: ${users[index].email}'),
                        Text('Password: ${users[index].password}'),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
