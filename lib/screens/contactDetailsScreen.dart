import 'package:flutter/material.dart';

import '../models/contactModel.dart';
import '../utility/appColors.dart';
import '../utility/appDimens.dart';

class ContactDetailsScreen extends StatefulWidget {
  ContactsData contactsData;

  ContactDetailsScreen({@required this.contactsData});

  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  AppDimens appDimens;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    appDimens = new AppDimens(size);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.accentColor,
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(40), // Image radius
                    child: Image.network(widget.contactsData.profile_pic,
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                widget.contactsData.first_name +
                    " " +
                    widget.contactsData.last_name,
                style: TextStyle(
                    fontSize: appDimens.text18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor)),
            SizedBox(
              height: 5,
            ),
            Text(widget.contactsData.specialization,
                style: TextStyle(
                    fontSize: appDimens.text16,
                    color: AppColors.selectedColor)),
            SizedBox(
              height: 20,
            )
          ])),
    );
  }
}
