import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/widgets/workouts/show_exercises_box.dart';
import 'package:fitness_app/widgets/workouts/workouts.dart';
import 'package:flutter/material.dart';

class WorkoutList extends StatefulWidget {
  final String userId;
  WorkoutList(this.userId);

  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {

  //savedata
  addItem(String title, List exercises){
    DocumentReference ref = Firestore.instance.collection("workouts").document();
    ref.setData({
      "title": title,
      "exercises": exercises,
      "documentId": ref.documentID,
      "createdAt" :Timestamp.now(),
      "userId":widget.userId,
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
                stream: Firestore.instance.collection("workouts").orderBy("createdAt").snapshots(),
                builder: (ctx, snapShot){
                  if(!snapShot.hasData){
                    return Container();
                  }
                  return Workouts(snapShot.data.documents, widget.userId);
                }
              ),
            ),            
            Align(
              alignment: Alignment.center,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(18)
                ),
                onPressed: () async{                  
                  showExerciseBox(context,widget.userId, addItem);
                }, 
                icon: Icon(Icons.add,
                  color: kDarkBlueColor,
                ), 
                label: Text("Add Plan", style: TextStyle(color: kDarkBlueColor),),
                color: kWhiteColor,
              ),
            ),
            SizedBox(height: 25,),
          ]
        ),
    );
  }
}