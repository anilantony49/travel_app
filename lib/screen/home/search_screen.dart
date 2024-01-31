import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';

import '../../refracted class/app_background.dart';
import '../../refracted class/app_destination_list.dart';

class SearchScreen extends StatefulWidget {
  final List<DestinationModels> destination;

  const SearchScreen({Key? key, required this.destination}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List<DestinationModels> filterDestination = [];
TextEditingController _searchController = TextEditingController();
String? _selectedCategory;

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    filterDestination = widget.destination;
    _selectedCategory = 'All';
    super.initState();
  }

  void filterDestinations(String value) {
    setState(() {
      if (_selectedCategory == 'All') {
        filterDestination = widget.destination
            .where((destination) => destination.countryName
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      } else {
        filterDestination = widget.destination
            .where((destination) =>
                destination.countryName
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                (destination.categories == _selectedCategory))
            .toList();
      }
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
                    borderSide: const BorderSide(color: Colors.red, width: 10),
                  ),
                  focusedBorder: OutlineInputBorder(
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
                onChanged: filterDestinations,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ), // Define the border style
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text('Category'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                      filterDestinations(_searchController.text);
                    });
                  },
                  items: _buildCategoryDropdownItems(),
                ),
              ),
            ),
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

  List<DropdownMenuItem<String>> _buildCategoryDropdownItems() {
    Set<String> categories =
        widget.destination.map((destination) => destination.categories).toSet();
    List<DropdownMenuItem<String>> items = categories
        .map((category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            ))
        .toList();
    items.insert(
        0, const DropdownMenuItem<String>(value: 'All', child: Text('All')));
    return items;
  }
}
