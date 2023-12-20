

import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/side_menu_bar.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/authentication_page.dart';


class AfricaPage extends StatefulWidget {
  const AfricaPage({super.key});

  @override
  State<AfricaPage> createState() => _AfricaPageState();
}

class _AfricaPageState extends State<AfricaPage> {
    // List<AddCategoryModels> categories = [];
  @override
  void initState() {
    super.initState();
    // fetchCategory();
  }

  void fetchCategory() async {
    // List<AddCategoryModels> fetchedCategories =
    //     await AddCategoryDb.singleton.getCategory();
    // setState(() {
    //   categories = fetchedCategories;
    // });
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

    // Refetch the users to update the list
    fetchCategory();
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuBar(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.greenColor,
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const AddCategory()));
          },
          child: const Icon(Icons.add)),
      backgroundColor: const Color.fromARGB(255, 234, 227, 227),
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const AuthenticationPage()));
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: Constants.blackColor,
        //     )),
        backgroundColor: Constants.greenColor,
        centerTitle: true,
        title: const Text(
          'Admin panal',
          style: TextStyle(
              color: Constants.blackColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const UsersDetailsPage()),
                    // );
                  },
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

//   Widget buildBody(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(screenWidth * 0.04),
//           child: Text(
//             'Africa',
//             style: TextStyle(
//               fontSize: screenWidth * 0.06,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Expanded(
//             child: CategoryRow(
//           screenWidth: screenWidth,
//           categories: categories,
//           onDeleteCategory: deleteCategoryAndShowSnackbar,
//         )),
//       ],
//     );
//   }
// }

// class CategoryRow extends StatelessWidget {
//   final List<AddCategoryModels> categories;
//   final double screenWidth;
//   final void Function(String) onDeleteCategory; // Callback function

//   const CategoryRow({
//     Key? key,
//     required this.screenWidth,
//     required this.categories,
//     required this.onDeleteCategory,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemCount: categories.length,
//       itemBuilder: (BuildContext context, int index) {
//         return buildCategoryColumn(categories[index], context, index);
//       },
//     );
//   }

//   Widget buildCategoryColumn(
//       AddCategoryModels category, BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => CategoryItemList()));
//       },
//       onLongPress: () {
//         _showContextMenu(
//           context,
//           index,
//         );
//       },
//       child: CategoryColumn(
//         heading: category.categoryName,
//         imagePath: category.image,
//         screenWidth: screenWidth,
//       ),
//     );
//   }

//   _showContextMenu(
//     BuildContext context,
//     int index,
//   ) {
//     //  AddCategory addCategoryWidget = const AddCategory();

//     // TextEditingController controller = addCategoryWidget.getController();
//     // if (itemkey != null) {
//     //   final existingItem = AddCategoryDb()
//     //       .categoryNotifier
//     //       .value
//     //       .firstWhere((element) => element.categoryName == itemkey);
//     //   controller.text = existingItem.categoryName;

//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 onTap: () async {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AddOrEditCategory(
//                             operationType: 'Edit',
//                                 initialCategoryId: categories[index].id,
//                                 initialCategoryName:
//                                     categories[index].categoryName,
//                                 initialImagePath: categories[index].image,
//                               )));
//                   // final editCategory = AddCategoryModels(
//                   //     id: existingItem.id,
//                   //     image: existingItem.image,
//                   //     categoryName: controller.text);
//                   // AddCategoryDb().editCategory(editCategory, existingItem.id);
//                   // Navigator.pop(context);
//                   // AddCategoryDb()
//                   //     .categoryNotifier
//                   //     .value
//                   //     .removeWhere((item) => item.id == existingItem.id);
//                   // AddCategoryDb().categoryNotifier.value.add(editCategory);
//                   // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                   //     content: Text('A category has been Updated')));
//                 },
//                 leading:
//                     const Icon(Icons.edit_square, color: Constants.greenColor),
//                 title: const Text('Edit Category',
//                     style: TextStyle(color: Constants.blackColor)),
//               ),
//               ListTile(
//                 onTap: () {
//                   onDeleteCategory(categories[index].id);
//                   Navigator.pop(context);
//                 },
//                 leading: const Icon(Icons.delete, color: Constants.greenColor),
//                 title: const Text('Delete Category',
//                     style: TextStyle(color: Constants.blackColor)),
//               ),
//             ],
//           );
//         });
//   }
// }
// // }

// class CategoryColumn extends StatelessWidget {
//   final String heading;
//   final String imagePath;
//   final double screenWidth;

//   const CategoryColumn(
//       {super.key,
//       required this.heading,
//       required this.imagePath,
//       required this.screenWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Heading(heading: heading, screenWidth: screenWidth),
//         ContainerImage(imagePath: imagePath, screenWidth: screenWidth),
//       ],
//     );
//   }
// }

// class Heading extends StatelessWidget {
//   final String heading;
//   final double screenWidth;

//   const Heading({super.key, required this.heading, required this.screenWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(screenWidth * 0.02),
//       child: Text(
//         heading,
//         style: TextStyle(
//           fontSize: screenWidth * 0.04,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

// class ContainerImage extends StatelessWidget {
//   final String imagePath;
//   final double screenWidth;

//   const ContainerImage(
//       {super.key, required this.imagePath, required this.screenWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: screenWidth * 0.4,
//       width: screenWidth * 0.4,
//       margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(screenWidth * 0.04),
//         boxShadow: [
//           BoxShadow(
//             color: const Color.fromARGB(255, 188, 181, 181).withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(screenWidth * 0.04),
//         child: Image.file(
//           File(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
}