import 'package:car_booking_admin/admin/provider/home_provider.dart';
import 'package:car_booking_admin/admin/provider/location_provider.dart';
import 'package:car_booking_admin/admin/provider/main_provider.dart';
import 'package:car_booking_admin/admin/screen/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.notification!.body}');
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


