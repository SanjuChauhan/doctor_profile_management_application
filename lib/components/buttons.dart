import 'package:flutter/material.dart';

import '../utility/appColors.dart';

Widget createOrangeBTN({title, onPressedd, color, textColor, isButtonEnable}) {
  return Container(
    margin: EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 20,
    ),
    child: MaterialButton(
      minWidth: double.infinity,
      height: 50,
      onPressed: () {
        onPressedd();
      },
      color: isButtonEnable ? color : AppColors.selectedColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: textColor,
          fontSize: 16,
        ),
      ),
    ),
  );
}
