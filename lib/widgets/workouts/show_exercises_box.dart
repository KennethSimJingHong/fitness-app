

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/widgets/exercise_icon.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ShowExerciseList extends StatefulWidget {
  final doc;
  final userId;
  List checkBox;
  ShowExerciseList(this.doc,this.checkBox,this.userId);

  @override
  _ShowExerciseListState createState() => _ShowExerciseListState();
}

class _ShowExerciseListState extends State<ShowExerciseList> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:200,
      child: ListView.builder(
        itemCount: widget.doc.length,
        itemBuilder: (ctx,index){
          if(widget.doc.length > widget.checkBox.length){
            widget.checkBox.add('false');
          }
          if(widget.userId == widget.doc[index]["user_id"])
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: CheckboxListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(widget.doc[index]["title"].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              subtitle: Text("${widget.doc[index]["set"]} SET - ${widget.doc[index]["rep"]} REP ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
              secondary: exeIcon(widget.doc[index]["category"]), 
              dense: true,
              
              value: widget.checkBox[index] == "true" ? true : false,
              onChanged: (value){
                setState(() {
                  widget.checkBox[index] == "true" ? widget.checkBox[index] = "false" : widget.checkBox[index] = "true";
                });
              },
            ),
          );
          return Container();
      }),
    );
  }
}

class StreamingData extends StatefulWidget {
  final String userId;
  final Function addItem;
  const StreamingData(this.userId,this.addItem);
  @override
  _StreamingDataState createState() => _StreamingDataState();
}

class _StreamingDataState extends State<StreamingData> {
  String titleVal = "";
  List checkBox = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("exercises").snapshots(),
      builder: (context, snapShot){
        if(!snapShot.hasData){
            return Container();
        }
        return Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Workout List Name"),
                onSaved: (val){
                  titleVal = val;
                },
              ),
            ),
            SizedBox(height:20),
            ShowExerciseList(snapShot.data.documents,checkBox,widget.userId),
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
                    child: Text("Confirm"),
                    onPressed: (){
                      _formKey.currentState.save();
                      for (int i = 0; i < checkBox.length; i++){
                        if(checkBox[i] == "true"){
                          checkedDocId.add(snapShot.data.documents[i]["documentId"]);
                        }
                      }
                      widget.addItem(titleVal,checkedDocId == null ? [] : checkedDocId);
                      Navigator.of(context).pop();
                      checkedDocId = [];
                    },
                    color: kWhiteColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

final _formKey = GlobalKey<FormState>();
List checkedDocId = [];

showExerciseBox(BuildContext context, String userId, Function addItem){
  
  return showDialog(context:context, builder:(context){
    return AlertDialog(
      title: Text("Create Workout List"),
      backgroundColor: kWhiteColor,
      content: Container(
         width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              StreamingData(userId, addItem),
          ],
        ),
      ),
    );
  });
}