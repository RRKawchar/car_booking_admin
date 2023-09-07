import 'package:car_booking_admin/admin/components/custom_textfield.dart';
import 'package:car_booking_admin/admin/firebase_helper/auth_service.dart';
import 'package:car_booking_admin/admin/provider/location_provider.dart';
import 'package:car_booking_admin/admin/screen/auth/login_screen.dart';
import 'package:car_booking_admin/admin/service/notification_service.dart';
import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:car_booking_admin/admin/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

NotificationServices notificationServices = NotificationServices();


  @override
  void initState() {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    super.initState();
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_){
         provider.getLocation(context);
      });
    }

  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Consumer<LocationProvider>(
              builder: (context, value, child) {
                return Text(
                  value.placemark.country !=null?
                  value.placemark.country.toString():"Loading....",
                  style: AppTextStyle.normalTextStyle(
                    fontSize: 30,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(controller: nameController, labelText: "Name"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                controller: phoneController, labelText: "phone number"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(controller: emailController, labelText: "email"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                controller: passwordController, labelText: "password"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (provider.placemark.country.toString() == "United States") {
                  AuthService.signUp(
                    context: context,
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  notificationServices.getDeviceToken();
                } else {
                  kShowWaringMessage(
                    context: context,
                    body: "This service is only for US!!",
                  );
                }
              },
              child: const Text("Sign Up"),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account !"),
                kSizedBox(width: 2),
                TextButton(onPressed: (){

                  kNavigation(context: context, screen: const LoginScreen(),);
                }, child: const Text("LogIn",),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
