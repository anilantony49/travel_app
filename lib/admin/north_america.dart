import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/detalis_add_edit_page.dart';
import 'package:new_travel_app/admin/side_menu_bar.dart';
import 'package:new_travel_app/admin/user_details_page.dart';
import 'package:new_travel_app/db/north_america_db.dart';
import 'package:new_travel_app/models/north_america.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/authentication/authentication_page.dart';

class NorthAmericaPage extends StatefulWidget {
  const NorthAmericaPage({super.key});

  @override
  State<NorthAmericaPage> createState() => _NorthAmericaPageState();
}

class _NorthAmericaPageState extends State<NorthAmericaPage> {
  List<NorthAmericaDestinationModels> items = [];
  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  void fetchCategory() async {
    List<NorthAmericaDestinationModels> fetchedItems =
        await NorthAmericaDb.singleton.getCountries();
    setState(() {
      items = fetchedItems;
    });
  }

  NorthAmericaDestinationModels? northAmerica;
  void deleteCountryAndShowSnackbar(String itemId) {
    NorthAmericaDb.singleton.deleteCountry(itemId);

    // Show a Snackbar indicating that the user has been deleted
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Category deleted successfully'),
        duration: Duration(seconds: 3),
      ),
    );

    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final String title =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'Category';

    return Scaffold(
      drawer: const SideMenuBar(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.greenColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailsAddEditPage(
                          category: 'North America',
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UsersDetailsPage()),
                    );
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
      body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                northAmerica = items.isNotEmpty ? items[index] : null;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsAddEditPage(
                                                initialitemId: items[index].id,
                                                initialCountryName:
                                                    items[index].countryName,
                                                initialDescription:
                                                    items[index].description,
                                                initialImagePath:
                                                    items[index].countryImage,
                                                initialCountryCapital:
                                                    items[index].capital,
                                                initialFireNumber: items[index]
                                                    .fire
                                                    .toString(),
                                                initialAmbulanceNumber:
                                                    items[index]
                                                        .ambulance
                                                        .toString(),
                                                initialLanguage:
                                                    items[index].language,
                                                initialcurrency:
                                                    items[index].currency,
                                                initialDialCode:
                                                    items[index].digitialCode,
                                                initialWeather:
                                                    items[index].weather,
                                                initialPoliceNumber:
                                                    items[index]
                                                        .police
                                                        .toString(),
                                                initialImages: items[index]
                                                    .images
                                                    .toString(),
                                                initialMajorCities: items[index]
                                                    .majorCities
                                                    .toString(),
                                                initialknownFor: items[index]
                                                    .knownFor
                                                    .toString(),
                                                category: 'North America',
                                                addOrEdit: 'Edit',
                                              )));
                                  // Navigator.pop(context);
                                },
                                leading: const Icon(Icons.edit_square,
                                    color: Constants.greenColor),
                                title: const Text('Edit item',
                                    style:
                                        TextStyle(color: Constants.blackColor)),
                              ),
                              ListTile(
                                onTap: () {
                                  deleteCountryAndShowSnackbar(
                                      items[index].id);
                                  Navigator.pop(context);
                                },
                                leading: const Icon(Icons.delete,
                                    color: Constants.greenColor),
                                title: const Text('Delete item',
                                    style:
                                        TextStyle(color: Constants.blackColor)),
                              ),
                            ],
                          );
                        });
                  },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsAddEditPage(
                                  initialitemId: items[index].id,
                                  initialCountryName: items[index].countryName,
                                  initialDescription: items[index].description,
                                  initialImagePath: items[index].countryImage,
                                  initialCountryCapital: items[index].capital,
                                  initialLanguage: items[index].language,
                                  initialcurrency: items[index].currency,
                                  initialDialCode: items[index].digitialCode,
                                  initialWeather: items[index].weather,
                                  initialPoliceNumber:
                                      items[index].police.toString(),
                                  initialAmbulanceNumber:
                                      items[index].ambulance.toString(),
                                  initialFireNumber:
                                      items[index].fire.toString(),
                                  initialImages: items[index].images.toString(),
                                  initialMajorCities:
                                      items[index].majorCities.toString(),
                                  initialknownFor:
                                      items[index].knownFor.toString(),
                                  category: 'North America',
                                  addOrEdit: 'Edit',
                                )));
                  },
                  child: Stack(children: [
                    Container(
                      height: screenWidth * 0.4,
                      width: screenWidth * 0.4,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 188, 181, 181)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth * 0.04)),
                          color: Colors.grey),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        child: northAmerica?.countryImage != null
                            ? Image.file(
                                File(northAmerica!.countryImage),
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
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Transform.translate(
                        offset: Offset(15, -(screenWidth * 0.04)),
                        child: Center(
                          child: Text(
                            northAmerica!.countryName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.055,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              }),
        )
    );
  }
}
