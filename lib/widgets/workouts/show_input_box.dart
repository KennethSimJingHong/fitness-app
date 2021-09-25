import 'package:fitness_app/constant.dart';
import 'package:fitness_app/providers/exercise.dart';
import 'package:fitness_app/widgets/workouts/counter.dart';
import 'package:fitness_app/widgets/workouts/radio_button.dart';
import 'package:flutter/material.dart';



final _formKey = GlobalKey<FormState>();

showInputBox(BuildContext context, List list, Function chgIndex, Function addOn, Function minusOut, Function addItem, Function getInfo, String val,Function toBeChange, String input, Exercise result){
    String titleVal="";

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: val != "update" ? Text("Add Execrise") : Text("Update Exercise"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height:10),
            RadioButton(list, list.indexOf(result.category != null ? result.category : 0), chgIndex),
            SizedBox(height:20),
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Exercise Title"),
                initialValue: result.title == null ? titleVal: result.title,
                onSaved: (val){
                
                  titleVal = val;
                },           
              ),
            ),
            SizedBox(height:30),
            Counter(addOn,minusOut,result.setCount == null ? 1 : result.setCount ,result.repCount == null ? 1 : result.repCount),
            SizedBox(height:20),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    child: Text("Cancel"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    color: kLightRedColor,
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                  
                    child: val != "update" ? Text("Confirm") : Text("Update"),
                    onPressed: (){
                      if(val == "add"){
                        _formKey.currentState.save();
                        addItem(result.title == null ? titleVal: result.title);
                        Navigator.of(context).pop();
                      }

                      if(val == "update"){
                          _formKey.currentState.save();
                          toBeChange(true,titleVal == "" ? result.title : titleVal,input);
                          Navigator.of(context).pop();
                      }
                      
                    },
                    color: kWhiteColor,
                  ),
                ),
              ],
            ),
          ],
        )
      );
    });
  }