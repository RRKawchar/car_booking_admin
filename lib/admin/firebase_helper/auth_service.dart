// ignore_for_file: use_build_context_synchronously
import 'package:car_booking_admin/admin/screen/auth/login_screen.dart';
import 'package:car_booking_admin/admin/screen/main/main_screen.dart';
import 'package:car_booking_admin/admin/utils/helper_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService{


  static signUp({required String name, required String phone,required String email,required String password,required BuildContext context})async{

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await FirebaseFirestore.instance.collection('adminData').doc(userCredential.user?.uid).set({
        'name': name,
        'phone': phone,
        'email': email,
      },);


      if (userCredential.user != null) {
       kNavigation(context: context, screen: const MainScreen());
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        kSnackBar(context: context, text:e.code);
        kPrint("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        kSnackBar(context: context, text:e.code);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
      kSnackBar(context: context, text:e.toString());
    }

  }



  static login({required BuildContext context,required String email,required String password})async{

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password:password
      );

      if(userCredential.user !=null){

        kSnackBar(context: context, text: "Login Successfully");
        kNavigation(context: context, screen: const MainScreen());
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        kShowWaringMessage(context: context, body: e.code);
        kPrint("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        kShowWaringMessage(context: context, body: e.code);
        print('Wrong password provided for that user.');
      }
    }
  }


  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      kNavigation(context: context, screen: const LoginScreen());
    } catch (e) {
      print("Error during sign out: $e");
    }
  }

}