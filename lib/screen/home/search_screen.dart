import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted%20class/app_background.dart';
import 'package:new_travel_app/refracted%20class/app_destination_list.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';

class SearchScreen extends StatefulWidget {
  final List<DestinationModels> destination;

  SearchScreen({super.key, required this.destination}) {
    filterDestination = destination;
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List<DestinationModels> filterDestination = [];
TextEditingController _searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  void filterDestinations(value) {
    setState(() {
      filterDestination = widget.destination
          .where((destination) => destination.countryName
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: _searchController,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.greenColor,
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: AppColors.black.withOpacity(0.9),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 10)),
                  focusedBorder: OutlineInputBorder(
                    // Customize focused border
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: AppColors.white,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon:
                              const Icon(Icons.cancel, color: Colors.blueGrey),
                          onPressed: () {
                            _searchController.clear();
                            filterDestinations('');
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  filterDestinations(value);
                },
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            )
          ],
        ),
      ),
      body: BackgroundColor(
        child: (_searchController.text.isNotEmpty && filterDestination.isEmpty)
            ? const Center(
                child: Text(
                  "We couldn't find any results matching \n your search",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
              )
            : (widget.destination.isEmpty && filterDestination.isEmpty)
                ? const Center(
                    child: Text(
                      'No destination to show',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: filterDestination.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DestinationListWidget(filterDestination[index]);
                    },
                  ),
      ),
    );
  }
}
