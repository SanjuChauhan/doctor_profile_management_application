import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'appColors.dart';

class Utility {
  static showToast({String msg}) {
    Fluttertoast.showToast(msg: msg);
  }

  static Widget progress(BuildContext context, {Color color}) {
    return Container(
      alignment: Alignment.center,
      color: color != null ? color : Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.blackColor.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.blackColor),
          ),
        ),
      ),
    );
  }

  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
