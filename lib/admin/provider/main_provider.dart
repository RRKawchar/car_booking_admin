
import 'package:car_booking_admin/admin/screen/home/home_screen.dart';
import 'package:car_booking_admin/admin/screen/booking/booking_scren.dart';
import 'package:flutter/widgets.dart';

class MainProvider with ChangeNotifier{

  final List<Widget> _pages=[

    HomeScreen(),
    BookingScreen(),
    Text("Profile"),

  ];

  List<Widget> get pages=>_pages;

  int currentPageIndex = 0;

  void onDestination(int index){
   currentPageIndex=index;
   notifyListeners();
  }

  }