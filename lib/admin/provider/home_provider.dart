import 'package:car_booking_admin/admin/model/bookin_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  List<BookingListModel> bookingList = [];

  bool isLoading = false;

  Future<void> fetchUsersData() async {
    try {
      isLoading = true;
      notifyListeners();
      final QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('PassengerBooking').get();

      if (usersSnapshot.docs.isNotEmpty) {
        bookingList.clear();

        for (final userDoc in usersSnapshot.docs) {
          final userData = userDoc.data() as Map<String, dynamic>;

          final userId = userDoc.id;
          final userName = userData['name'];
          final userEmail = userData['email'];
          final date = userData['date'];
          final pickUpLocation = userData['pickLocation'];
          final dropLocation = userData['dropLocation'];
          final deviceToken = userData['deviceTokens'];

          final bookingData = BookingListModel(
            userId: userId,
            userName: userName,
            email: userEmail,
            date: date,
            pickUpLocation: pickUpLocation,
            dropLocation: dropLocation,
            deviceToken: deviceToken,
          );
          bookingList.add(bookingData);
          print(bookingList);
        }
        notifyListeners();
      } else {
        print('No users found.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
