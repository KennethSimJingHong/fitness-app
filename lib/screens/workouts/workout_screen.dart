import 'package:fitness_app/constant.dart';
import 'package:fitness_app/providers/user.dart';
import 'package:fitness_app/widgets/app_drawer.dart';
import 'package:fitness_app/screens/workouts/exercise_list.dart';
import 'package:fitness_app/screens/workouts/workout_list.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  final User userinfo;
  WorkoutScreen(this.userinfo);

  static const routeName = "./Workout";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kLightBlueColor,
        drawer: AppDrawer(userinfo.username,userinfo.userImage),
        appBar: AppBar(
          title: Text("Workout"),
          backgroundColor: kLightBlueColor,
          elevation: 0,  
          bottom: new TabBar(
            tabs: [
              new Tab(text: "Workout List", key: ValueKey("workoutlist")),
              new Tab(text: "Exercise", key: ValueKey("exerciselsit")),
           ],
          ),
        ),
        body: TabBarView(
          children: [
            WorkoutList(userinfo.id),
            ExerciseList(userinfo.id),
          ],
        ),
      ),
    );
  }
}