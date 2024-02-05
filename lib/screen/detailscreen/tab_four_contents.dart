import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_function/app_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class TabFourContent extends StatelessWidget {
  final DestinationModels? selectedItem;

  const TabFourContent({
    super.key,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * .055,
            // bottom: screenWidth * .030,
            top: screenWidth * .040),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emergency Services',
              style: GoogleFonts.alatsi(
                textStyle: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * .04,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _launchPhoneDialer(selectedItem!.police.toString()),
              child: emergencyServices(context, 'Police',
                  selectedItem!.police.toString(), Icons.local_police),
            ),
            GestureDetector(
              onTap: () => _launchPhoneDialer(selectedItem!.ambulance.toString()),
              child: emergencyServices(
                context,
                'Ambulance',
                selectedItem!.ambulance.toString(),
                Icons.local_hospital,
              ),
            ),
            GestureDetector(
              onTap: () => _launchPhoneDialer(selectedItem!.fire.toString()),
              child: emergencyServices(
                context,
                'Fire',
                selectedItem!.fire.toString(),
                Icons.local_fire_department,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchPhoneDialer(String number) async {
    final String phoneNumber = 'tel:$number';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
