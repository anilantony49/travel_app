import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/admin/add_details.dart';
import 'package:new_travel_app/admin/edit_datails.dart';
import 'package:new_travel_app/db/category_db.dart';
import 'package:new_travel_app/models/category.dart';

import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/others/textfields.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';

class DetailsAddEditPage extends StatefulWidget {
  final String addOrEdit;

  final String? initialitemId,
      initialCountryName,
      initialDescription,
      initialImagePath,
      initialImages,
      initialCountryCapital,
      initialMajorCities,
      initialknownFor,
      initialLanguage,
      initialcurrency,
      initialDialCode,
      initialWeather,
      initialPoliceNumber,
      initialAmbulanceNumber,
      initialFireNumber;

  const DetailsAddEditPage(
      {super.key,
      this.initialitemId,
      this.initialCountryName,
      this.initialDescription,
      this.initialImagePath,
      this.initialCountryCapital,
      this.initialLanguage,
      this.initialcurrency,
      this.initialDialCode,
      this.initialWeather,
      this.initialPoliceNumber,
      this.initialAmbulanceNumber,
      this.initialFireNumber,
      this.initialImages,
      this.initialMajorCities,
      this.initialknownFor,
      required this.addOrEdit});

  @override
  State<DetailsAddEditPage> createState() => _DetailsAddEditPageState();
}

class _DetailsAddEditPageState extends State<DetailsAddEditPage> {
  final TextEditingController _addCategoryController = TextEditingController();
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

  bool isExpanded = false;

