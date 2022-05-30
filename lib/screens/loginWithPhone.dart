import 'package:doctor_profile_management_application/components/buttons.dart';
import 'package:doctor_profile_management_application/screens/verificationScreen.dart';
import 'package:doctor_profile_management_application/utility/appColors.dart';
import 'package:doctor_profile_management_application/utility/appDimens.dart';
import 'package:flutter/material.dart';

import '../utility/utility.dart';

class LoginWithPhone extends StatefulWidget {
  LoginWithPhone();

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  AppDimens appDimens;
  TextEditingController mobileNumberEditingController;
  TextEditingController countryCodeEditingController;
  Size size;
  MediaQueryData mediaQuerydata;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    mobileNumberEditingController = TextEditingController();
    countryCodeEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuerydata = MediaQuery.of(context);
    size = MediaQuery.of(context).size;
    appDimens = new AppDimens(size);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: size.height - mediaQuerydata.padding.top),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: appDimens.paddingw2),
                      alignment: Alignment.center,
                      child: Text(
                        "ENTER YOUR MOBILE NUMBER",
                        style: TextStyle(
                          fontSize: appDimens.text20,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: appDimens.paddingw20,
                    ),
                    inputMobileView(),
                    Container(
                      margin: EdgeInsets.only(
                        left: appDimens.paddingw16 * 2,
                        right: appDimens.paddingw16 * 2,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "We will send you an SMS with the verification code to this number",
                        style: TextStyle(
                          fontSize: appDimens.text16,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: appDimens.paddingw20,
                    ),
                    createOrangeBTN(
                        title: "Continue",
                        onPressedd: () {
                          continueClick();
                        },
                        isButtonEnable: true,
                        color: AppColors.greenColor,
                        textColor: AppColors.whiteColor),
                    Spacer(),
                    Spacer(),
                  ],
                ),
              ),
            ),
            isLoading ? Utility.progress(context) : Container(),
          ],
        ),
      ),
    );
  }

  Widget inputMobileView() {
    return Container(
      margin: EdgeInsets.only(
        left: appDimens.paddingw16 * 2,
        right: appDimens.paddingw16 * 2,
        bottom: appDimens.paddingw16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.whiteColor),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: appDimens.paddingw6,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: countryCodeEditingController,
              decoration: InputDecoration(
                  hintText: "+91",
                  counterText: "",
                  hintStyle: TextStyle(color: AppColors.greenAccentColor),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () => mobileNumberEditingController.clear(),
                    icon: Icon(Icons.arrow_drop_down_sharp,
                        color: AppColors.greenAccentColor, size: 20),
                  )),
              maxLength: 4,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                  fontSize: appDimens.text20,
                  color: AppColors.greenAccentColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: appDimens.paddingw6,
            ),
          ),
          Expanded(
            flex: 7,
            child: TextFormField(
              style: TextStyle(
                  fontSize: appDimens.text20, color: AppColors.accentColor),
              controller: mobileNumberEditingController,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: "Mobile Number",
                counterText: "",
                hintStyle: TextStyle(color: AppColors.accentColor),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () => mobileNumberEditingController.clear(),
                  icon: Icon(Icons.clear_rounded,
                      color: AppColors.accentColor, size: 20),
                ),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
            ),
          )
        ],
      ),
    );
  }

  continueClick() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          mobile: mobileNumberEditingController.text,
          countrycode: countryCodeEditingController.text ?? "+91",
        ),
      ),
    );
  }
}
