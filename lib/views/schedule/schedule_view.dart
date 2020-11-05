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

class ScheduleView extends StatefulWidget {
  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
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
      backgroundColor: Styles.appPrimaryColor,
        key: _drawerKey,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
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
                        "School Schedule",
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
                ),
                Expanded(
                  //   height: 500,
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      primary: false,
                      appBar: AppBar(
                       primary: false,
                        title: TabBar(
                          indicatorPadding: EdgeInsets.symmetric(vertical: -10),
                          indicatorWeight: 3,
                          indicatorColor: Colors.white,
                          isScrollable: true,
                          tabs: [
                            Text(
                              "Mon, 12 May",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Mon, 13 May",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Mon, 14 May",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        // bottom: SizedBox(),
                      ),
                      body: TabBarView(
                        children: [
                          page(),
                          Icon(Icons.directions_transit),
                          Icon(Icons.directions_bike),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget page() {
    return Container(
      child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Styles.appCanvasColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.title),
                        ),
                        Expanded(
                            child: Text(
                              "SET CU 303COM Individual ProjectPart B Lec 01",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.timer),
                        ),
                        Expanded(
                            child: Text(
                              "01:00 PM - 03:00 PM",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.merge_type),
                        ),
                        Expanded(
                            child: Text(
                              "Lecture",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.location_on),
                        ),
                        Expanded(
                            child: Text(
                              "Online",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
