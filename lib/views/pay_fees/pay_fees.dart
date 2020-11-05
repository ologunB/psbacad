import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:hive/hive.dart';
import 'package:mechapp/partials/utils/constants.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/views/auth/signin_page.dart';
import 'package:mechapp/views/home/home_view.dart';
import 'package:table_calendar/table_calendar.dart';

class PayView extends StatefulWidget {
  @override
  _PayViewState createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _stripePayment = FlutterStripePayment();

  @override
  void initState() {
    _stripePayment.setStripeSettings(
        "pk_test_51HjsXiD2Y81WySxc7QABgdzvHrFhXXF4HBbff1DftHiqdDAxwUhjBSqlvfqKVFXZsFlVDJdyFoirbpcJGIspCkzS00aF50plJb",
        "sk_test_51HjsXiD2Y81WySxcSYZQxWqgom4mPTou65NDgdWwJ8PECjIT98CwUU4vyudP4BpSrZDjp4elhfPXcakUcHQia3bg00zX1RDDdo");

    super.initState();
  }

  Account selectedAccount;

  Future afterLogout() {
    FirebaseAuth.instance.signOut().then((a) async {
      final Box<String> userDetailsBox = Hive.box(userDetails);
      userDetailsBox.delete("isLoggedIn");
      userDetailsBox.delete("uid");
      userDetailsBox.delete("email");
      userDetailsBox.delete("name");
      setState(() {});

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
                        "Pay Fees",
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 100,
                                color: Colors.black26,
                                spreadRadius: 10)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Text(
                            "Student Name: ",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Text(
                            MY_NAME,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 100,
                                color: Colors.black26,
                                spreadRadius: 10)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Text(
                            "Invoice For: ",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Expanded(
                            child: DropdownButton<Account>(
                              hint: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text("Select the Fee"),
                              ),
                              value: selectedAccount,
                              underline: SizedBox(),
                              items: accountList.map((value) {
                                return DropdownMenuItem<Account>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              value.name,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Text("Amount:"),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text("₦" + value.amount)
                                              ],
                                            )
                                          ],
                                          mainAxisSize: MainAxisSize.min,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  selectedAccount = value;
                                });
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Styles.appPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          if (selectedAccount == null) {
                            showCenterToast("Select a fee", context);
                            return;
                          }

                          payNow();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "PAY NOW",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
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
  payNow() async{


    var paymentResponse = await _stripePayment.addPaymentMethod();
    setState(() {
      if (paymentResponse.status ==
          PaymentResponseStatus.succeeded) {
     //   _paymentMethodId = paymentResponse.paymentMethodId;
      } else {
     //   _errorMessage = paymentResponse.errorMessage;
      }
    });
  }
}

class Account {
  String name, amount;

  Account(this.name, this.amount);
}

List<Account> accountList = [
  Account("School Fees", "2000"),
  Account("Gate Fees", "3000"),
  Account("Food Fees", "4000"),
  Account("Laundry Fees", "1000"),
  Account("Book Fees", "500"),
];
