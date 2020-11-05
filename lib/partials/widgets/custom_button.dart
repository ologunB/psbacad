import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechapp/partials/utils/styles.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final void Function() onPress;

  CustomButton({
    Key key,
    @required this.title,
    @required this.onPress,
  }) : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Styles.appPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FlatButton(
          onPressed: () {
            widget.onPress();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
