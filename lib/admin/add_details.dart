import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/admin/destinations_screen.dart';
import 'package:new_travel_app/db/destination_details_db.dart';
import 'package:new_travel_app/models/destination_details.dart';

void addDetails(
    BuildContext context,
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
    String? selectedCategories,
    double? ratingValue) {
  final description = DestinationModels(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    countryName: countryNameController.text,
    countryImage: selectedImagePath,
    knownFor: knownForController.map((controller) => controller.text).toList(),
    majorCities:
        majorCitiesController.map((controller) => controller.text).toList(),
    language: languageController.text,
    currency: currencyController.text,
    digitialCode: digitalCodeController.text,
    weather: wheatherController.text,
    details: descriptionEditingController.text,
    categories: selectedCategories!,
    rating: ratingValue!,
    images: imageFileList.map((image) => image.path).toList(),
    capital: countryCapitalController.text,
  );

  DestinationDb.singleton.insertDestination(description);
// Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DestintationScreen()));
  // Navigator.pop(context);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const DestintationScreen()),
  );

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
