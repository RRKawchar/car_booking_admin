// ignore_for_file: use_build_context_synchronously

import 'package:car_booking_admin/admin/firebase_service/auth_service.dart';
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
}
