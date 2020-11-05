import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/views/home/home_view.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceView extends StatefulWidget {
  @override
  _AttendanceViewState createState() => _AttendanceViewState();
}


class _AttendanceViewState extends State<AttendanceView> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
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
                children: [
                  SizedBox(height: 40),
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
                                          // afterLogout();
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
                        "Attendance",
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
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 100,
                              color: Colors.black26,
                              spreadRadius: 10)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              eachItem("5", "Total Days"),
                              eachItem("3", "Present"),
                              eachItem("2", "Absent "),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  TableCalendar(
                    calendarController: _calendarController,

                  )

                ],
              ),
            )
          ],
        ));


  }

  Widget eachItem(number, text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(
            number,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        )
      ],
    );
  }
}
