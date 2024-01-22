import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_travel_app/db/planned_trips._db.dart';
import 'package:new_travel_app/models/destination_details.dart';

import 'package:new_travel_app/models/planned_trip.dart';

import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/refractedClass/app_background.dart';
import 'package:new_travel_app/refractedClass/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted_widgets/app_sized_box.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/screen/trips/planned_trips.dart';
import 'package:new_travel_app/screen/trips/show_calender.dart';

class PlanEditTrip extends StatefulWidget {
  const PlanEditTrip({
    this.selectedItem,
    this.selectedImage,
    this.selectedPlace,
    this.tripId,
    super.key,
  });
  final DestinationModels? selectedItem;
  final String? selectedImage;
  final String? selectedPlace;
  final String? tripId;
  @override
  State<PlanEditTrip> createState() => _PlanEditTripState();
}

class _PlanEditTripState extends State<PlanEditTrip> {
  DateTime? _rangeStart;

  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    final snackBarController = AnimationController(
      vsync: ScaffoldMessenger.of(context),
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    );

    return Scaffold(
      appBar: AppBarwidget(
          title: widget.tripId != null
              ? AppStrings.editTriptitle
              : AppStrings.addTriptitle),
      body: BackgroundColor(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.tripId != null
                    ? widget.selectedPlace ?? ''
                    : 'Trip to ${widget.selectedItem!.countryName}',
                style: const TextStyle(
                    color: Constants.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(widget.tripId != null
                          ? widget.selectedImage ?? ''
                          : widget.selectedItem!.countryImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              AppSizedBoxes.box3,
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _rangeStart != null && _rangeEnd != null
                            ? '${DateFormat('dd-MMM-yyyy').format(_rangeStart!)} - ${DateFormat('dd-MMM-yyyy').format(_rangeEnd!)}'
                            : AppStrings.pickDate,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        Map<String, DateTime?>? selectedDateRange =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ShowCalender(),
                          ),
                        );

                        if (selectedDateRange != null) {
                          setState(() {
                            // _selectedDay = selectedDateRange['start'];
                            _rangeStart = selectedDateRange['start'];
                            _rangeEnd = selectedDateRange['end'];
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
              AppSizedBoxes.box3,
              ElevatedButton(
                  onPressed: () async {
                    if (_rangeStart == null || _rangeEnd == null) {
                      // Date not picked, show a SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              const Color.fromARGB(255, 232, 99, 90),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set your desired border radius
                          ),
                          behavior: SnackBarBehavior.floating,
                          animation: snackBarController,
                          onVisible: () {
                            snackBarController.forward();
                          },
                          //  action:SnackBarAction(label: label, onPressed: onPressed) ,
                          content:
                              const Text(AppStrings.snakbarErrorToDatePick),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      return; // Return early to prevent further execution
                    }
                    // Editing Trip Logic
                    if (widget.tripId != null) {
                      final String editImage = widget.selectedImage!;
                      final String editlace = widget.selectedPlace!;
                      final String editDateRange =
                          '${DateFormat('dd-MMM-yyyy').format(_rangeStart!)} - ${DateFormat('dd-MMM-yyyy').format(_rangeEnd!)}';

                      final editTrip = PlannedTripModels(
                          id: widget.tripId!,
                          date: editDateRange,
                          image: editImage,
                          place: editlace);
                      PlannedTripDb.singleton.editTrip(editTrip, editTrip.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(AppStrings.editTrip),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    // Planning Trip Logic

                    else {
                      final String image = widget.selectedItem!.countryImage;

                      final String place = widget.selectedItem!.countryName;

                      final String dateRange =
                          '${DateFormat('dd-MMM-yyyy').format(_rangeStart!)} - ${DateFormat('dd-MMM-yyyy').format(_rangeEnd!)}';
                      final planTrip = PlannedTripModels(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          date: dateRange,
                          image: image,
                          place: place);
                      PlannedTripDb.singleton.insertTrip(planTrip);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(AppStrings.planTrip),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }

                    // Navigator.pop(context);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlannedTrip(
                          selectedItem: widget.selectedItem,
                          startDate: _rangeStart!,
                          endDate: _rangeEnd!,
                        ),
                        // settings: RouteSettings(arguments: users.name),
                      ),
                    );
                  },
                  child: const Text(
                    AppStrings.save,
                    style: TextStyle(color: Constants.greenColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
