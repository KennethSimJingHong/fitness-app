

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/providers/user.dart';
import 'package:fitness_app/screens/diets/diet_cal_list.dart';
import 'package:fitness_app/screens/diets/remaining_stat.dart';
import 'package:fitness_app/widgets/app_drawer.dart';
import 'package:fitness_app/widgets/diets/show_info_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DietScreen extends StatefulWidget {
  final User userinfo;
  DietScreen(this.userinfo);
  static const routeName = "./diet";

  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  addItem(String height, String weight, String gender, String age, String minutes){
    DocumentReference ref = Firestore.instance.collection("users").document(widget.userinfo.id);
      ref.updateData({
        "height": height,
        "weight":weight,
        "gender":gender,
        "age":age,
        "exercise":exerciseLvl,
        "minutes":minutes,
      });
    }

  int total = 0;

  addMeal(String title, String cal){
    DocumentReference ref = Firestore.instance.collection("diet").document();
      ref.setData({
        "title":title,
        "calories":cal,
        "user_id":widget.userinfo.id,
        "documentId":ref.documentID,
      });
      checkItem();
  }

  deleteMeal(String index){
    Firestore.instance.collection("diet").document(index).delete();
    checkItem();
  }

  checkItem(){
    Firestore.instance.collection("diet").snapshots().listen((data) {
      total = 0;
      data.documents.forEach((doc) {
          setState(() {
            total += double.parse(doc["calories"]).toInt();
          });
      });
      if(data.documents.length == 0){
        setState(() {
          total = 0;
        });
      }
    });
  }

  leanFactor(String gender, double age){
    if(gender == "male"){
      if(age >= 10 && age <= 14)
      return 1.0;
      if(age >= 15 && age <= 20)
      return 0.95;
      if(age >= 21 && age <= 28)
      return 0.90;
      if(age > 28)
      return 0.85;
    }else{
      if(age >= 14 && age <= 18)
      return 1.0;
      if(age >= 19 && age <= 28)
      return 0.95;
      if(age >= 29 && age <= 38)
      return 0.90;
      if(age > 38)
      return 0.85;
    }
  }

  exerciseLevel(String exercise){
    if(exercise == 'Very Light (< 1 exercsise)')
    return 1.3;
    if(exercise == 'Light (1-2 exercises)')
    return 1.55;
    if(exercise == 'Moderate (3-4 exercises)')
    return 1.65;
    if(exercise == 'Heavy (5-6 exercises)')
    return 1.80;
    if(exercise == 'Very Heavy (> 6 exercises)')
    return 2.00;

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBlueColor,
      appBar: AppBar(
        title: Text("Diet"),
        backgroundColor: kLightBlueColor,
        elevation: 0,   
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              exerciseLvl = "";
              showDiettBox(context,addItem);
            },
          )
        ],
      ),
      drawer: AppDrawer(widget.userinfo.username,widget.userinfo.userImage),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: kLightBlueColor,
          child: StreamBuilder(
            stream: Firestore.instance.collection("users").document(widget.userinfo.id).snapshots(),     
            builder: (ctx,snapShot){
              if(!snapShot.hasData){
                return Container();
              }
              // count calories
              double val = leanFactor(snapShot.data["gender"], double.parse(snapShot.data["age"]));
              double stats = double.parse(snapShot.data["weight"]) * (snapShot.data["gender"] == "male" ? 1 : 0.9) * 24 * val;
              double exercise = exerciseLevel(snapShot.data["exercise"]);
              double totalCal = (stats * exercise).roundToDouble();
              
              int gainWeight = totalCal.toInt() + 250;
              int loseWeight = totalCal.toInt() - 250;
              
              // count water
              double dailyMustWater = double.parse(snapShot.data["weight"]) / 30 * 1000;
              double addOnWaterAmt = double.parse(snapShot.data["minutes"]) / 30 * 350;
              double totalWater = (dailyMustWater + addOnWaterAmt).roundToDouble();
              return Column(                        
                children:[

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width:350,
                    height:150,
                    color: kWhiteColor,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Daily Intake Requirement", style: TextStyle(color: kLightBlueColor, fontSize: 18, fontWeight: FontWeight.bold),),   
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children:[
                            Column(children: [
                              Icon(FontAwesomeIcons.hamburger, color: kLightBlueColor,),
                              SizedBox(height: 10,),
                              Text("${totalCal.toInt()} cal", style: TextStyle(color: kLightBlueColor, fontSize: 16, fontWeight: FontWeight.bold),),
                            ],),
                            SizedBox(width: 50,),
                            Column(children: [
                              Icon(FontAwesomeIcons.glassWhiskey, color: kLightBlueColor),
                              SizedBox(height: 10,),
                              Text("${totalWater.toInt()} ml", style: TextStyle(color: kLightBlueColor, fontSize: 16, fontWeight: FontWeight.bold),),
                            ],),
                          ],
                        ),
                    ],),
                  ),
                ),
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: kWhiteColor,
                    height: 300,
                    width:350,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Today's Meal Status" ,style: TextStyle(color: kLightBlueColor, fontSize: 18, fontWeight: FontWeight.bold),), 
                        SizedBox(height: 20,),
                        
                        RemainingStat(gainWeight, loseWeight,total),
                        SizedBox(height:10),
                        Expanded(
                          child: StreamBuilder(
                            stream: Firestore.instance.collection("diet").snapshots(),
                            builder: (ctx, snapShot){
                              if(!snapShot.hasData){
                                return Container();
                              }
                              return DietCalList(snapShot.data.documents,widget.userinfo,deleteMeal);
                            },
                          )
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.all(20),
                            child: ButtonTheme(
                              minWidth: 50,
                              height: 50,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.add, color: kLightBlueColor,),
                                onPressed: (){
                                  showCalBox(context,addMeal);
                                },
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),  
                SizedBox(height: 20,),  
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: kWhiteColor,
                    height:290,
                    width: 350,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Today's Hydration Status" ,style: TextStyle(color: kLightBlueColor, fontSize: 18, fontWeight: FontWeight.bold),), 
                        SizedBox(height: 20,),

                        RemainingHyd(totalWater.toInt()),
                      ]
                    ),
                  ),
                ),          
                ],
              );
            },
          )
        ),
      ),
    );
  }
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
        new DropdownButton<String>(
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


