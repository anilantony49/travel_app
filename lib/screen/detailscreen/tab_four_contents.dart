import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_function/app_functions.dart';

class TabFourContent extends StatelessWidget {
  final DestinationModels? selectedItem;

  const TabFourContent({
    super.key,
    required this.selectedItem,
  });

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
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          emergencyServices(
              'Police', selectedItem!.police.toString(), Icons.local_police),
          emergencyServices(
            'Ambulance',
            selectedItem!.ambulance.toString(),
            Icons.local_hospital,
          ),
          emergencyServices(
            'Fire',
            selectedItem!.fire.toString(),
            Icons.local_fire_department,
          ),
        ],
      ),
    );
  }
}
