import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/widgets/exercise_icon.dart';
import 'package:flutter/material.dart';

class Exercises extends StatefulWidget {
  final doc;
  final userId;
  final Function(String input) removeExercise;
  final Function(String input) getInfo;
  Exercises(this.doc, this.userId,this.removeExercise,this.getInfo);
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.doc.length,
        itemBuilder: (ctx,index){
          DocumentSnapshot documentSnapshot = widget.doc[index];
          if(widget.userId == widget.doc[index]["user_id"])
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(color: kWhiteColor),
                child: ListTile(
                  leading: exeIcon(widget.doc[index]["category"]), 
                  title: Text(widget.doc[index]["title"].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  subtitle: Text("${widget.doc[index]["set"]} SET - ${widget.doc[index]["rep"]} REP ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: kDarkBlueColor,),
                        onPressed: (){
                          
                            widget.getInfo(documentSnapshot["documentId"].toString());                     
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: kLightRedColor,),
                        onPressed: (){
                          widget.removeExercise(documentSnapshot["documentId"].toString());
                        },
                      ),
                    ],  
                  ),
                ),
              ),
              Divider(height:1),
            ],
          ); 
          return Container(); 
           
        }
    );
  }
}