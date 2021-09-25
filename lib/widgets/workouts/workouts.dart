import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/widgets/exercise_icon.dart';
import 'package:fitness_app/widgets/workouts/show_exercises.dart';
import 'package:flutter/material.dart';

class Workouts extends StatefulWidget {
  final doc;
  final userId;
  Workouts(this.doc,this.userId);
  @override
  _WorkoutsState createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.doc.length,
      itemBuilder: (ctx,index){     
        if(widget.userId == widget.doc[index]["userId"])      
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: kWhiteColor),
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: exeIcon("workout"),
                title: Text(widget.doc[index]["title"],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                onTap: (){
                  showExercises(context,widget.doc[index]["exercises"]);
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    IconButton(
                      icon: Icon(Icons.delete, color: kLightRedColor,),
                      onPressed: (){
                        DocumentReference ref = Firestore.instance.collection("workouts").document(widget.doc[index]["documentId"]);
                        ref.delete();
                      },
                    ),
                  ],
                ),
              )
            ),
            Divider(height:1),
          ],
        );
        return null;
      },
    );
  }
}