import 'package:car_booking_admin/admin/components/custom_textfield.dart';
import 'package:car_booking_admin/admin/firebase_helper/auth_service.dart';
import 'package:car_booking_admin/admin/provider/location_provider.dart';
import 'package:car_booking_admin/admin/screen/auth/sign_up_screen.dart';
import 'package:car_booking_admin/admin/service/notification_service.dart';
import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:car_booking_admin/admin/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  NotificationServices notificationServices=NotificationServices();


  @override
  void initState() {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_){
        provider.getLocation(context);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
                  value.placemark.country != null
                      ? value.placemark.country.toString()
                      : "Loading....",
                  style: AppTextStyle.normalTextStyle(
                    fontSize: 30,
                  ),
                );
              },
            ),
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
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    kShowWaringMessage(
                        context: context,
                        body: "email or password field is empty!!");
                  }
                  AuthService.login(
                    context: context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  notificationServices.getDeviceToken();
                } else {
                  kShowWaringMessage(
                    context: context,
                    body: "This service is only for America!!",
                  );
                }
              },
              child: const Text("Login"),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have any account!!"),
                kSizedBox(width: 2),
                TextButton(
                  onPressed: () {
                    kNavigation(context: context, screen: const SignUpScreen());
                  },
                  child: const Text(
                    "Sign up",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
