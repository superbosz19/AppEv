import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextLabel extends StatefulWidget{
  final Widget label;
  final Widget text;
  final TextLabelDisplayFormat position;


  const TextLabel({this.label, this.text, this.position :TextLabelDisplayFormat.TEXTRIGHT}) : super();


  @override
  State<StatefulWidget> createState() => _TextLabelState();
  
}

class _TextLabelState extends State<TextLabel>{
  @override
  Widget build(BuildContext context) {
    if (widget.position == TextLabelDisplayFormat.TEXTBELOW) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label,
          SizedBox(height: 5),
          widget.text
        ],
      );
    }else if (widget.position == TextLabelDisplayFormat.TEXTRIGHT) {
      return Row(
          children: [
            widget.label,
            SizedBox(width: 3),
            widget.text
          ],
        );
    }else if (widget.position == TextLabelDisplayFormat.TEXTLEFT) {
      return Row(
        children: [
          widget.text,
          SizedBox(width: 3),
          widget.label
        ],
      );
    }

  }
  
}

enum TextLabelDisplayFormat {
  TEXTBELOW,
  TEXTRIGHT,
  TEXTLEFT,
}