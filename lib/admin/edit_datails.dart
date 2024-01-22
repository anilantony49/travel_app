import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/db/destination_details_db.dart';
import 'package:new_travel_app/models/destination_details.dart';

void editDetails(
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
    id: initialItemId,
    countryName: countryNameController.text,
    countryImage: selectedImagePath,
    details: descriptionEditingController.text,
    capital: countryCapitalController.text,
    knownFor: knownForController.map((controller) => controller.text).toList(),
    images: imageFileList.map((image) => image.path).toList(),
    majorCities:
        majorCitiesController.map((controller) => controller.text).toList(),
    language: languageController.text,
    currency: currencyController.text,
    digitialCode: digitalCodeController.text,
    weather: wheatherController.text,
    categories: selectedCategories!,
    rating: ratingValue!,
    police: int.tryParse(ambulanceEmergencyController.text) ?? 0,
    ambulance: int.tryParse(ambulanceEmergencyController.text) ?? 0,
    fire: int.tryParse(fireEmergencyController.text) ?? 0,
  );
  DestinationDb.singleton.editDestination(description, description.id);

  Navigator.pop(context);

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
  // ignore: use_build_context_synchronously
  FocusScope.of(context).unfocus();
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Details Edit successfully!'),
      duration: Duration(seconds: 2),
    ),
  );
}
