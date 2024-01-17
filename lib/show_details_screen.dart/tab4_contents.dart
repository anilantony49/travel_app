import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/others/contants.dart';

class TabFourContent extends StatelessWidget {
  // final String category;
  final DestinationModels? selectedItem;
  // final EuropeDestinationModels? selectedEuropeItem;
  // final AfricaDestinationModels? selectedAfricaItem;
  const TabFourContent(
      {super.key,
      // required this.category,
      required this.selectedItem,
      // required this.selectedEuropeItem,
      // required this.selectedAfricaItem
      });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Emergency Servises',
            style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          // emergencyServices(
          //     'Police',
          //    selectedItem!.police.toString()
          //         : category == 'Africa'
          //             ? selectedAfricaItem!.police.toString()
          //             : selectedEuropeItem!.police.toString(),
          //     Icons.local_police),
          // emergencyServices(
          //   'Ambulance',
          //   category == 'Popular Destination'
          //       ? selectedItem!.ambulance.toString()
          //       : category == 'Africa'
          //           ? selectedAfricaItem!.ambulance.toString()
          //           : selectedEuropeItem!.ambulance.toString(),
          //   Mdi.ambulance,
          // ),
          // emergencyServices(
          //   'Fire',
          //   category == 'Popular Destination'
          //       ? selectedItem!.fire.toString()
          //       : category == 'Africa'
          //           ? selectedAfricaItem!.fire.toString()
          //           : selectedEuropeItem!.fire.toString(),
          //   Mdi.fire,
          // ),
        ],
      ),
    );
  }
}
