
import 'package:flutter/material.dart';
import 'package:new_travel_app/others/contants.dart';

class AddTrip extends StatelessWidget {
  const AddTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.greenColor,
        centerTitle: true,
        title: const Text('Add Trip'),
      ),
      body:
       Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          // child: Image.file(File()),
        ),
      ),
    );
  }
}
