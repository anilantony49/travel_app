import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/admin/europe.dart';
import 'package:new_travel_app/admin/popular_destinations.dart';
import 'package:new_travel_app/db/europe_db.dart';
import 'package:new_travel_app/db/popular_destination_db.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';

class DetailsAddPage extends StatefulWidget {
  final String category;

  const DetailsAddPage({required this.category, Key? key}) : super(key: key);

  @override
  State<DetailsAddPage> createState() => _DetailsAddPageState();
}

class _DetailsAddPageState extends State<DetailsAddPage> {
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _digitalCodeController = TextEditingController();
  final TextEditingController _wheatherController = TextEditingController();
  final TextEditingController _countryCapitalController =
      TextEditingController();
  final TextEditingController _policeEmergencyController =
      TextEditingController();
  final TextEditingController _ambulanceEmergencyController =
      TextEditingController();
  final TextEditingController _fireEmergencyController =
      TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  bool isExpanded = false;
  String selectedImagePath = '';
  String images = '';

  @override
  Widget build(BuildContext context) {
    final countryName = ModalRoute.of(context)?.settings.arguments as String? ??
        'Default Category';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.greenColor,
        title: Text(countryName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickImage(context, ImageSource.gallery);
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Constants.greenColor,
                    width: 4.0,
                  ),
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: selectedImagePath.isEmpty
                    ? Image.asset(
                        'assets/image/image.jpg',
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        File(selectedImagePath),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            textfields(
              _countryNameController,
              'Country Name',
              null,
              null,
            ),
            textfields(
              _descriptionEditingController,
              'Description',
              isExpanded ? null : 3,
              null,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    isExpanded ? 'Show less' : 'Show more',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                selectImages();
              },
              child: Container(
                width: 350,
                height: 300,
                decoration: const BoxDecoration(color: Colors.grey),
                child: GridView.builder(
                  itemCount: imageFileList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(imageFileList[index].path),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            textfields(
              _countryCapitalController,
              'Capital',
              null,
              null,
            ),
            textfields(
              _languageController,
              'Language',
              null,
              null,
            ),
            textfields(
              _currencyController,
              'Currency',
              null,
              null,
            ),
            textfields(
              _digitalCodeController,
              'Dial Code',
              null,
              null,
            ),
            textfields(
              _wheatherController,
              'weather',
              null,
              null,
            ),
            textfields(
              _policeEmergencyController,
              'Police emergency number',
              null,
              TextInputType.number,
            ),
            textfields(
              _ambulanceEmergencyController,
              'Ambulance emergency number',
              null,
              TextInputType.number,
            ),
            textfields(
              _fireEmergencyController,
              'Fire emergency number',
              null,
              TextInputType.number,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final description = widget.category == 'Europe'
                    ? EuropeDestinationModels(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        description: _descriptionEditingController.text,
                        countryName: _countryNameController.text,
                        countryImage: selectedImagePath,
                        language: _languageController.text,
                        currency: _currencyController.text,
                        digitialCode: _digitalCodeController.text,
                        weather: _wheatherController.text,
                        images:
                            imageFileList.map((image) => image.path).toList(),
                        police:
                            int.tryParse(_ambulanceEmergencyController.text) ??
                                0,
                        ambulance:
                            int.tryParse(_ambulanceEmergencyController.text) ??
                                0,
                        fire: int.tryParse(_fireEmergencyController.text) ?? 0,
                        capital: _countryCapitalController.text,
                      )
                    : PopularDestinationModels(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        description: _descriptionEditingController.text,
                        countryName: _countryNameController.text,
                        countryImage: selectedImagePath,
                        language: _languageController.text,
                        currency: _currencyController.text,
                        digitialCode: _digitalCodeController.text,
                        weather: _wheatherController.text,
                        images:
                            imageFileList.map((image) => image.path).toList(),
                        police:
                            int.tryParse(_ambulanceEmergencyController.text) ??
                                0,
                        ambulance:
                            int.tryParse(_ambulanceEmergencyController.text) ??
                                0,
                        fire: int.tryParse(_fireEmergencyController.text) ?? 0,
                        capital: _countryCapitalController.text,
                      );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.category == 'Europe'
                        ? const EuropePage()
                        : const PopularDstination(),
                  ),
                );

                if (widget.category == 'Europe') {
                  EuropeDb.singleton
                      .insertCountry(description as EuropeDestinationModels);
                } else {
                  PopularDestinationDb.singleton
                      .insertCountry(description as PopularDestinationModels);
                }

                _descriptionEditingController.text = '';
                _countryNameController.text = '';
                _countryCapitalController.text = '';
                _currencyController.text = '';
                _digitalCodeController.text = '';
                _languageController.text = '';
                _wheatherController.text = '';
                _policeEmergencyController.text = '';
                _ambulanceEmergencyController.text = '';
                _fireEmergencyController.text = '';

                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Details added successfully!'),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget textfields(TextEditingController controller, String label,
      int? maxLines, TextInputType? keyboardType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          controller: controller,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            label: Text(
              label,
              style: const TextStyle(color: Colors.black45),
            ),
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.3),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
      ),
    );
  }

  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      selectedImagePath = image.path;
    });
  }

  void selectImages() async {
    List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    images = selectedImages.map((image) => image.path).join(', ');
    setState(() {
      images = images;
    });
  }
}