  String selectedImagePath = '';
  String images = '';
  String? selectedCategories = AppStrings.popularDestination;
  double? ratingValue = 0;

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

  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      selectedImagePath = image.path;
    });
  }

  List<CategoryModels> items = [];

  @override
  void initState() {
    super.initState();
    _countryNameController.text = widget.initialCountryName ?? '';
    selectedImagePath = widget.initialImagePath ?? '';
    _descriptionEditingController.text = widget.initialDescription ?? '';
    _countryCapitalController.text = widget.initialCountryCapital ?? '';
    _languageController.text = widget.initialLanguage ?? '';
    _currencyController.text = widget.initialcurrency ?? '';
    _digitalCodeController.text = widget.initialDialCode ?? '';
    _wheatherController.text = widget.initialWeather ?? '';
    _policeEmergencyController.text = widget.initialPoliceNumber ?? '';
    _ambulanceEmergencyController.text = widget.initialAmbulanceNumber ?? '';
    _fireEmergencyController.text = widget.initialFireNumber ?? '';

    if (widget.initialMajorCities != null) {
      _majorCitiesController.clear();
      _majorCitiesController.addAll(
        widget.initialMajorCities!
            .split(',')
            .map((city) => TextEditingController(text: city)),
      );
    }
    if (widget.initialknownFor != null) {
      _knownForController.clear();
      _knownForController.addAll(
        widget.initialknownFor!
            .split(',')
            .map((knownFor) => TextEditingController(text: knownFor)),
      );
    }
    fetchCategory();
  }

  void fetchCategory() async {
    List<dynamic> fetchedItems;
    fetchedItems = await CategoryDb.singleton.getCategory();
    setState(() {
      items = fetchedItems.cast<CategoryModels>();
      updateDropdownItems();
    });
  }

  void updateDropdownItems() {
    List<String> combinedItems = [
      for (var item in items) item.category,
      ...dropdownItems,
    ];
    dropdownItems = combinedItems;
  }

  Future<bool> doesFileExist(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  List<String> dropdownItems = [
    AppStrings.popularDestination,
    AppStrings.europe,
    AppStrings.africa,
    AppStrings.northAmerica,
    AppStrings.southAmerica,
    AppStrings.asia,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.greenColor,
        title: const Text('Category'),
        actions: [
          IconButton(
            onPressed: () {
              _showAddCategoryDialog(context);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add Category',
          )
        ],
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
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Column(
                  children: [
                    const Text('Select category'),
                    Container(
                      // width: MediaQuery.of(context).size.width * .30,
                      // height: MediaQuery.of(context).size.width * .13,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: AppColor.whiteOpacity,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: selectedCategories,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                        items: dropdownItems.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (String? newVlues) {
                          setState(() {
                            selectedCategories = newVlues.toString();
                          });
                        },
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        AppStrings.rating,
                        // style: Apptext.text2,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .40,
                      height: MediaQuery.of(context).size.width * .13,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: AppColor.whiteOpacity,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14, left: 10),
                        child: RatingBar(
                            itemPadding: const EdgeInsets.symmetric(
                              horizontal: 1,
                            ),
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 20,
                            minRating: 3,
                            initialRating: 3,
                            allowHalfRating: true,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: Colors.amber,
                              ),
                              empty: const Icon(
                                Icons.star_border,
                                color: Colors.amber,
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              ratingValue = rating;
                            }),
                      ),
                    )
                  ],
                ),
              ],
            ),
            textfields(
              _countryNameController,
              'Country Name',
              1,
              null,
            ),
            textfields(
              _descriptionEditingController,
              'Description',
              isExpanded ? null : 2,
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
            const SizedBox(
              width: 10,
            ),
            textfields(
              _countryCapitalController,
              'Capital',
              1,
              null,
            ),
            textfields(
              _languageController,
              'Language',
              1,
              null,
            ),
            textfields(
              _currencyController,
              'Currency',
              1,
              null,
            ),
            textfields(
              _digitalCodeController,
              'Dial Code',
              1,
              null,
            ),
            textfields(
              _wheatherController,
              'weather',
              10,
              null,
            ),
            textfields(
              _policeEmergencyController,
              'Police emergency number',
              1,
              TextInputType.number,
            ),
            textfields(
              _ambulanceEmergencyController,
              'Ambulance emergency number',
              1,
              TextInputType.number,
            ),
            textfields(
              _fireEmergencyController,
              'Fire emergency number',
              1,
              TextInputType.number,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  widget.addOrEdit == 'Add'
                      ? addDetails(
                          context,
                          widget.addOrEdit,
                          widget.initialitemId ?? '',
                          widget.initialCountryName ?? '',
                          widget.initialDescription ?? '',
                          widget.initialImagePath ?? '',
                          widget.initialImages ?? '',
                          widget.initialCountryCapital ?? '',
                          widget.initialMajorCities ?? '',
                          widget.initialknownFor ?? '',
                          widget.initialLanguage ?? '',
                          widget.initialcurrency ?? '',
                          widget.initialDialCode ?? '',
                          widget.initialWeather ?? '',
                          widget.initialPoliceNumber ?? '',
                          widget.initialAmbulanceNumber ?? '',
                          widget.initialFireNumber ?? '',
                          _descriptionEditingController,
                          _countryNameController,
                          _languageController,
                          _currencyController,
                          _digitalCodeController,
                          _wheatherController,
                          _countryCapitalController,
                          _policeEmergencyController,
                          _ambulanceEmergencyController,
                          _fireEmergencyController,
                          _majorCitiesController,
                          _knownForController,
                          imageFileList,
                          selectedImagePath,
                          images,
                          selectedCategories,
                          ratingValue)
                      : editDetails(
                          context,
                          widget.addOrEdit,
                          widget.initialitemId ?? '',
                          widget.initialCountryName ?? '',
                          widget.initialDescription ?? '',
                          widget.initialImagePath ?? '',
                          widget.initialImages ?? '',
                          widget.initialCountryCapital ?? '',
                          widget.initialMajorCities ?? '',
                          widget.initialknownFor ?? '',
                          widget.initialLanguage ?? '',
                          widget.initialcurrency ?? '',
                          widget.initialDialCode ?? '',
                          widget.initialWeather ?? '',
                          widget.initialPoliceNumber ?? '',
                          widget.initialAmbulanceNumber ?? '',
                          widget.initialFireNumber ?? '',
                          _descriptionEditingController,
                          _countryNameController,
                          _languageController,
                          _currencyController,
                          _digitalCodeController,
                          _wheatherController,
                          _countryCapitalController,
                          _policeEmergencyController,
                          _ambulanceEmergencyController,
                          _fireEmergencyController,
                          _majorCitiesController,
                          _knownForController,
                          imageFileList,
                          selectedImagePath,
                          images,
                          selectedCategories,
                          ratingValue);
                },
                icon: const Icon(Icons.save),
                label: Text(widget.addOrEdit == 'Add' ? 'Add' : 'Edit'))
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'New Category',
            ),
            controller: _addCategoryController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                String newCategory = _addCategoryController.text;
                setState(() {
                  dropdownItems.add(newCategory);
                  selectedCategories = newCategory;
                });
                final addCategory = CategoryModels(
                  category: newCategory,
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                );
                CategoryDb.singleton.insertCategory(addCategory);
                updateDropdownItems();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
