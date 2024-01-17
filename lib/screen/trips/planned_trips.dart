import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_travel_app/db/planned_trips._db.dart';
import 'package:new_travel_app/models/planned_trip.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/trips/add_trip.dart';
import 'package:new_travel_app/screen/trips/edit_trip.dart';

class PlannedTrip extends StatefulWidget {
  const PlannedTrip({
    Key? key,
    this.startDate,
    this.endDate,
  }) : super(key: key);
  final DateTime? startDate;
  final DateTime? endDate;
  @override
  State<PlannedTrip> createState() => _PlannedTripState();
}

class _PlannedTripState extends State<PlannedTrip> {
  List<PlannedTripModels> items = [];
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
        duration: Duration(seconds: 3),
      ),
    );

    fetchTrip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.greenColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AddTrip()));
          }),
      appBar: AppBar(
        backgroundColor: Constants.greenColor,
        centerTitle: true,
        title: const Text('Planned Trips'),
      ),
      body: 
      items.isEmpty
          ? const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.explore_off_outlined,
                  color: Color.fromARGB(255, 202, 200, 200),
                  size: 100,
                ),
                Text(
                  'No Trip Planned',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ))
          :
           ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final PlannedTripModels plannedTrip = items[index];
                return Slidable(
                  key: UniqueKey(),
                  direction: Axis.horizontal,
                  startActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditTrip(
                                  selectedImage: plannedTrip.image,
                                  selectedPlace: plannedTrip.place,
                                  tripId:plannedTrip.id ,
                                )));
                      },
                      backgroundColor: const Color.fromARGB(255, 118, 121, 126),
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
                      backgroundColor: const Color.fromARGB(255, 198, 136, 136),
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        subtitle: Text(plannedTrip.place),
                        leading: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                offset: Offset(0, 4),
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
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        title: Text(plannedTrip.date),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
