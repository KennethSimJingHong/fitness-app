import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/constant.dart';
import 'package:fitness_app/screens/diets/diet_screen.dart';
import 'package:fitness_app/screens/main_screen.dart';
import 'package:fitness_app/screens/workouts/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';


class AppDrawer extends StatelessWidget {
  final String email;
  final String userImage;
  AppDrawer(this.email,this.userImage);
  

  @override
  Widget build(BuildContext context) {
    return Drawer( 
      child: Container(
        padding: EdgeInsets.only(top:80),
        color:kDarkBlueColor,
        child: Column(
          children: [
            
            
            if(userImage == null)
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),

            if(userImage != null)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userImage),
            ),

         


            SizedBox(height:10),
            Text(email != null ? email : null, style: TextStyle(color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.w400),),
            SizedBox(height:30),
      
            ListTile(
              leading: Icon(Icons.home, color: kWhiteColor,),
              title: Text("Home", style: TextStyle(color: kWhiteColor),),
              onTap: (){Navigator.of(context).pushReplacementNamed( MainScreen.routeName);},
            ),
            Divider(),
            ListTile(
              leading: Icon(FontAwesomeIcons.dumbbell ,color: kWhiteColor,),
              title: Text("Workout", style: TextStyle(color: kWhiteColor),),
              onTap: (){Navigator.of(context).pushReplacementNamed(WorkoutScreen.routeName);},
            ),
            Divider(),
            ListTile(
              leading: Icon(FontAwesomeIcons.utensils, color: kWhiteColor,),
              title: Text("Diet", style: TextStyle(color: kWhiteColor),),
              
              onTap: (){Navigator.of(context).pushReplacementNamed(DietScreen.routeName);},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: kWhiteColor),
              title: Text("Logout", style: TextStyle(color: kWhiteColor),),
              onTap: (){
                try {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  FirebaseAuth.instance.signOut();

                  print("Successfully");
                  // signed out
                } catch (e){
                  print(e);
                } 
              },
            )
          ],
        ),
      )
    );
  }
}