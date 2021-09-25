import 'package:fitness_app/constant.dart';
import 'package:fitness_app/screens/diets/diet_screen.dart';
import 'package:fitness_app/widgets/diets/radio_button.dart';
import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  Function(String height, String weight, String gender, String age, String minutes) addItem;
  InputForm(this.addItem);
  @override
  _InputFormState createState() => _InputFormState();
}
    
class _InputFormState extends State<InputForm> {
    int group = 1;
    String age="";
    String weight="";
    String height="";
    String minutes = "";
    
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Form(
            key:_formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Age"),
                  onSaved: (val){
                    age = val;
                  },
                ),
                SizedBox(height:20),
                RadioButton(group),
                SizedBox(height:20),
                TextFormField(
                  decoration: InputDecoration(hintText: "Weight in kg"),
                  onSaved: (val){
                    weight = val;
                  },
                ),
                SizedBox(height:20),
                TextFormField(
                  decoration: InputDecoration(hintText: "Height in cm"),
                  onSaved: (val){
                    height = val;
                  },
                ),
                SizedBox(height:20),
                TextFormField(
                  decoration: InputDecoration(hintText: "Exercise per time (minute)"),
                  keyboardType: TextInputType.number,
                  onSaved: (val){
                    minutes = val;
                  },
                ),
                SizedBox(height:20),
                DropDownChoice(),

                
                SizedBox(height:20),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(18)),
                  child: Text("Confirm", style: TextStyle(color: kDarkBlueColor)),
                  color: kWhiteColor,
                  onPressed: (){
                    _formkey.currentState.save();
                    widget.addItem(height,weight,group == 1 ? "male" : "female",age,minutes);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
  }
}


showDiettBox(BuildContext context, Function addItem){
  

  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Tell us about you"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputForm(addItem),
        ],
      ),
    );
  });
}

class DropDownChoice extends StatefulWidget {
  @override
  _DropDownChoiceState createState() => _DropDownChoiceState();
}

class _DropDownChoiceState extends State<DropDownChoice> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        DropdownButton<String>(
          hint: Text("Exercise Level"),
          items: <String>['Very Light (< 1 exercsise)', 'Light (1-2 exercises)', 'Moderate (3-4 exercises)', 'Heavy (5-6 exercises)', 'Very Heavy (> 6 exercises)'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                exerciseLvl = val;
              });
            },
          ),
        Text(exerciseLvl == "" ? "Select Exercise Level": exerciseLvl),
      ],
    );
  }
}

String exerciseLvl = "";