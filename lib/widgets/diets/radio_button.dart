import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  int group;
  RadioButton(this.group);
  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Male"),
        Radio(  
          value: 1,
          groupValue: widget.group, 
          onChanged: (val){
            setState(() {
              widget.group = val;
            });
          }
          
        ),
        Text("Female"),
        Radio(
          value: 2,
          groupValue: widget.group, 
          onChanged: (val){
            setState(() {
              widget.group = val;
            });
          }
        ),
      ],
    );
  }
}