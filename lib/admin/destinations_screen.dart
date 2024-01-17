import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/detalis_add_edit_page.dart';
import 'package:new_travel_app/admin/user_details_page.dart';
import 'package:new_travel_app/db/destination_details_db.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/authentication/authentication_page.dart';

class DestintationScreen extends StatefulWidget {
  const DestintationScreen ({
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
        content: Text('Country deleted successfully'),
        duration: Duration(seconds: 3),
      ),
    );

    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Constants.greenColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DetailsAddEditPage(
                            addOrEdit: 'Add',
                          )));
            },
            child: const Icon(Icons.add)),
        backgroundColor: const Color.fromARGB(255, 234, 227, 227),
        appBar: AppBar(
          backgroundColor: Constants.greenColor,
          centerTitle: true,
          title: const Text(
            'Destinations',
            style: TextStyle(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                destinations = items.isNotEmpty ? items[index] : null;
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
                                                    items[index].details,
                                                initialImagePath:
                                                    items[index].countryImage,
                                                initialCountryCapital:
                                                    items[index].capital,
                                                initialLanguage:
                                                    items[index].language,
                                                initialcurrency:
                                                    items[index].currency,
                                                initialDialCode:
                                                    items[index].digitialCode,
                                                initialWeather:
                                                    items[index].weather,
                                                initialImages: items[index]
                                                    .images
                                                    .toString(),
                                                initialMajorCities: items[index]
                                                    .majorCities
                                                    .toString(),
                                                initialknownFor: items[index]
                                                    .knownFor
                                                    .toString(),
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
                                  deleteCountryAndShowSnackbar(items[index].id);
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
                                  initialDescription: items[index].details,
                                  initialImagePath: items[index].countryImage,
                                  initialCountryCapital: items[index].capital,
                                  initialLanguage: items[index].language,
                                  initialcurrency: items[index].currency,
                                  initialDialCode: items[index].digitialCode,
                                  initialWeather: items[index].weather,
                                  initialImages: items[index].images.toString(),
                                  initialMajorCities:
                                      items[index].majorCities.toString(),
                                  initialknownFor:
                                      items[index].knownFor.toString(),
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
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Transform.translate(
                        offset: Offset(15, -(screenWidth * 0.04)),
                        child: Center(
                          child: Text(
                            destinations!.countryName,
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
        ));
  }
}
