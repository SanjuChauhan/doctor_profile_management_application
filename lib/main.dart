import 'package:doctor_profile_management_application/screens/loginWithPhone.dart';
import 'package:doctor_profile_management_application/utility/appColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //most important thing is to initialise firebase in project
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(MyApp());
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: AppColors.primaryColor,
          primaryColorDark: AppColors.primaryDarkColor,
          accentColor: AppColors.accentColor,

          fontFamily: 'Roboto',

        ),
        home: LoginWithPhone(),
      ),
    );
  }
}
