class BookingListModel {
  final String userId;
  final String userName;
  final String email;
  final String date;
  final String pickUpLocation;
  final String dropLocation;

  BookingListModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.date,
    required this.pickUpLocation,
    required this.dropLocation,
  });
}
