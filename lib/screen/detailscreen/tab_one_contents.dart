import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/others/widgets.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_class/app_full_screen_image.dart';

class TabOneContent extends StatelessWidget {
  final DestinationModels? selectedItem;

  const TabOneContent({
    super.key,
    required this.selectedItem,
  });
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding:  EdgeInsets.only(top:screenWidth* .08),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 350,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: const Color.fromARGB(255, 123, 216, 218),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(screenWidth*.03),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    child: Text(
                      selectedItem!.details,
                      style:  TextStyle(
                          color: AppColors.blackColor,
                          fontSize:screenWidth* .04,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Widgets.headingText('Images',context),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: selectedItem?.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:  EdgeInsets.all(screenWidth*.03),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePageView(
                            images: selectedItem?.images ?? [],
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'imageHero$index', // Unique tag for each image ,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.grey,
                        ),
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(selectedItem?.images[index] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
