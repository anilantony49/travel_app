import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/admin/popular_destinations.dart';
import 'package:new_travel_app/db/popular_destination_db.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';

class DetailsEditPage extends StatefulWidget {
  final String initialitemId;
  final String initialCountryName;
  final String initialDescription;
  final String initialImagePath;
  final String initialImages;
  final String initialCountryCapital;
  final String initialMajorCities;
  final String initialknownFor;

  final String initialLanguage;
  final String initialcurrency;
  final String initialDialCode;
  final String initialWeather;
  final String initialPoliceNumber;
  final String initialAmbulanceNumber;
  final String initialFireNumber;

  const DetailsEditPage(
      {super.key,
      required this.initialitemId,
      required this.initialCountryName,
      required this.initialDescription,
      required this.initialImagePath,
      required this.initialCountryCapital,
      required this.initialLanguage,
      required this.initialcurrency,
      required this.initialDialCode,
      required this.initialWeather,
      required this.initialPoliceNumber,
      required this.initialAmbulanceNumber,
      required this.initialFireNumber,
      required this.initialImages,
      required this.initialMajorCities,
      required this.initialknownFor});

  @override
  State<DetailsEditPage> createState() => _DetailsEditPageState();
}

class _DetailsEditPageState extends State<DetailsEditPage> {
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
  final List<TextEditingController> _majorCitiesController = [
    TextEditingController()
  ];
  final List<TextEditingController> _knownForController = [
    TextEditingController()
  ];
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<String> categoryItems = [
    'Popular Destination',
    'Europe',
    'Africa',
    'North America',
    'South America',
    'Asia'
  ];

  String images = '';
  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
    images = selectedImages.map((image) => image.path).join(', ');
    setState(() {
      // imageFIleList = selectedImages.path;
    });
  }

  bool isExpanded = false;
  String selectedImagePath = '';
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      selectedImagePath = image.path;
    });
  }

  @override
  void initState() {
    super.initState();
    _countryNameController.text = widget.initialCountryName;
    selectedImagePath = widget.initialImagePath;
    _descriptionEditingController.text = widget.initialDescription;
    _countryCapitalController.text = widget.initialCountryCapital;
    _languageController.text = widget.initialLanguage;
    _currencyController.text = widget.initialcurrency;
    _digitalCodeController.text = widget.initialDialCode;
    _wheatherController.text = widget.initialWeather;
    _policeEmergencyController.text = widget.initialPoliceNumber;
    _ambulanceEmergencyController.text = widget.initialAmbulanceNumber;
    _fireEmergencyController.text = widget.initialFireNumber;
  }

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
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 2), // Offset in x and y axes
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
            ),
            textfields(_countryNameController, 'Country Name', null),
            textfields(
              _descriptionEditingController,
              'Description',
              isExpanded ? null : 3,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isExpanded ? 'Show more' : 'Show less',
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
                child: images.isEmpty
                    ? Image.asset(
                        'assets/image/image.jpg',
                        fit: BoxFit.fill,
                      )
                    : GridView.builder(
                        itemCount: imageFileList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            File(imageFileList[index].path),
                            fit: BoxFit.cover,
                          );
                        }),
              ),
            ),
            ListView.builder(
                itemCount: _majorCitiesController.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Padding(
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
                            // keyboardType: keyboardType,
                            // maxLines: maxLines,
                            controller: _majorCitiesController[index],
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              label: const Text(
                                'Major Cities',
                                style: TextStyle(color: Colors.black45),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            ),
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      index != 0
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  //  listController.add(TextEditingController());
                                  _majorCitiesController[index].clear();
                                  _majorCitiesController[index].dispose();
                                  _majorCitiesController.removeAt(index);
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Color(0xFF6B74D6),
                                size: 35,
                              ),
                            )
                          : const SizedBox()
                    ],
                  );
                }),
            GestureDetector(
              onTap: () {
                setState(() {
                  _majorCitiesController.add(TextEditingController());
                });
              },
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Constants.blackColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Add More",
                      style: GoogleFonts.nunito(
                        color: Colors.white70,
                      )),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ListView.builder(
                itemCount: _knownForController.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Padding(
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
                            // keyboardType: keyboardType,
                            // maxLines: maxLines,
                            controller: _knownForController[index],
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              label: const Text(
                                'Known For',
                                style: TextStyle(color: Colors.black45),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            ),
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      index != 0
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  //  listController.add(TextEditingController());
                                  _knownForController[index].clear();
                                  _knownForController[index].dispose();
                                  _knownForController.removeAt(index);
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Color(0xFF6B74D6),
                                size: 35,
                              ),
                            )
                          : const SizedBox()
                    ],
                  );
                }),
            GestureDetector(
              onTap: () {
                setState(() {
                  _knownForController.add(TextEditingController());
                });
              },
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Constants.blackColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Add More",
                      style: GoogleFonts.nunito(
                        color: Colors.white70,
                      )),
                ),
              ),
            ),
            textfields(_countryCapitalController, 'Capital', null),
            textfields(_languageController, 'Language', null),
            textfields(_currencyController, 'Currency', null),
            textfields(_digitalCodeController, 'Digital Code', null),
            // textfields(_nationalDayController, 'National Day', null),
            textfields(_wheatherController, 'weather', null),
            textfields(
                _policeEmergencyController, 'Police emergency number', null),
            textfields(_ambulanceEmergencyController,
                'Ambulance emergency number', null),
            textfields(_fireEmergencyController, 'Fire emergency number', null),
            ElevatedButton.icon(
                onPressed: () async {
                  final description = PopularDestinationModels(
                    id: widget.initialitemId,
                    description: _descriptionEditingController.text,
                    countryName: _countryNameController.text,
                    countryImage: selectedImagePath,
                    language: _languageController.text,
                    currency: _currencyController.text,
                    digitialCode: _digitalCodeController.text,
                    weather: _wheatherController.text,
                    images: imageFileList.map((image) => image.path).toList(),
                    police:
                        int.tryParse(_ambulanceEmergencyController.text) ?? 0,
                    ambulance:
                        int.tryParse(_ambulanceEmergencyController.text) ?? 0,
                    fire: int.tryParse(_fireEmergencyController.text) ?? 0,
                    capital: _countryCapitalController.text,
                    knownFor: _knownForController
                        .map((controller) => controller.text)
                        .toList(),
                    majorCities: _majorCitiesController
                        .map((controller) => controller.text)
                        .toList(),
                    // knownFor: [],
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PopularDstination(),
                      // settings: RouteSettings(arguments: users.name),
                    ),
                  );
                  PopularDestinationDb.singleton
                      .editCountry(description, description.id);
                  _descriptionEditingController.text = '';
                  _countryNameController.text = '';
                  _languageController.text = '';
                  _countryCapitalController.text = '';
                  _digitalCodeController.text = '';
                  _currencyController.text = '';
                  _wheatherController.text = '';
                  // ignore: use_build_context_synchronously
                  FocusScope.of(context).unfocus();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Details added successfully!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'))
          ],
        ),
      ),
    );
  }

  Widget textfields(
      TextEditingController controller, String label, int? maxLines) {
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
          ], // Set border radius if needed
        ),
        child: TextField(
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
              color: Colors.black.withOpacity(0.3), // Set hint text color
              // fontWeight: FontWeight.w700,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
      ),
    );
  }
}
