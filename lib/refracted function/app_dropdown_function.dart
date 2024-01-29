//   import 'package:flutter/material.dart';

// Future<void> showDeleteCategoryDialog(
//       BuildContext context, String currentCategory,  void Function(String) deleteCategoryAndShowSnackbar) async {
//     TextEditingController editingController =
//         TextEditingController(text: currentCategory);
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Category'),
//           content: TextField(
//             controller: editingController,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     _editCategory(editingController.text, currentCategory);
//             //     Navigator.of(context).pop();
//             //   },
//             //   child: const Text('Edit'),
//             // ),
//             ElevatedButton(
//               onPressed: () {
//                 deleteCategoryAndShowSnackbar(currentCategory);
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
