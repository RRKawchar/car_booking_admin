import 'package:car_booking_admin/admin/provider/main_provider.dart';
import 'package:car_booking_admin/admin/screen/main/widget/navigationbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavigationBarWidget(),
      body: Consumer<MainProvider>(
        builder: (context, value, child) {
          return value.pages[value.currentPageIndex];
        },
      ),
    );
  }
}
