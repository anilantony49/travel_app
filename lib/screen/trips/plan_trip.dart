import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_travel_app/db/planned_trips._db.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/asia.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/north_america.dart';
import 'package:new_travel_app/models/planned_trip.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/models/south_america.dart';
import 'package:new_travel_app/screen/trips/planned_trips.dart';
import 'package:new_travel_app/screen/trips/show_calender.dart';

class PlanTrip extends StatefulWidget {
  const PlanTrip({
    this.selectedItem,
    this.selectedEuropeItem,
    super.key,
    this.category,
    this.selectedAfricaItem,
    this.selectedSouthAmericaItem,
    this.selectedNorthAmericaItem,
    this.selectedAsiaItem,
   
  });
  final PopularDestinationModels? selectedItem;
  final EuropeDestinationModels? selectedEuropeItem;
  final AfricaDestinationModels? selectedAfricaItem;
  final SouthAmericaDestinationModels? selectedSouthAmericaItem;
  final NorthAmericaDestinationModels? selectedNorthAmericaItem;
  final AsiaDestinationModels? selectedAsiaItem;
  final String? category;
 

  @override
  State<PlanTrip> createState() => _PlanTripState();
}

class _PlanTripState extends State<PlanTrip> {
  // CalendarFormat _calenderFormat = CalendarFormat.month;
  // DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;

  DateTime? _rangeEnd;
  // final TextEditingController _dateController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedDay = _focusedDay;
  // }

  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  //   setState(() {
  //     _selectedDay = null;
  //     _focusedDay = focusedDay;
  //     _rangeStart = start;
  //     _rangeEnd = end;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Constants.greenColor,
      //   centerTitle: true,
      //   title: const Text('New Trip'),
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
                    File(
                      widget.category == 'Popular Destination'
                          ? widget.selectedItem!.countryImage
                          : widget.category == 'Africa'
                              ? widget.selectedAfricaItem!.countryImage
                              : widget.category == 'Europe'
                                  ? widget.selectedEuropeItem!.countryImage
                                  : widget.category == 'South America'
                                      ? widget.selectedSouthAmericaItem!
                                          .countryImage
                                      : widget.category == 'North America'
                                          ? widget.selectedNorthAmericaItem!
                                              .countryName
                                          : widget
                                              .selectedAsiaItem!.countryImage,
                    ),
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
                  final String image = widget.category == 'Popular Destination'
                      ? widget.selectedItem!.countryImage
                      : widget.category == 'Africa'
                          ? widget.selectedAfricaItem!.countryImage
                          : widget.category == 'Europe'
                              ? widget.selectedEuropeItem!.countryImage
                              : widget.category == 'South America'
                                  ? widget
                                      .selectedSouthAmericaItem!.countryImage
                                  : widget.category == 'North America'
                                      ? widget.selectedNorthAmericaItem!
                                          .countryImage
                                      : widget.selectedAsiaItem!.countryImage;
                  final String place = widget.category == 'Popular Destination'
                      ? widget.selectedItem!.countryName
                      : widget.category == 'Africa'
                          ? widget.selectedAfricaItem!.countryName
                          : widget.category == 'Europe'
                              ? widget.selectedEuropeItem!.countryName
                              : widget.category == 'South America'
                                  ? widget.selectedSouthAmericaItem!.countryName
                                  : widget.category == 'North America'
                                      ? widget
                                          .selectedNorthAmericaItem!.countryName
                                      : widget.selectedAsiaItem!.countryName;
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
                      content: Text('Trip Planned successfully!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
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
                child: const Text('Save')),
      
          ],
        ),
      ),
    );
  }
}