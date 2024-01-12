import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/detalis_add_edit_page.dart';
import 'package:new_travel_app/admin/side_menu_bar.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/authentication/authentication_page.dart';

class AsiaPage extends StatefulWidget {
  const AsiaPage({super.key});

  @override
  State<AsiaPage> createState() => _AsiaPageState();
}

class _AsiaPageState extends State<AsiaPage> {
  // List<AddCategoryModels> categories = [];
  @override
  void initState() {
    super.initState();
    // fetchCategory();
  }

  void deleteCategoryAndShowSnackbar(String categoryId) {
    // AddCategoryDb.singleton.deleteCategory(categoryId);

    // Show a Snackbar indicating that the user has been deleted
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Category deleted successfully'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      drawer: const SideMenuBar(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.greenColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailsAddEditPage(
                          category: 'Asia',
                          addOrEdit: 'Add',
                        )));
          },
          child: const Icon(Icons.add)),
      backgroundColor: const Color.fromARGB(255, 234, 227, 227),
      appBar: AppBar(
        backgroundColor: Constants.greenColor,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
              color: Constants.blackColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  onTap: () {},
                  // value: 'user_details',
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.group, color: Constants.greenColor),
                      SizedBox(width: 10),
                      Text('User Details',
                          style: TextStyle(color: Constants.blackColor)),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  // value: 'log_out',
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthenticationPage()),
                        (route) => false);
                    //  exit(0);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.exit_to_app, color: Constants.greenColor),
                      SizedBox(width: 10),
                      Text('Log Out',
                          style: TextStyle(color: Constants.blackColor)),
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
      // body: buildBody(context),
    );
  }
}
