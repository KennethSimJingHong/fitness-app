import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/providers/user.dart';
import 'package:fitness_app/screens/diets/diet_screen.dart';
import 'package:fitness_app/screens/home_screen.dart';
import 'package:fitness_app/screens/main_screen.dart';
import 'package:fitness_app/screens/workouts/workout_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

//ignore: must_be_immutable
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 User userinfo = new User();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx,userSnapshot){  


          if(userSnapshot.hasData){
            Firestore.instance.collection("users").snapshots().listen((data) {
              data.documents.forEach(
                (document) {
                  if(document.documentID == userSnapshot.data.uid){
                    setState(() {
                      userinfo.id = userSnapshot.data.uid;
                      userinfo.email = document["email"];
                      userinfo.username = document["username"];
                      userinfo.userImage = document["image_url"];  
                    });
                  }
                });    
            }); 
              return MainScreen(userinfo);
            
          }
          userinfo = User();
          return HomeScreen();   
        }
      ),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(userinfo),
        WorkoutScreen.routeName: (ctx) => WorkoutScreen(userinfo),
        DietScreen.routeName: (ctx) => DietScreen(userinfo),
      },
    );
  }
}
