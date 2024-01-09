import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/admin/africa.dart';
import 'package:new_travel_app/admin/europe.dart';
import 'package:new_travel_app/admin/popular_destinations.dart';
import 'package:new_travel_app/db/africa_db.dart';
import 'package:new_travel_app/db/asia_db.dart';
import 'package:new_travel_app/db/europe_db.dart';
import 'package:new_travel_app/db/north_america_db.dart';
import 'package:new_travel_app/db/popular_destination_db.dart';
import 'package:new_travel_app/db/south_america_db.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/asia.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/north_america.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/models/south_america.dart';

void addDetails(
  BuildContext context,
  String category,
  String countryName,
  String initialItemId,
  String initialCountryName,
  String initialDescription,
  String initialImagePath,
  String initialImages,
  String initialCountryCapital,
  String initialMajorCities,
  String initialknownFor,
  String initialLanguage,
  String initialcurrency,
  String initialDialCode,
  String initialWeather,
  String initialPoliceNumber,
  String initialAmbulanceNumber,
  String initialFireNumber,
  TextEditingController descriptionEditingController,
  TextEditingController countryNameController,
  TextEditingController languageController,
  TextEditingController currencyController,
  TextEditingController digitalCodeController,
  TextEditingController wheatherController,
  TextEditingController countryCapitalController,
  TextEditingController policeEmergencyController,
  TextEditingController ambulanceEmergencyController,
  TextEditingController fireEmergencyController,
  List<TextEditingController> majorCitiesController,
  List<TextEditingController> knownForController,
  List<XFile> imageFileList,
  String selectedImagePath,
  String images,
) {
  final description = category == 'Europe'
      ? EuropeDestinationModels(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          majorCities: majorCitiesController
              .map((controller) => controller.text)
              .toList(),
          description: descriptionEditingController.text,
          countryName: countryNameController.text,
          countryImage: selectedImagePath,
          language: languageController.text,
          currency: currencyController.text,
          digitialCode: digitalCodeController.text,
          weather: wheatherController.text,
          images: imageFileList.map((image) => image.path).toList(),
          police: int.tryParse(ambulanceEmergencyController.text) ?? 0,
          ambulance: int.tryParse(ambulanceEmergencyController.text) ?? 0,
          fire: int.tryParse(fireEmergencyController.text) ?? 0,
          capital: countryCapitalController.text,
          knownFor:
              knownForController.map((controller) => controller.text).toList(),
        )
      : category == 'Africa'
          ? AfricaDestinationModels(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              countryName: countryNameController.text,
              countryImage: selectedImagePath,
              description: descriptionEditingController.text,
              capital: countryCapitalController.text,
              images: imageFileList.map((image) => image.path).toList(),
              language: languageController.text,
              currency: currencyController.text,
              digitialCode: digitalCodeController.text,
              weather: wheatherController.text,
              police: int.tryParse(ambulanceEmergencyController.text) ?? 0,
              ambulance: int.tryParse(ambulanceEmergencyController.text) ?? 0,
              fire: int.tryParse(fireEmergencyController.text) ?? 0,
              knownFor: knownForController
                  .map((controller) => controller.text)
                  .toList(),
              majorCities: majorCitiesController
                  .map((controller) => controller.text)
                  .toList(),
            )
          : category == 'South America'
              ? SouthAmericaDestinationModels(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  countryName: countryNameController.text,
                  countryImage: selectedImagePath,
                  description: descriptionEditingController.text,
                  capital: countryCapitalController.text,
                  images: imageFileList.map((image) => image.path).toList(),
                  language: languageController.text,
                  currency: currencyController.text,
                  digitialCode: digitalCodeController.text,
                  weather: wheatherController.text,
                  police: int.tryParse(ambulanceEmergencyController.text) ?? 0,
                  ambulance:
                      int.tryParse(ambulanceEmergencyController.text) ?? 0,
                  fire: int.tryParse(fireEmergencyController.text) ?? 0,
                  knownFor: knownForController
                      .map((controller) => controller.text)
                      .toList(),
                  majorCities: majorCitiesController
                      .map((controller) => controller.text)
                      .toList(),
                )
              : category == 'North America'
                  ? NorthAmericaDestinationModels(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      countryName: countryNameController.text,
                      countryImage: selectedImagePath,
                      description: descriptionEditingController.text,
                      capital: countryCapitalController.text,
                      images: imageFileList.map((image) => image.path).toList(),
                      language: languageController.text,
                      currency: currencyController.text,
                      digitialCode: digitalCodeController.text,
                      weather: wheatherController.text,
                      police:
                          int.tryParse(ambulanceEmergencyController.text) ?? 0,
                      ambulance:
                          int.tryParse(ambulanceEmergencyController.text) ?? 0,
                      fire: int.tryParse(fireEmergencyController.text) ?? 0,
                      knownFor: knownForController
                          .map((controller) => controller.text)
                          .toList(),
                      majorCities: majorCitiesController
                          .map((controller) => controller.text)
                          .toList(),
                    )
                  : category == 'Asia'
                      ? AsiaDestinationModels(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          countryName: countryNameController.text,
                          countryImage: selectedImagePath,
                          description: descriptionEditingController.text,
                          capital: countryCapitalController.text,
                          images:
                              imageFileList.map((image) => image.path).toList(),
                          language: languageController.text,
                          currency: currencyController.text,
                          digitialCode: digitalCodeController.text,
                          weather: wheatherController.text,
                          police:
                              int.tryParse(ambulanceEmergencyController.text) ??
                                  0,
                          ambulance:
                              int.tryParse(ambulanceEmergencyController.text) ??
                                  0,
                          fire: int.tryParse(fireEmergencyController.text) ?? 0,
                          knownFor: knownForController
                              .map((controller) => controller.text)
                              .toList(),
                          majorCities: majorCitiesController
                              .map((controller) => controller.text)
                              .toList(),
                        )
                      : PopularDestinationModels(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          description: descriptionEditingController.text,
                          countryName: countryNameController.text,
                          countryImage: selectedImagePath,
                          language: languageController.text,
                          currency: currencyController.text,
                          digitialCode: digitalCodeController.text,
                          weather: wheatherController.text,
                          images:
                              imageFileList.map((image) => image.path).toList(),
                          police:
                              int.tryParse(ambulanceEmergencyController.text) ??
                                  0,
                          ambulance:
                              int.tryParse(ambulanceEmergencyController.text) ??
                                  0,
                          fire: int.tryParse(fireEmergencyController.text) ?? 0,
                          capital: countryCapitalController.text,
                          knownFor: knownForController
                              .map((controller) => controller.text)
                              .toList(),
                          majorCities: majorCitiesController
                              .map((controller) => controller.text)
                              .toList(),
                        );
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => category == 'Europe'
          ? const EuropePage()
          : category == 'Africa'
              ? const AfricaPage()
              : const PopularDstination(),
    ),
  );
  if (category == 'Europe') {
    EuropeDb.singleton.insertCountry(description as EuropeDestinationModels);
  } else if (category == 'Africa') {
    AfricaDb.singleton.insertCountry(description as AfricaDestinationModels);
  } else if (category == 'South America') {
    SouthAmericaDb.singleton
        .insertCountry(description as SouthAmericaDestinationModels);
  } else if (category == 'North America') {
    NorthAmericaDb.singleton
        .insertCountry(description as NorthAmericaDestinationModels);
  } else if (category == 'Asia') {
    AsiaDb.singleton.insertCountry(description as AsiaDestinationModels);
  } else {
    PopularDestinationDb.singleton
        .insertCountry(description as PopularDestinationModels);
  }
  descriptionEditingController.text = '';
  countryNameController.text = '';
  countryCapitalController.text = '';
  currencyController.text = '';
  digitalCodeController.text = '';
  languageController.text = '';
  wheatherController.text = '';
  policeEmergencyController.text = '';
  ambulanceEmergencyController.text = '';
  fireEmergencyController.text = '';

  FocusScope.of(context).unfocus();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Details added successfully!'),
      duration: Duration(seconds: 3),
    ),
  );
}
