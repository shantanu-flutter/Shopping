import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final String logoText;
  final double textSize;
  final Color textColor;
  const LogoText({Key key, this.logoText, this.textSize, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: textColor, width: textSize/15),
          borderRadius: BorderRadius.all(Radius.circular(
              6.0) //                 <--- border radius here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Text(
            logoText,
            style: new TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: FontWeight.w300),
          ),
        ));
  }
}
