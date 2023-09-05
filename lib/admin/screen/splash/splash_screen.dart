import 'package:car_booking_admin/admin/screen/auth/login_screen.dart';
import 'package:car_booking_admin/admin/screen/main/main_screen.dart';
import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        checkUserStatus();
      });
    }
    super.initState();

  }


  Future<void> checkUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      kNavigation(context: context, screen: const MainScreen());
    }else{
      kNavigation(context: context, screen: const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator while checking user status
      ),
    );
  }
}
