// ignore_for_file: file_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension InternetConnection on BuildContext {
  Future checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      if (noConnection.value) {
        ScaffoldMessenger.of(this).showSnackBar(messageSnackBar(
            message: "online",
            color: Colors.green,
            imagePath: "assets/images/retriveConnection.svg",
            isBottomNavBar: true));
        noConnection.value = false;
      }
    } else {
      if (!noConnection.value) {
        ScaffoldMessenger.of(this).showSnackBar(messageSnackBar(
            message: "offline",
            color: Colors.red,
            imagePath: "assets/images/lostConnection.svg",
            isBottomNavBar: true));
        noConnection.value = true;
      }
    }
  }

  noConnectionMessage() {
    ScaffoldMessenger.of(this).showSnackBar(messageSnackBar(
        message: "offline",
        color: Colors.red,
        imagePath: "assets/images/lostConnection.svg",
        isBottomNavBar: true));
  }

  ConnectionMessage() {
    ScaffoldMessenger.of(this).showSnackBar(messageSnackBar(
        message: "online",
        color: Colors.green,
        imagePath: "assets/images/retriveConnection.svg",
        isBottomNavBar: true));
  }

  noConnectionBody() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150.h,
          ),
          SizedBox(
            height: 200.w,
            width: 200.w,
            child: Image.asset(
              "assets/no_internet.png",
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "No Internet Connection !",
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
          SizedBox(
            height: 30.h,
          ),
          IconButton(
              onPressed: () async {
                await checkInternet();
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30.sp,
              ))
        ],
      ),
    );
  }
}
