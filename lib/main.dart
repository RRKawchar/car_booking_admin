import 'package:car_booking_admin/admin/provider/home_provider.dart';
import 'package:car_booking_admin/admin/provider/location_provider.dart';
import 'package:car_booking_admin/admin/provider/main_provider.dart';
import 'package:car_booking_admin/admin/screen/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return LocationProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return MainProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return HomeProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


