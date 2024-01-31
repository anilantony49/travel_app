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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 231, 228, 228),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
