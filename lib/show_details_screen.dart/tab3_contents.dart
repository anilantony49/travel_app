import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';


class TabThreeContent extends StatelessWidget {
  // final String category;
  final DestinationModels? selectedItem;
  // final EuropeDestinationModels? selectedEuropeItem;
  // final AfricaDestinationModels? selectedAfricaItem;
  const TabThreeContent({
    super.key,
    // required this.category,
    required this.selectedItem,
    // required this.selectedEuropeItem,
    // required this.selectedAfricaItem
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                width: double.infinity,
                height: 400,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 231, 228, 228),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(selectedItem?.weather ?? 'No Data available'),
                )),
          )
        ],
      ),
    );
  }
}
