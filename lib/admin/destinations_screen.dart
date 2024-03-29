import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/admin/detalis_add_edit_page.dart';
import 'package:new_travel_app/admin/user_details_page.dart';
import 'package:new_travel_app/db/destination_details_db.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_function/show_destination_bottom_sheet.dart';
import 'package:new_travel_app/refracted_widgets/app_sized_box.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/screen/authentication/authentication_page.dart';

class DestintationScreen extends StatefulWidget {
  const DestintationScreen({
    super.key,
  });

  @override
  State<DestintationScreen> createState() => _DestintationScreenState();
}

class _DestintationScreenState extends State<DestintationScreen> {
  List<DestinationModels> items = [];
  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  void fetchCategory() async {
    List<DestinationModels> fetchedItems =
        await DestinationDb.singleton.getDestination();
    setState(() {
      items = fetchedItems;
    });
  }

  DestinationModels? destinations;

  void deleteCountryAndShowSnackbar(String itemId) {
    DestinationDb.singleton.deleteDestination(itemId);

    // Show a Snackbar indicating that the user has been deleted
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.deleteMessage),
        duration: Duration(seconds: 2),
      ),
    );

    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.greenColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailsAddEditPage(
                    addOrEdit: 'Add',
                  ),
                ),
              ).then((result) {
                if (result == true) {
                  setState(() {
                    fetchCategory();
                  });
                }
              });
            },
            child: const Icon(Icons.add)),
        backgroundColor: const Color.fromARGB(255, 234, 227, 227),
        appBar: AppBar(
          backgroundColor: AppColors.greenColor,
          centerTitle: true,
          title: Text(
            AppStrings.destination,
            style: GoogleFonts.alata(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UsersDetailsPage()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.group, color: AppColors.greenColor),

                        AppSizedBoxes.box8,
                        // SizedBox(width: 10),
                        Text('User Details',
                            style: TextStyle(color: AppColors.blackColor)),
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
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.exit_to_app,
                            color: AppColors.greenColor),
                        SizedBox(width: screenWidth * .03),
                        const Text('Log Out',
                            style: TextStyle(color: AppColors.blackColor)),
                      ],
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: BackgroundColor(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * .04),
            child: items.isEmpty
                ?  Center(child: Text(AppStrings.destinationEmpty,style: GoogleFonts.alata(),))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: screenWidth * .05,
                        crossAxisSpacing: screenWidth * .05),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      destinations = items.isNotEmpty ? items[index] : null;
                      return GestureDetector(
                        onLongPress: () {
                          showDestinationBottomSheet(
                              context, items[index].id, items, fetchCategory,
                              () {
                            setState(() {
                              fetchCategory();
                            });
                          });
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsAddEditPage(
                                        initialitemId: items[index].id,
                                        initialCountryName:
                                            items[index].countryName,
                                        initialDescription:
                                            items[index].details,
                                        initialImagePath:
                                            items[index].countryImage,
                                        initialCountryCapital:
                                            items[index].capital,
                                        initialLanguage: items[index].language,
                                        initialcurrency: items[index].currency,
                                        initialDialCode:
                                            items[index].digitialCode,
                                        initialWeather: items[index].weather,
                                        initialImages:
                                            items[index].images.toString(),
                                        initialMajorCities:
                                            items[index].majorCities.toString(),
                                        initialknownFor:
                                            items[index].knownFor.toString(),
                                        addOrEdit: 'Edit',
                                      )));
                        },
                        child: Container(
                          height: screenWidth * 0.4,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 188, 181, 181)
                                          .withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenWidth * 0.04)),
                              color: Colors.grey),
                          child: Stack(children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.04),
                                child: destinations?.countryImage != null
                                    ? Image.file(
                                        File(destinations!.countryImage),
                                        fit: BoxFit.cover,
                                      )
                                    : Text(
                                        'No Image',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: screenWidth *
                                      0.1, // Adjust the min height as needed
                                  minWidth: screenWidth *
                                      0.1, // Adjust the min width as needed
                                  maxHeight: screenWidth *
                                      0.1, // Adjust the max height as needed
                               
                                ),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Center(
                                      child: Text(
                                    destinations!.countryName,
                                    style: GoogleFonts.alata(
                                      textStyle:  TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize:screenWidth*.05,
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            )
                          ]),
                        ),
                      );
                    }),
          ),
        ));
  }
}
