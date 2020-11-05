import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:mechapp/partials/utils/constants.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/views/attendance/attend_view.dart';
import 'package:mechapp/views/home/home_view.dart';
import 'package:mechapp/views/pay_fees/pay_fees.dart';
import 'package:mechapp/views/schedule/schedule_view.dart';
import 'package:mechapp/views/settings/setting_view.dart';

class LayoutTemplate extends StatefulWidget {
  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  final List<Widget> pages = [
    AttendanceView(),
    PayView(),
    HomeView(),
    ScheduleView(),
    SetingsView()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  int pageSelectedIndex = 2;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return Scaffold(
      body: PageStorage(
        child: pages[pageSelectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 15,
          onTap: (i) {
            setState(() {
              pageSelectedIndex = i;
            });
          },
          currentIndex: pageSelectedIndex,
          selectedItemColor: Styles.appPrimaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Entypo.wallet, size: 20),
                //   icon:  Icon(Fontisto.wallet, size: 20,),
                //  icon:  Icon(Ionicons.ios_wallet, size: 20,),
                title: Text(
                  "Attendance",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                )),
            BottomNavigationBarItem(
                icon: Icon(Entypo.wallet, size: 20),
                //   icon:  Icon(Fontisto.wallet, size: 20,),
                //  icon:  Icon(Ionicons.ios_wallet, size: 20,),
                title: Text(
                  "Pay Fees",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                )),
            BottomNavigationBarItem(
                icon: Icon(Octicons.home),
                title: Text("Home",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
            BottomNavigationBarItem(
                icon: Icon(Octicons.tools, size: 20),
                title: Text("Schedule",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
            BottomNavigationBarItem(
                icon: Icon(Octicons.settings, size: 20),
                title: Text("Settings",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
          ]),
    );
  }
}
