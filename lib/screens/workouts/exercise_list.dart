

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/providers/exercise.dart';
import 'package:fitness_app/widgets/workouts/exercises.dart';
import 'package:fitness_app/widgets/workouts/show_input_box.dart';
import 'package:flutter/material.dart';


class ExerciseList extends StatefulWidget {
  final String userId;
  ExerciseList(this.userId);

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {


  
  //Radio Button Component
  List<String> list = ["Arm","Back","Shoulder","Leg","Chest","Abs"];
  int selectedIndex = 0;
  void chgIndex(int index){
    setState((){
      selectedIndex = index;
    });
  }
  //Counter - Addon
  int repCount = 1;
  int setCount = 1;
  void addOn(int setcnt, int repcnt, String val){
    setState(() {
      if(val == "set"){
        setCount = setcnt + 1;
      }else if(val == "rep"){
        repCount = repcnt + 1;
      }
    });
  }
  //Counter - Minus
  void minusOut(int setcnt, int repcnt, String val){
    setState(() {
      if(val == "set"){
        if(setCount > 0){
          setCount = setcnt - 1;
        }
      }else if (val == "rep"){
        if(repCount > 0){
          repCount = repcnt - 1;
        }
      }
    });
  }






  
  //save data
  addItem(title) {
    DocumentReference ref = Firestore.instance.collection("exercises").document();
    ref.setData({
      "user_id":widget.userId,
      "category": list[selectedIndex],
      "title": title,
      "set": setCount,
      "rep":repCount,
      "createdAt" :Timestamp.now(),
      "documentId":ref.documentID,
    });
  }

  //remove data
  removeExercise(String input){
    DocumentReference ref = Firestore.instance.collection("exercises").document(input);
    ref.delete();
  }

  //get selected exercise info
  getInfo(String input) async{
    final result =  await Firestore.instance.collection("exercises").document(input).get();
    Exercise exercise = new Exercise(
      userId: result.data["user_id"],
      category: result.data["category"],
      title: result.data["title"],
      setCount: result.data["set"],
      repCount: result.data["rep"],
    );
    return showInputBox(context, list,chgIndex, addOn, minusOut, addItem, getInfo,"update", toBeChange, input,exercise);
  }

  toBeChange(bool yesorno,String title,String input){
    if(yesorno){
      changeInfo(list[selectedIndex], setCount, repCount, title, input);
      yesorno = false;
    }
  }

  //update data
  changeInfo(String category, int setCount, int repCount, String title, String input)async{ 
   // final prevResult = await  Firestore.instance.collection("exercises").document(input).get();
    Firestore.instance.collection("exercises").document(input).updateData({
      "category":category,
      "rep":repCount,
      "set":setCount,
      "title":title,
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBlueColor,
      body: Column(
          children:[
            Expanded(
              
              child: StreamBuilder(
                stream: Firestore.instance.collection("exercises").orderBy("createdAt").snapshots(),
                builder: (ctx,snapShot){
                  if(!snapShot.hasData){
                    return Container();
                  }
                  return Exercises(snapShot.data.documents,widget.userId,removeExercise,getInfo);
                },
              ),
            ),                
            Align(
              alignment: Alignment.center,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(18)
                ),
                onPressed: (){
                  showInputBox(context, list,chgIndex, addOn, minusOut, addItem, getInfo,"add",toBeChange,"",Exercise());
                }, 
                icon: Icon(Icons.add,
                  color: kDarkBlueColor,
                ), 
                label: Text("Add Exercise", style: TextStyle(color: kDarkBlueColor),),
                color: kWhiteColor,
              ),
            ),
            SizedBox(height: 25,),
          ]
        ),
    );
  }
}