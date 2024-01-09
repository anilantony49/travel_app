import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/show_details_screen.dart/show_detail_description.dart';

class TabFourContent extends StatelessWidget {
  final String category;
  final PopularDestinationModels? selectedItem;
  final EuropeDestinationModels? selectedEuropeItem;
  final AfricaDestinationModels? selectedAfricaItem;
  const TabFourContent(
      {super.key,
      required this.category,
      required this.selectedItem,
      required this.selectedEuropeItem,
      required this.selectedAfricaItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency Servises',
            style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          emergencyServices(
              'Police',
              category == 'Popular Destination'
                  ? selectedItem!.police.toString()
                  : category == 'Africa'
                      ? selectedAfricaItem!.police.toString()
                      : selectedEuropeItem!.police.toString(),
              Icons.local_police),
          emergencyServices(
            'Ambulance',
            category == 'Popular Destination'
                ? selectedItem!.ambulance.toString()
                : category == 'Africa'
                    ? selectedAfricaItem!.ambulance.toString()
                    : selectedEuropeItem!.ambulance.toString(),
            Mdi.ambulance,
          ),
          emergencyServices(
            'Fire',
            category == 'Popular Destination'
                ? selectedItem!.fire.toString()
                : category == 'Africa'
                    ? selectedAfricaItem!.fire.toString()
                    : selectedEuropeItem!.fire.toString(),
            Mdi.fire,
          ),
        ],
      ),
    );
  }
}
