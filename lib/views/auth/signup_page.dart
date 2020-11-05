import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechapp/partials/utils/constants.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/partials/widgets/show_exception_alert_dialog.dart';
import 'package:mechapp/views/auth/signin_page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({this.from});
  String from;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false, _autoValidate = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appBackground));
    return GestureDetector(
      onTap: () {
        offKeyboard(context);
      },
      child: LoadingOverlay(
        progressIndicator: CupertinoActivityIndicator(radius: 20),
        isLoading: isLoading,
        color: Colors.grey,
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Styles.appBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Styles.appPrimaryColor),
        leading: GestureDetector(
          onTap: () {
            if (widget.from == "Walkthrough") {
              moveToReplace(context, SigninPage());
            } else {
              Navigator.pop(context);
            }
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Styles.appPrimaryColor,
          ),
        ),
        backgroundColor: Styles.appBackground,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Step 1/2",
                style: TextStyle(
                    color: Styles.appPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/signup.svg",
                    width: 200,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Create New Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  "It takes just a minute to set up your account and start using PSB Academy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Styles.whiteColor,
                        hintColor: Styles.whiteColor),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Styles.whiteColor,
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      controller:name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Styles.whiteColor,
                        hintColor: Styles.whiteColor),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Styles.whiteColor,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                        controller:email
                        ,


                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Styles.whiteColor,
                        hintColor: Styles.whiteColor),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Styles.whiteColor,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller:password,

                      validator: (value){
                        if (value.isEmpty) {
                          return 'Please enter your password!';
                        } else if (value.length < 6) {
                          return 'Password must be greater than 6 characters!';
                        }
                        return null;
                      },

                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
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
                        if(name.text.isEmpty|| email.text.isEmpty || password.text.isEmpty){
                          showCenterToast("No Field cannot be Empty", context);
                          return;
                        }

                        signUp();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "SIGNUP",
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    color: Styles.appPrimaryColor,
                                    fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => SigninPage()),
                                        (Route<dynamic> route) => false);
                                  }),
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //  mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "By signing up you agree to PSB Academy's ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Terms and Condition',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Styles.appPrimaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // navigate to desired screen
                                    }),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Styles.appPrimaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // navigate to desired screen
                                    }),
                            ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
        ),
      ),
    );
  }
  Future signUp() async {
    _formKey.currentState.save();
    _formKey.currentState.validate();

    setState(() {
      _autoValidate = true;
    });

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    await _auth
        .createUserWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      FirebaseUser user = value.user;

      if (value.user != null) {
        user.sendEmailVerification().then((v) {
          Map<String, Object> mData = Map();
          mData.putIfAbsent("Name", () => name.text);
          mData.putIfAbsent("Email", () => email.text);
          mData.putIfAbsent("Uid", () => user.uid);
          mData.putIfAbsent(
              "Timestamp", () => DateTime.now().millisecondsSinceEpoch);

          Firestore.instance
              .collection("All")
              .document(user.uid)
              .setData(mData)
              .then((val) {

            showCupertinoDialog(
                context: context,
                builder: (_) {
                  return CupertinoAlertDialog(
                    content: Text(
                      "User created, Check email for verification. Thanks for using FVast",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Styles.appPrimaryColor),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SigninPage()),
                                        (Route<dynamic> route) => false);
                              },
                              child: Text(
                                "  OK  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                });

            setState(() {
              _autoValidate = false;
              isLoading = false;
            });
          }).catchError((e) {
            showExceptionAlertDialog(
                context: context, exception: e, title: "Error");
            setState(() {
              isLoading = false;
            });
          });
        }).catchError((e) {
          showExceptionAlertDialog(
              context: context, exception: e, title: "Error");
          setState(() {
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
      return;
    }).catchError((e) {
      showExceptionAlertDialog(context: context, exception: e, title: "Error");
      setState(() {
        isLoading = false;
      });
      return;
    });
  }


}
