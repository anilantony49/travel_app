import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/detalis_add_edit_page.dart';
import 'package:new_travel_app/db/destination_details_db.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';

void showDestinationBottomSheet(
  BuildContext context,
  String itemId,
  List<DestinationModels> items,
  Function fetchCategory,
  Function setStateCallback,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsAddEditPage(
                    initialitemId: itemId,
                    initialCountryName: items
                        .firstWhere((item) => item.id == itemId)
                        .countryName,
                    initialDescription:
                        items.firstWhere((item) => item.id == itemId).details,
                    initialImagePath: items
                        .firstWhere((item) => item.id == itemId)
                        .countryImage,
                    initialCountryCapital:
                        items.firstWhere((item) => item.id == itemId).capital,
                    initialLanguage:
                        items.firstWhere((item) => item.id == itemId).language,
                    initialcurrency:
                        items.firstWhere((item) => item.id == itemId).currency,
                    initialDialCode: items
                        .firstWhere((item) => item.id == itemId)
                        .digitialCode,
                    initialWeather:
                        items.firstWhere((item) => item.id == itemId).weather,
                    initialImages: items
                        .firstWhere((item) => item.id == itemId)
                        .images
                        .toString(),
                    initialMajorCities: items
                        .firstWhere((item) => item.id == itemId)
                        .majorCities
                        .toString(),
                    initialknownFor: items
                        .firstWhere((item) => item.id == itemId)
                        .knownFor
                        .toString(),
                    addOrEdit: 'Edit',
                  ),
                ),
              ).then((result) {
                if (result == true) {
                  setStateCallback();
                  Navigator.pop(context);
                }
              });
            },
            leading: const Icon(Icons.edit_square, color: AppColors.greenColor),
            title: const Text('Edit item',
                style: TextStyle(color: AppColors.blackColor)),
          ),
          ListTile(
            onTap: () {
              deleteCountryAndShowSnackbar(context, itemId, fetchCategory);
              Navigator.pop(context);
            },
            leading: const Icon(Icons.delete, color: AppColors.greenColor),
            title: const Text('Delete item',
                style: TextStyle(color: AppColors.blackColor)),
          ),
        ],
      );
    },
  );
}

void deleteCountryAndShowSnackbar(
    BuildContext context, String itemId, Function fetchCategory) {
  DestinationDb.singleton.deleteDestination(itemId);

  // Show a Snackbar indicating that the user has been deleted
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Country deleted successfully'),
      duration: Duration(seconds: 2),
    ),
  );

  fetchCategory();
}
