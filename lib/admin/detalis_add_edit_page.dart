import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/admin/add_details.dart';
import 'package:new_travel_app/admin/edit_datails.dart';
import 'package:new_travel_app/db/category_db.dart';
import 'package:new_travel_app/models/category.dart';
import 'package:new_travel_app/others/textfields.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_widgets/app_sized_box.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/widgets/image_pick_box.dart';

class DetailsAddEditPage extends StatefulWidget {
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
      initialFireNumber,
      addOrEdit;

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
      this.addOrEdit});

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
  String selectedCategories = AppStrings.popularDestination;
  double ratingValue = 0;

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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.greenColor,
        title: Text(
            widget.addOrEdit == 'Add' ? 'Add Destination' : 'Edit Destination'),
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
      body: BackgroundColor(
        child: SingleChildScrollView(
          child: Column(
            children: [
              imageBox(context, pickImage, selectedImagePath),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: screenWidth * .015),
                        child: Text(
                          AppStrings.selectCategory,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * .04,
                            ),
                          ),
                          // style: Apptext.text2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * .04),
                        child: Container(
                          padding: EdgeInsets.only(left: screenWidth * .05),
                          decoration: BoxDecoration(
                              color: AppColors.borderColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            underline: Container(),
                            value: selectedCategories,
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(
                              color: AppColors.blackColor,
                            ),
                            items: dropdownItems.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      _showDeleteCategoryDialog(
                                        context,
                                        value,
                                      );
                                    },
                                    child: Text(value),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategories = newValue.toString();
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: screenWidth * .017),
                        child: Text(
                          AppStrings.rating,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * .04,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * .03),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.width * .12,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: AppColors.borderColor,
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
                                minRating: 1,
                                initialRating: 3,
                                allowHalfRating: true,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: AppColors.rating,
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: AppColors.rating,
                                  ),
                                  empty: const Icon(
                                    Icons.star_border,
                                    color: AppColors.rating,
                                  ),
                                ),
                                onRatingUpdate: (rating) {
                                  ratingValue = rating;
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(_countryNameController, 'Country Name', 1,
                    TextInputType.name),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: textfields(
                  _descriptionEditingController,
                  'Description',
                  isExpanded ? null : 2,
                  TextInputType.name,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * .03),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: screenWidth * .03),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        isExpanded ? 'Show less' : 'Show more',
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectImages();
                },
                child: Container(
                  width: screenWidth * .95,
                  height: screenWidth * .32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                      color: AppColors.borderColor),
                  child: Stack(children: [
                    GridView.builder(
                      itemCount: imageFileList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius:
                              BorderRadius.circular(screenWidth * .03),
                          child: Image.file(
                            File(imageFileList[index].path),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    if (imageFileList.isEmpty)
                      const Positioned.fill(
                        child: Center(
                          child: Text('Add Pictures'),
                        ),
                      ),
                  ]),
                ),
              ),
              AppSizedBoxes.box5,
              ListView.builder(
                itemCount: _majorCitiesController.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * .03),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.borderColor,
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * .03),
                                    child: TextField(
                                      controller: _majorCitiesController[index],
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        label: const Text(
                                          'Major Cities',
                                          style: TextStyle(
                                              color: AppColors.blackColor),
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _majorCitiesController
                                        .add(TextEditingController());
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    _majorCitiesController[index].clear();
                                    _majorCitiesController[index].dispose();
                                    _majorCitiesController.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              ListView.builder(
                itemCount: _knownForController.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * .03),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.borderColor,
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * .03),
                                    child: TextField(
                                      controller: _knownForController[index],
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        label: const Text(
                                          'Known For',
                                          style: TextStyle(
                                              color: AppColors.blackColor),
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _knownForController
                                        .add(TextEditingController());
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    _knownForController[index].clear();
                                    _knownForController[index].dispose();
                                    _knownForController.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(_countryCapitalController, 'Capital', 1),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(_languageController, 'Language', 1),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(_currencyController, 'Currency', 1),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(
                    _digitalCodeController, 'Dial Code', 1, TextInputType.name),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(
                    _wheatherController, 'weather', 5, TextInputType.name),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(
                  _policeEmergencyController,
                  'Police emergency number',
                  1,
                  TextInputType.number,
                ),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(
                  _ambulanceEmergencyController,
                  'Ambulance emergency number',
                  1,
                  TextInputType.number,
                ),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: textfields(
                  _fireEmergencyController,
                  'Fire emergency number',
                  1,
                  TextInputType.number,
                ),
              ),
              AppSizedBoxes.box5,
              Padding(
                padding: EdgeInsets.all(screenWidth * .03),
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.greenColor,
                      ), // Set your desired background color
                    ),
                    onPressed: () async {
                      if (selectedImagePath.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an image.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        widget.addOrEdit == 'Add'
                            ? addDetails(
                                context,
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
                                widget.initialitemId!,
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
                      }
                    },
                    icon: Icon(
                      (widget.addOrEdit == 'Add' ? Icons.save : Icons.edit),
                      color: AppColors.blackColor,
                    ),
                    label: Text(
                      widget.addOrEdit == 'Add' ? 'Add' : 'Edit',
                      style: const TextStyle(color: AppColors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteCategoryDialog(
      BuildContext context, String currentCategory) async {
    TextEditingController editingController =
        TextEditingController(text: currentCategory);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: TextField(
            controller: editingController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteCategoryAndShowSnackbar(currentCategory);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void deleteCategoryAndShowSnackbar(String id) async {
    await CategoryDb.singleton.deleteCategory(id);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('category deleted successfully'),
        duration: Duration(seconds: 2),
      ),
    );
    setState(() {
      dropdownItems.remove(id); // Update dropdown items directly
      selectedCategories = dropdownItems.first;
      // FocusScope.of(context).unfocus();
    });

    fetchCategory();
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
