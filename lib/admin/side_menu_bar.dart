import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_travel_app/admin/africa.dart';
import 'package:new_travel_app/admin/asia.dart';
import 'package:new_travel_app/admin/europe.dart';
import 'package:new_travel_app/admin/north_america.dart';
import 'package:new_travel_app/admin/popular_destinations.dart';
import 'package:new_travel_app/admin/south_america.dart';

class SideMenuBar extends StatelessWidget {
  const SideMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      child: ListView(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back))),
         
          const Divider(),
          ListTile(
            leading: const Icon(Icons.local_fire_department),
            title: const Text('Popular Destinations'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const PopularDstination()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.euro),
            title: const Text('Europe'),
            onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EuropePage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Mdi.earth),
            title: const Text('Africa'),
            onTap: () =>  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AfricaPage())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('North America'),
            onTap: () =>  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NorthAmericaPage())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.south_america),
            title: const Text('South America'),
            onTap: () =>  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SouthAmericaPage())),
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg/globe_asia_.svg',
              width: 25,
              height: 25,
            ),
            title: const Text('Asia'),
            onTap: () =>Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AsiaPage())),
          )
        ],
      ),
    );
  }
}
