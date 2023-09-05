import 'package:car_booking_admin/admin/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        return NavigationBar(
          onDestinationSelected: (int index) {
            value.onDestination(index);
          },
          indicatorColor: Colors.amber[800],
          selectedIndex: value.currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: 'Booking',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.school),
              icon: Icon(Icons.school_outlined),
              label: 'List',
            ),
          ],
        );
      },
    );
  }
}
