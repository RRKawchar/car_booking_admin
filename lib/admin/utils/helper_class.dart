import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> kShowMyDialog(
    {required BuildContext context,
    required String body,
    void Function()? onPressed}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              "Enable",
            ),
          ),
        ],
      );
    },
  );
}

Future<void> kShowWaringMessage({
  required BuildContext context,
  required String body,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Warning !'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Back',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

kSizedBox({
  double height = 0,
  double width = 0,
}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

kNavigation({
  required BuildContext context,
  required Widget screen,
}) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

kSnackBar({
  required BuildContext context,
  required String text,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1),
    ),
  );
}



kPrint(String text){
if (kDebugMode) {
  return print(text);
}
}



