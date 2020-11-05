import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mechapp/partials/utils/constants.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/views/auth/signin_page.dart';
import 'package:mechapp/views/home/home_view.dart';

class SetingsView extends StatefulWidget {
  @override
  _SetingsViewState createState() => _SetingsViewState();
}

class _SetingsViewState extends State<SetingsView> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Future afterLogout() {
    FirebaseAuth.instance.signOut().then((a) async {
      final Box<String> userDetailsBox = Hive.box(userDetails);
      userDetailsBox.delete("isLoggedIn");
      userDetailsBox.delete("uid");
      userDetailsBox.delete("email");
      userDetailsBox.delete("name");
      setState(() {

      });

      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => SigninPage()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return Scaffold(
        key: _drawerKey,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 3,
                    child: ClipPath(
                      clipper: BottomWaveClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Styles.appPrimaryColor,
                            gradient: new LinearGradient(
                                colors: [
                                  Styles.appPrimaryColor,
                                  // Styles.appCanvasColor,
                                  Color(0xFFB183F7),
                                ],
                                begin: const FractionalOffset(0.0, 0.5),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp)),
                      ),
                    )),
                Expanded(
                  child: Container(),
                  flex: 6,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(

                children: [                  SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(
                          EvaIcons.person,
                          color: Colors.white,
                          size: 28,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                    content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          "PROFILE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )),
                                    FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          "TERMS AND CONDITIONS",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )),
                                    FlatButton(
                                        onPressed: () {
                                          afterLogout();
                                        },
                                        child: Text(
                                          "LOGOUT",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ],
                                ));
                              });
                        },
                      ),
                      Expanded(
                          child: Center(
                              child: Text(
                        "Settings",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ))),
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Center(
                      child: Icon(
                    Icons.settings,
                    size: 100,
                    color: Colors.white,
                  )),   SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Styles.appPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("WE WILL GO LIVE SOON ENOUGH", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Styles.appPrimaryColor),),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
