import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  const CustomText({Key key, this.text, this.size, this.color, this.weight}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      child: new Column(
        children: [
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: size ?? 16, color: color ?? Colors.black, fontWeight: weight ?? FontWeight.normal),
            ),
          )
        ],
      ),
    )

      ;
  }
}
