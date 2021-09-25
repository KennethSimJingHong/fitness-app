import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/widgets/exercise_icon.dart';
import 'package:flutter/material.dart';

showExercises(BuildContext context, List exercises){
  return showDialog(context:context, builder:(context){
    return AlertDialog(
      backgroundColor: kWhiteColor,
      title: Text("Exercise"),
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
               stream: Firestore.instance.collection("exercises").snapshots(),
               builder: (context,snapShot){
                 if(!snapShot.hasData){
                      return Container();
                  }
                 return SizedBox(
                   height:200,
                      child: ListView.builder(
                      itemCount: snapShot.data.documents.length,
                      itemBuilder: (ctx,index){                     
                        if(exercises.contains(snapShot.data.documents[index]["documentId"]))
                        return Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                              leading: exeIcon(snapShot.data.documents[index]["category"]),
                              title:Text(snapShot.data.documents[index]["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              subtitle: Text("${snapShot.data.documents[index]["set"]} SET - ${snapShot.data.documents[index]["rep"]} REP ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        );
                        return Container();              
                     }
                    ),
                 );
               },
            ),
          ],
        ),
      ),
    );
  });
}