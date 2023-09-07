import 'package:cloud_firestore/cloud_firestore.dart';

class TokenService{

  static FirebaseFirestore firestore=FirebaseFirestore.instance;


  Future<void> storeDeviceToken(String deviceToken) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('adminDeviceTokens')
        .where('token', isEqualTo: deviceToken)
        .get();
    if (querySnapshot.docs.isEmpty) {
      await firestore.collection('adminDeviceTokens').add({
        'token': deviceToken,
      });
    }
  }


 static Future<List<String>> getAllDeviceTokens() async {
    QuerySnapshot querySnapshot = await firestore.collection('adminDeviceTokens').get();
    List<String> deviceTokens = [];

    querySnapshot.docs.forEach((doc) {
      deviceTokens.add(doc['token']);
    });

    return deviceTokens;
  }







}