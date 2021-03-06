import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechapp/partials/utils/styles.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final bool includeHeader, isLoading;
  final void Function() onClicked;
  final BuildContext context;

  CustomDialog(
      {Key key,
      this.title,
      this.isLoading,
      this.onClicked,
      this.includeHeader = false,
      this.context})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: widget.includeHeader == true ? Text("Confirmation!") : null,
      content: Text(
        widget.title,
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.red),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "NO",
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
        Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Styles.appPrimaryColor,
              ),
              child: FlatButton(
                onPressed: () {
                  widget.onClicked();
                },
                child: widget.isLoading ?? false
                    ? CupertinoActivityIndicator()
                    : Text(
                        "YES",
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
  }
}
