import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechapp/partials/utils/carousel_slider.dart';
import 'package:mechapp/partials/utils/constants.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/views/auth/signin_page.dart';
import 'package:hive/hive.dart';
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width - size.width / 4, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Future logout() {
    FirebaseAuth.instance.signOut().then((a) async {
      final Box<String> userDetailsBox = Hive.box(userDetails);
      userDetailsBox.clear();
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
            SingleChildScrollView(
              child: Padding(
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
                                                logout();
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
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.0),
                            child: Container(
                              color: Styles.appCanvasColor,
                              padding: EdgeInsets.all(3),
                              child: Image(
                                  image: AssetImage("assets/images/person.png"),
                                  height: 44,
                                  width: 44,
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MY_NAME,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              MY_EMAIL,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w100),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Level: "),
                                Text(
                                  "200L",
                                  style: TextStyle(
                                       fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    CarouselSlider(
                     // height: MediaQuery.of(context).size.height / 3,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      pauseAutoPlayOnTouch: Duration(seconds: 5),
                      items: [1, 1, 1].map((i) {
                        return Builder(
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.black12,
                                          spreadRadius: 5)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),

                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    mediumVerticalSpacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming Events",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                    Container(
                      height: 120,
                      child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 250,
                                decoration: BoxDecoration(
                                    color: Styles.appCanvasColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            );
                          }),
                    ),
                    mediumVerticalSpacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "News",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 130,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Styles.appCanvasColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            );
                          }),
                    ),
                    mediumVerticalSpacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Promotions",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                    Container(
                      height: 120,
                      child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 220,
                                decoration: BoxDecoration(
                                    color: Styles.appCanvasColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget eachItem(image, text, Widget view) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => view));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Image.asset(
              image,
              height: 35,
              width: 35,
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
      ),
    );
  }

  Widget eachItem2(image, text) {
    return Expanded(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Image.asset(image),
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          )
        ],
      ),
    ));
  }
}

class BackGround extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Styles.appPrimaryColor;
    paint.strokeWidth = 100;
    paint.isAntiAlias = true;

    Paint paint2 = new Paint();
    paint2.color = Styles.appBackground;
    paint2.strokeWidth = 100;
    paint2.isAntiAlias = true;

    canvas.drawLine(
        Offset(300, -120), Offset(size.width + 60, size.width - 280), paint2);
    canvas.drawLine(
        Offset(200, -80), Offset(size.width + 60, size.width - 160), paint);
    canvas.drawLine(
        Offset(100, -40), Offset(size.width + 60, size.width - 40), paint2);
    canvas.drawLine(
        Offset(0, 0), Offset(size.width + 60, size.width + 80), paint);
    canvas.drawLine(
        Offset(-100, 40), Offset(size.width + 60, size.width + 200), paint2);
    canvas.drawLine(
        Offset(-200, 90), Offset(size.width + 60, size.width + 320), paint);
    canvas.drawLine(
        Offset(-300, 140), Offset(size.width + 60, size.width + 440), paint2);
    canvas.drawLine(
        Offset(-400, 190), Offset(size.width + 60, size.width + 560), paint);
    canvas.drawLine(
        Offset(-500, 240), Offset(size.width + 60, size.width + 680), paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
