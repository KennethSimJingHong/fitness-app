import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/providers/user.dart';
import 'package:fitness_app/screens/diets/diet_screen.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant.dart';


class DietCalList extends StatefulWidget {
  final doc;
  final User userinfo;
  Function(String i) deleteMeal;
  DietCalList(this.doc,this.userinfo,this.deleteMeal);
  @override
  _DietCalListState createState() => _DietCalListState();
}

class _DietCalListState extends State<DietCalList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.doc.length == null ? 0 : widget.doc.length,
      itemBuilder: (ctx,index){
        if(widget.userinfo.id == widget.doc[index]["user_id"]) {
          return ClipRRect(
          borderRadius: BorderRadius.circular(20),
           child: Container(
          
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.fireAlt, color: Colors.teal,),
                  SizedBox(width: 10,),
                  Text("${widget.doc[index]["title"]}", style: TextStyle(color: kLightBlueColor, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              title:Text("(${widget.doc[index]["calories"]} CAL)", style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold)),
              trailing: IconButton(
                icon: Icon(Icons.delete), 
                color: kLightRedColor,
                onPressed: (){
                  
                  widget.deleteMeal(widget.doc[index]["documentId"]);        
                },
                ),
                 
            ), 
          ),
        );
        }
        return null;
      },
    );
  }
}



class StoreCal extends StatefulWidget {
  Function (String title, String subtitle) addMeal;
  StoreCal(this.addMeal);
  @override
   StoreCalState createState() =>  StoreCalState();
}

class  StoreCalState extends State <StoreCal> {
  String title;
  String subtitle;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            TextFormField(
              decoration: InputDecoration(hintText: "Meal Item"),
              onSaved: (val){
                setState(() {
                  title = val;
                }); 
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Calories Amount"),
              keyboardType: TextInputType.number,
              onSaved: (val){
                setState(() {
                  subtitle = val;
                });
              },
            ),
            SizedBox(height: 20,),
            RaisedButton(
              child: Text("Confirm", style: TextStyle(color: kWhiteColor),),
              onPressed: (){
                _formKey.currentState.save();
                widget.addMeal(title,subtitle);
                Navigator.of(context).pop();
              },
              color: kLightBlueColor,
            ),
                
          ],
        ),
      );
  }
}


showCalBox(BuildContext context, Function addMeal){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Meal Record"),
      content: StoreCal(addMeal),
    );
  });
}