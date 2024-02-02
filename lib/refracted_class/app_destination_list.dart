import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/screen/detailscreen/show_detail_description.dart';
import 'package:new_travel_app/models/destination_details.dart';

class DestinationListWidget extends StatelessWidget {
  final DestinationModels destination;

  const DestinationListWidget(this.destination, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ShowDetailsPage(selectedItem: destination)));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  color: Colors.grey),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(destination.countryImage),
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.countryName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey),
                ),
                Text(
                  destination.categories,
                  style: const TextStyle(color: Colors.blueGrey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
