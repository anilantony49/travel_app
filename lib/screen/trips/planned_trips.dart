import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/db/planned_trips._db.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/models/planned_trip.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_class/app_rating.dart';
import 'package:new_travel_app/refracted_widgets/app_sized_box.dart';
import 'package:new_travel_app/screen/trips/plan_edit_trip.dart';

class PlannedTrip extends StatefulWidget {
  const PlannedTrip({
    Key? key,
    this.startDate,
    this.endDate,
    this.selectedItem,
  }) : super(key: key);
  final DateTime? startDate;
  final DateTime? endDate;
  final DestinationModels? selectedItem;

  @override
  State<PlannedTrip> createState() => _PlannedTripState();
}

class _PlannedTripState extends State<PlannedTrip> {
  List<PlannedTripModels> items = [];
  // List<DestinationModels> destinationItems=[];
  @override
  void initState() {
    super.initState();
    fetchTrip();
  }

  void fetchTrip() async {
    List<PlannedTripModels> fetchedItems =
        await PlannedTripDb.singleton.getAllTrip();
    setState(() {
      items = fetchedItems;
    });
  }

  void deleteTripAndShowSnackbar(String tripId) {
    PlannedTripDb.singleton.deleteTrip(tripId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Trip deleted successfully'),
        duration: Duration(seconds: 2),
      ),
    );

    fetchTrip();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        centerTitle: true,
        title: Text('Planned Trips', style: GoogleFonts.alata()),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 41, 199, 201),
              Color(0xFFE4EfE9),
            ], // Adjust colors to your liking
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: items.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.explore_off_outlined,
                    color: Color.fromARGB(255, 202, 200, 200),
                    size: 100,
                  ),
                  Text('No Trip Planned',
                      style: GoogleFonts.alata(color: AppColors.grey))
                ],
              ))
            : ListView.separated(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final PlannedTripModels plannedTrip = items[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Slidable(
                      key: UniqueKey(),
                      direction: Axis.horizontal,
                      startActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => PlanEditTrip(
                                          selectedImage: plannedTrip.image,
                                          selectedPlace: plannedTrip.place,
                                          tripId: plannedTrip.id,
                                        )))
                                .then((result) {
                              if (result == true) {
                                // Update UI or perform any necessary actions
                                fetchTrip(); // Update the current user information
                              }
                            });
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 118, 121, 126),
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            deleteTripAndShowSnackbar(plannedTrip.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('An item has been deleted')));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 198, 136, 136),
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          // height: 10,
                          child: Row(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  // color: const Color.fromARGB(255, 94, 8, 8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.grey,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: plannedTrip.image.isNotEmpty &&
                                        File(plannedTrip.image).existsSync()
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(plannedTrip.image),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 40,
                                          color: AppColors.white,
                                        ),
                                      ),
                              ),
                              AppSizedBoxes.box10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_rounded,
                                        color: AppColors.blackColor,
                                        size: 18,
                                      ),
                                      Text(
                                        '  ${plannedTrip.date}',
                                        style: GoogleFonts.alata(
                                            color: AppColors.blackColor,
                                            fontSize: screenWidth * .035),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    plannedTrip.place,
                                    style: GoogleFonts.alata(
                                        color: AppColors.blackColor,
                                        fontSize: screenWidth * .05),
                                  ),
                                  Rating(
                                    itemSize: screenWidth * .04,
                                    initialRating:
                                        widget.selectedItem?.rating ?? 3,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return AppSizedBoxes.box1;
                },
              ),
      ),
    );
  }
}
