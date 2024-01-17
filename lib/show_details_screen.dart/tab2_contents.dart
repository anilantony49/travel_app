import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/others/widgets.dart';

class TabTwoContent extends StatelessWidget {
  // final String category;
  final DestinationModels? selectedItem;
  // final EuropeDestinationModels? selectedEuropeItem;
  // final AfricaDestinationModels? selectedAfricaItem;
  const TabTwoContent({
    super.key,
    // required this.category,
    required this.selectedItem,
    // required this.selectedEuropeItem,
    // required this.selectedAfricaItem
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
          child: Text(
            'Currency',
            style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
        ),
        Widgets.section(
          selectedItem?.currency ?? 'No Data available',
        ),
        Widgets.headingText('Convert'),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Container(
              height: 80,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 231, 228, 228),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INR',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                        Text('Indian Rupee',
                            style: TextStyle(
                                fontSize: 14, color: Constants.blackColor)),
                      ],
                    ),
                    Spacer(),
                    Text('0',
                        style: TextStyle(
                            fontSize: 30,
                            color: Constants.blackColor,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Container(
              height: 80,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 231, 228, 228),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EUR',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                        Text('Euro',
                            style: TextStyle(
                                fontSize: 14, color: Constants.blackColor)),
                      ],
                    ),
                    Spacer(),
                    Text('0',
                        style: TextStyle(
                            fontSize: 30,
                            color: Constants.blackColor,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
