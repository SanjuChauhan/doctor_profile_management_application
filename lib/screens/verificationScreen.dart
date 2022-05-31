import 'package:doctor_profile_management_application/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../components/buttons.dart';
import '../utility/appColors.dart';
import '../utility/appDimens.dart';
import '../utility/utility.dart';

class VerificationScreen extends StatefulWidget {
  String countrycode;
  String mobile;

  VerificationScreen({@required this.mobile, @required this.countrycode});

  @override
  _VerificationScreenPageState createState() => _VerificationScreenPageState();
}

class _VerificationScreenPageState extends State<VerificationScreen> {
  String otp = "";
  AppDimens appDimens;
  bool isLoading = false;
  String _verificationId;
  bool autovalidate = false;
  bool isButtonEnable = false;
  Size size;
  MediaQueryData mediaQuerydata;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  void _verifyPhoneNumber() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Utility.showToast(msg: authException.message);
      print(authException.code);
      print(authException.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print("codeSent");
      print(verificationId);
      Utility.showToast(
          msg: "Please check your phone for the verification code.");
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("codeAutoRetrievalTimeout");
      _verificationId = verificationId;
    };

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      print("verificationCompleted");
    };

    if (kIsWeb) {
      await _auth
          .signInWithPhoneNumber(
        widget.countrycode + widget.mobile,
      )
          .then((value) {
        _verificationId = value.verificationId;
        print("then");
      }).catchError((onError) {
        print(onError);
      });
    } else {
      await _auth
          .verifyPhoneNumber(
              phoneNumber: widget.countrycode + widget.mobile,
              timeout: const Duration(seconds: 5),
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
          .then((value) {
        print("then");
      }).catchError((onError) {
        print(onError);
      });
    }

    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  void _signInWithPhoneNumber(String otp) async {
    _showProgressDialog(true);
    if (await Utility.checkInternet()) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );
        final User user = (await _auth.signInWithCredential(credential)).user;
        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        _showProgressDialog(false);
        if (user != null) {
          print("Mobile number authentication successful");
          print(user);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          Utility.showToast(msg: "Sign in failed");
        }
      } catch (e) {
        print(e);

        Utility.showToast(msg: e.toString());
        _showProgressDialog(false);
      }
    } else {
      _showProgressDialog(false);
      Utility.showToast(msg: "No internet connection");
    }
  }

  _showProgressDialog(bool isloadingstate) {
    if (mounted)
      setState(() {
        isLoading = isloadingstate;
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  verifyOtp(String otpText) async {
    _signInWithPhoneNumber(otpText);
  }

  OtpFieldController otpController = OtpFieldController();
  var checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    mediaQuerydata = MediaQuery.of(context);
    size = MediaQuery.of(context).size;
    appDimens = new AppDimens(MediaQuery.of(context).size);
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: appDimens.paddingw2),
              alignment: Alignment.center,
              child: Text(
                "ENTER VERIFICATION CODE",
                style: TextStyle(
                  fontSize: appDimens.text20,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 20,
              ),
              child: OTPTextField(
                controller: otpController,
                length: 6,
                fieldWidth: 45,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 5,
                style: TextStyle(
                  fontSize: appDimens.text20,
                  color: AppColors.accentColor,
                ),
                onChanged: (pin) {
                  print("Changed: " + pin);
                  otp = pin;
                  checkButtonEnable();
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: appDimens.paddingw16 * 2,
                right: appDimens.paddingw16 * 2,
              ),
              alignment: Alignment.center,
              child: Text(
                "Please enter verification code that was sent to ${widget.countrycode + " " + widget.mobile}",
                style: TextStyle(
                  fontSize: appDimens.text16,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 20),
            createOrangeBTN(
                title: "Login",
                onPressedd: () {
                  if (isButtonEnable) {
                    _onButtonClick();
                  }
                },
                isButtonEnable: isButtonEnable,
                color: AppColors.greenColor,
                textColor: AppColors.whiteColor),
            CheckboxListTile(
              //"I agree to the Terms of Use and Privacy Policy"
              title: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "I agree to the ",
                      style: TextStyle(color: AppColors.whiteColor,fontSize: appDimens.text14)),
                  TextSpan(
                      text: "Terms of Use ",
                      style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize: appDimens.text14,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "and ",
                      style: TextStyle(color: AppColors.whiteColor,fontSize: appDimens.text14)),
                  TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize: appDimens.text14,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
              value: checkBoxValue,
              onChanged: (v) => {_onCheckedChanged()},
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        )));
  }

  void _onCheckedChanged() {
    setState(() {
      checkBoxValue = !checkBoxValue;
      print("CheckBox value: $checkBoxValue");
      checkButtonEnable();
    });
  }

  void checkButtonEnable() {
    setState(() {
      if (checkBoxValue && otp.length == 6) {
        isButtonEnable = true;
      } else {
        isButtonEnable = false;
      }
    });
  }

  _onButtonClick() {
    verifyOtp(otp);
  }
}
