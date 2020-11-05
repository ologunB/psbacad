import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechapp/partials/utils/constants.dart';
import 'package:mechapp/partials/utils/styles.dart';
import 'package:mechapp/partials/widgets/show_exception_alert_dialog.dart';
import 'package:mechapp/views/auth/signup_page.dart';
import 'package:mechapp/views/partials/layout_template.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgetPassController = TextEditingController();
  bool isLoading = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  Future signIn(String email, String password, context) async {
    if (emailController.text.toString().isEmpty) {
      showEmptyToast("Email", context);
      return;
    } else if (passwordController.text.toString().isEmpty) {
      showEmptyToast("Password", context);
      return;
    }

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
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseUser user = value.user;

      if (value.user != null) {
        if (!value.user.isEmailVerified) {
          setState(() {
            isLoading = false;
          });
          showCupertinoDialog(
              context: context,
              builder: (_) {
                return CupertinoAlertDialog(
                  title: Text(
                    "Email not verified!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 17),
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
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "OK",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
          _firebaseAuth.signOut();
          return;
        }
        Firestore.instance
            .collection('All')
            .document(user.uid)
            .get()
            .then((document) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => LayoutTemplate()),
              (Route<dynamic> route) => false);

          putInDB(document.data["Uid"], document.data["Email"],
              document.data["Name"]);
        }).catchError((e) {
          setState(() {
            isLoading = false;
          });
          showExceptionAlertDialog(
              context: context, exception: e, title: "Error");
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _firebaseAuth.signOut();
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

  Future putInDB(String uid, String email, String name) async {
    final Box<String> userDetailsBox = Hive.box(userDetails);
    userDetailsBox.put("isLoggedIn", "true");
    userDetailsBox.put("uid", uid);
    userDetailsBox.put("email", email);
    userDetailsBox.put("name", name);
    setState(() {

    });
  }

  Future resetEmail(String email) async {
    if (forgetPassController.text.isEmpty) {
      showEmptyToast("Email", context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    await _firebaseAuth
        .sendPasswordResetEmail(email: forgetPassController.text)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      forgetPassController.clear();
      Navigator.pop(context);
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text(
                "Reset email sent!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            );
          });
    }).catchError((e) {
      showExceptionAlertDialog(context: context, title: "Error", exception: e);
    });
  }

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
          backgroundColor: Styles.appBackground,
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 3,
                        child: SvgPicture.asset(
                          "assets/images/login_img.svg",
                          width: 250,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "PSB ACADEMY!",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.appPrimaryColor),
                            ),
                          ],
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Styles.whiteColor,
                              hintColor: Styles.whiteColor),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                fillColor: Styles.whiteColor,
                                filled: true,
                                suffixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Enter Email',
                                hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Styles.whiteColor,
                              hintColor: Styles.whiteColor),
                          child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password!';
                              } else if (value.length < 6) {
                                return 'Password must be greater than 6 characters!';
                              }
                              return null;
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                              fillColor: Styles.whiteColor,
                              filled: true,
                              suffixIcon: Icon(Icons.lock),
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (_) => CupertinoAlertDialog(
                                    title: Column(
                                      children: <Widget>[
                                        Text("Enter Email"),
                                      ],
                                    ),
                                    content: CupertinoTextField(
                                      controller: forgetPassController,
                                      placeholder: "Email",
                                      padding: EdgeInsets.all(10),
                                      keyboardType: TextInputType.emailAddress,
                                      placeholderStyle: TextStyle(
                                          fontWeight: FontWeight.w300),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Styles.appPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: FlatButton(
                                              onPressed: () {
                                                resetEmail(
                                                  forgetPassController.text,
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Text(
                                                      "Reset Password",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Styles.appPrimaryColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Styles.appPrimaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    signIn(emailController.text,
                                        passwordController.text, context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          "LOGIN",
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
                            flex: 7,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                SignupPage(from: "null")));
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            flex: 4,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
