import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_travel_app/db/planned_trips._db.dart';
import 'package:new_travel_app/models/planned_trip.dart';
import 'package:new_travel_app/screen/trips/planned_trips.dart';
import 'package:new_travel_app/screen/trips/show_calender.dart';

class EditTrip extends StatefulWidget {
  final String? selectedImage;
  final String? selectedPlace;
   final String? tripId;

  const EditTrip({super.key, this.selectedImage, this.selectedPlace,this.tripId});

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  DateTime? _selectedDay;
  DateTime? _rangeStart;

  DateTime? _rangeEnd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Constants.greenColor,
      //   centerTitle: true,
      //   title: const Text('Edit Trip'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    File(widget.selectedImage ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _rangeStart != null && _rangeEnd != null
                          ? '${DateFormat('dd-MMM-yyyy').format(_rangeStart!)} - ${DateFormat('dd-MMM-yyyy').format(_rangeEnd!)}'
                          : 'Pick date Trip...',
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
                          _selectedDay = selectedDateRange['start'];
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
            ElevatedButton(
                onPressed: () {
                  final String image = widget.selectedImage!;

                  final String place = widget.selectedPlace!;
                  final String dateRange =
                      '${DateFormat('dd-MMM-yyyy').format(_rangeStart!)} - ${DateFormat('dd-MMM-yyyy').format(_rangeEnd!)}';
                  final editTrip = PlannedTripModels(
                      id:  widget.tripId!,
                      date: dateRange,
                      image: image,
                      place: place);
                  PlannedTripDb.singleton.editTrip(editTrip, editTrip.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Trip Edit successfully!'),
                      duration: Duration(seconds: 3),
                    ),
                  );

                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlannedTrip(
                        startDate: _rangeStart!,
                        endDate: _rangeEnd!,
                      ),
                      // settings: RouteSettings(arguments: users.name),
                    ),
                  );
                },
                child: const Text('Edit')),
          ],
        ),
      ),
    );
  }
}
