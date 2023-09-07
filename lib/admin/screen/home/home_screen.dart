// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:car_booking_admin/admin/firebase_helper/auth_service.dart';
import 'package:car_booking_admin/admin/firebase_helper/token_service.dart';
import 'package:car_booking_admin/admin/model/bookin_list_model.dart';
import 'package:car_booking_admin/admin/provider/home_provider.dart';
import 'package:car_booking_admin/admin/provider/location_provider.dart';
import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:car_booking_admin/admin/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  void initState() {
    final provider=Provider.of<HomeProvider>(context,listen: false);
    super.initState();
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_){
      provider.fetchUsersData();

      },);
    }
  }



  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Admin Panel"),
        actions: [
          IconButton(onPressed: (){
            AuthService.signOut(context);
          }, icon: const Icon(Icons.logout,),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HomeProvider>(
          builder: (context,value,child){

            return ListView.builder(
              itemCount: value.bookingList.length,
              itemBuilder: (context, index) {
                final user = value.bookingList[index];

                if(value.isLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    height: size.height/4,
                    width: size.width,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.userName,style: AppTextStyle.normalTextStyle(fontSize: 20),),
                          Text(user.email,style: AppTextStyle.normalTextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                          Text(user.date,style: AppTextStyle.normalTextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                          Text("Pick up : ${user.pickUpLocation}",style: AppTextStyle.normalTextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                          Text("Drop off : ${user.dropLocation}",style: AppTextStyle.normalTextStyle(fontSize: 20,fontWeight: FontWeight.normal),),

                          TextButton(onPressed: ()async{
                            sendBooking(user.deviceToken);
                          }, child: const Text("Accept"))

                        ],
                      ),
                    ),

                  ),
                );
              },
            );
          },
        ),
      )
    );
  }


  Future<void> sendBooking(String deviceToken) async {

    try {

      print("Passenger Token : $deviceToken");
      var adminDeviceTokens= await TokenService.getAllDeviceTokens();
      print(" Admin DeviceToken : $adminDeviceTokens");
      if (deviceToken.isNotEmpty) {
        var body = {
          'registration_ids': [deviceToken], // Use 'registration_ids' for multiple devices.
          'priority': 'high',
          'notification': {
            'title': "You reservation accepted",
            'body':"Have a nice Trip!",

          },
          'data': {
            'type': 'message',
            'id': 'rrk123',
            'image':
            'https://cdn2.vectorstock.com/i/1000x1000/23/91/small-size-emoticon-vector-9852391.jpg',
            'name':"nameController.text",
            'phone':"phoneController.text",
            "date": "dateController.text",
            "email": "emailController.text",
            "deviceToken": "deviceToken",
            'dropLocation': "dropOffController.text",
            'pickUpLocation':"picUpController.text"
          },
          "category": "News"
        };

        var headers = {
          "Content-Type": "application/json",
          "Authorization":
          "key=AAAAD6BSupQ:APA91bFDMrMe-ELTtMAuL3-N-3xuyqHE_xFJWNbz7Xm_q4FeMxa1nUnWo0TpmRoHQi7uAuMLAfncbqVXBryFsWFs32kD5QhqxaVIYg0XlMrL_Mt1R2wDOvrfOLLhtmXKdq8A1-O5-J4z"
        };

        var response = await http.post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          body: jsonEncode(body),
          headers: headers,
        );

        if (response.statusCode == 200) {
          print("Notification sent successfully!");
        } else {
          print("Failed to send notification. Status code: ${response.statusCode}");
        }
      } else {
        print("Device tokens are empty. Cannot send notification.");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
