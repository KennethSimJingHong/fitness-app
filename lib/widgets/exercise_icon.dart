import 'package:fitness_app/constant.dart';
import 'package:flutter/material.dart';

Widget exeIcon(String iconname){
  return Container(
    decoration: BoxDecoration(
      color: kLightBlueColor,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    padding: EdgeInsets.all(6),
    child: Image.asset(
      "assets/images/$iconname.png",
      width: 45,
      height:45,
      color: kWhiteColor,
      ),
  );
}