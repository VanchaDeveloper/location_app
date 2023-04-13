import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget loadingIndicatorProgressBar({String? data}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          backgroundColor: Colors.orange,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data ?? "Loading..",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}

void snackBar({String? msg, required context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$msg"),
        ],
      ),
    ),
  );
}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget verticalDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    height: 18,
    width: 1.0,
    decoration: BoxDecoration(color: Colors.black.withOpacity(.4)),
  );
}
