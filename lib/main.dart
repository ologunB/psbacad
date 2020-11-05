import 'package:flutter/material.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mechapp/partials/utils/constants.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/views/auth/signin_page.dart';
import 'package:mechapp/views/partials/layout_template.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(userDetails);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSB Acad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
     //   primarySwatch: MaterialColor(0xFF7966FF),
        primaryColor: Styles.appPrimaryColor,
        fontFamily: "AvenirNext",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyWrapper(),
    );
  }
}

class MyWrapper extends StatefulWidget {
  @override
  _MyWrapperState createState() => _MyWrapperState();
}

class _MyWrapperState extends State<MyWrapper> {
  Box<String> userDetailsBox;
  String uid, isLoggedIn;

  @override
  void initState() {
    super.initState();
    userDetailsBox = Hive.box(userDetails);
    assign();
  }

  void assign() async {
    MY_UID = userDetailsBox.get('uid');
    MY_NAME = userDetailsBox.get('name');
    MY_EMAIL = userDetailsBox.get('email');
  }

  @override
  Widget build(BuildContext context) {
    uid = userDetailsBox.get('uid');
    isLoggedIn = userDetailsBox.get('isLoggedIn') ?? "false";
    if (isLoggedIn == "true") {
      return LayoutTemplate();
    } else {
      return SigninPage();
    }
  }
}
