import 'package:fitness_app/constant.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
  class RadioButton extends StatefulWidget {
    List<String> list;
    int selectedIndex;
    void Function(int index) chgIndex;
    RadioButton(this.list,this.selectedIndex, this.chgIndex);
    @override
    _RadioButtonState createState() => _RadioButtonState();
  }
  
  class _RadioButtonState extends State<RadioButton> {

    @override
    Widget build(BuildContext context) {
      return Wrap(
        spacing: 10,
        children:[
          customRadio(widget.list[0], 0),
          customRadio(widget.list[1], 1),
          customRadio(widget.list[2], 2),
          customRadio(widget.list[3], 3),
          customRadio(widget.list[4], 4),
          customRadio(widget.list[5], 5),
        ],
      );
    }

    Widget customRadio(String txt, int i){
      return RaisedButton(
        onPressed: (){
          widget.chgIndex(i);
          setState(() {
            widget.selectedIndex = i;
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
        color: widget.selectedIndex == i ? kDarkBlueColor : kWhiteColor,
        child: Text(txt, style: TextStyle(color: widget.selectedIndex == i ? kWhiteColor : kDarkBlueColor),),
      );
    }
  }





