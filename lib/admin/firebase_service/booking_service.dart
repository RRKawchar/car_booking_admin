import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingService{

  static Future<void> bookingPassenger({
    required String name,
    required String email,
    required String phone,
    required String date,
    required String picLocation,
    required String dropLocation,
    required BuildContext context,
  }) async {
    if (name.isEmpty) {
      kSnackBar(context: context, text: "Name is Required");
    } else if (email.isEmpty) {
      kSnackBar(context: context, text: "Email is Required");
    } else if (date.isEmpty) {
      kSnackBar(context: context, text: "Date is Required");
    } else if(phone.isEmpty){
      kSnackBar(context: context, text: "Number is Required");
    }else if (picLocation.isEmpty) {
      kSnackBar(context: context, text: "Pick Up Location is Required");
    } else if (dropLocation.isEmpty) {
      kSnackBar(context: context, text: "Drop off location is Required");
    } else {
      await FirebaseFirestore.instance
          .collection("PassengerBooking")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {
          'name': name,
          'email': email,
          'date': date,
          'pickLocation': picLocation,
          'dropLocation': dropLocation,
        },
      );
    }
  }





}