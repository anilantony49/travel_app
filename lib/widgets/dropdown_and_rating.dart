// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import '../refracted widgets/app_colors.dart';
// import '../refracted widgets/app_string.dart';

// class DropdownAndRatingWidget extends StatefulWidget {
//   final String selectedCategories;
//   final List<String> dropdownItems;
//   final void Function(String) deleteCategoryAndShowSnackbar;

//   const DropdownAndRatingWidget({
//     super.key,
//     required this.selectedCategories,
//     required this.dropdownItems,
//     required this.deleteCategoryAndShowSnackbar,
//   });

//   @override
//   State<DropdownAndRatingWidget> createState() =>
//       _DropdownAndRatingWidgetState();
// }

// class _DropdownAndRatingWidgetState extends State<DropdownAndRatingWidget> {
//   late String _selectedCategories;

//   @override
//   void initState() {
//     super.initState();
//     _selectedCategories = widget.selectedCategories;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(bottom: 5),
//               child: Text(
//                 AppStrings.selectCategory,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Container(
//                 padding: const EdgeInsets.only(left: 10),
//                 decoration: BoxDecoration(
//                   color: AppColors.borderColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButton<String>(
//                   underline: Container(),
//                   value: _selectedCategories,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   style: const TextStyle(
//                     color: AppColors.blackColor,
//                   ),
//                   items: widget.dropdownItems
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: GestureDetector(
//                         onLongPress: () async {
//                           _showDeleteCategoryDialog(
//                             context,
//                             value,
//                             widget.deleteCategoryAndShowSnackbar,
//                           );
//                         },
//                         child: Text(value),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedCategories = newValue.toString();
//                     });
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//         const Spacer(),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(bottom: 5),
//               child: Text(
//                 AppStrings.rating,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width * .40,
//                 height: MediaQuery.of(context).size.width * .12,
//                 padding: const EdgeInsets.only(left: 10),
//                 decoration: BoxDecoration(
//                   color: AppColors.borderColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 14, left: 10),
//                   child: RatingBar(
//                     itemPadding: const EdgeInsets.symmetric(
//                       horizontal: 1,
//                     ),
//                     direction: Axis.horizontal,
//                     itemCount: 5,
//                     itemSize: 20,
//                     minRating: 1,
//                     initialRating: 3,
//                     allowHalfRating: true,
//                     ratingWidget: RatingWidget(
//                       full: const Icon(
//                         Icons.star,
//                         color: AppColors.rating,
//                       ),
//                       half: const Icon(
//                         Icons.star_half,
//                         color: AppColors.rating,
//                       ),
//                       empty: const Icon(
//                         Icons.star_border,
//                         color: AppColors.rating,
//                       ),
//                     ),
//                     onRatingUpdate: (rating) {
//                       // You can update rating value here if needed
//                     },
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }

//   Future<void> _showDeleteCategoryDialog(
//     BuildContext context,
//     String currentCategory,
//     void Function(String) deleteCategoryAndShowSnackbar,
//   ) async {
//     TextEditingController editingController =
//         TextEditingController(text: currentCategory);

//     // Use Future.microtask to defer the dialog
//     await Future.microtask(() async {
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Delete Category'),
//             content: TextField(
//               controller: editingController,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   deleteCategoryAndShowSnackbar(currentCategory);
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Delete'),
//               ),
//             ],
//           );
//         },
//       );
//     });
//   }
// }
