import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';

class TabThreeContent extends StatelessWidget {
  final DestinationModels? selectedItem;

  const TabThreeContent({
    super.key,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.all(screenWidth*.09),
            child: Center(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 231, 228, 228),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(screenWidth*.05),
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        child:
                            Text(selectedItem?.weather ?? 'No Data available')),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
