import 'dart:async';
import 'package:car_booking_admin/admin/components/custom_button.dart';
import 'package:car_booking_admin/admin/components/custom_textfield.dart';
import 'package:car_booking_admin/admin/firebase_helper/booking_service.dart';
import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final picUpController = TextEditingController();
  final dropOffController = TextEditingController();


  @override
  void initState() {

    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_){
       fetchUserData();
      });
    }
    super.initState();
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateController.dispose();
    picUpController.dispose();
    dropOffController.dispose();
    super.dispose();
  }

Future<void>fetchUserData()async{
    try{

      final user =FirebaseAuth.instance.currentUser;
      if(user !=null){

        final userDoc=await FirebaseFirestore.instance.collection("adminData").doc(user.uid).get();
        if(userDoc.exists){
          final userData= userDoc.data() as Map<String,dynamic>;

          nameController.text=userData['name']??'';
          emailController.text=userData['email']??'';
          phoneController.text=userData['phone']??'';
        }
      }


    }catch(e){
      kPrint(e.toString());
    }

}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text("Booking"),
      //   centerTitle: true,
      // ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       children: [
      //         CustomTextField(
      //           labelText: "Full Name",
      //           controller: nameController,
      //         ),
      //         kSizedBox(height: 10),
      //         CustomTextField(
      //           labelText: "Email",
      //           controller: emailController,
      //         ),
      //         kSizedBox(height: 10),
      //         CustomTextField(
      //           labelText: "Phone",
      //           controller: phoneController,
      //         ),
      //         kSizedBox(height: 10),
      //         CustomTextField(
      //           labelText: "Date",
      //           controller: dateController,
      //         ),
      //         kSizedBox(height: 10),
      //         CustomTextField(
      //           labelText: "Pick up Location",
      //           controller: picUpController,
      //         ),
      //         kSizedBox(height: 10),
      //         CustomTextField(
      //           labelText: "Drop off location",
      //           controller: dropOffController,
      //         ),
      //         kSizedBox(height: 20),
      //         CustomButton(
      //             onPressed: () {
      //               BookingService.bookingPassenger(
      //                 name: nameController.text,
      //                 email: emailController.text,
      //                 phone: phoneController.text,
      //                 date: dateController.text,
      //                 picLocation: picUpController.text,
      //                 dropLocation: dropOffController.text,
      //                 context: context,
      //               );
      //             },
      //             text: "Send",)
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
