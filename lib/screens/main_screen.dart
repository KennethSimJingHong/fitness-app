import 'package:fitness_app/constant.dart';
import 'package:fitness_app/providers/user.dart';
import 'package:fitness_app/screens/description_screen.dart';
import 'package:fitness_app/screens/exercise_screen.dart';
import 'package:fitness_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {

  final User userinfo;
  MainScreen(this.userinfo);
  static const routeName = "./Main";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List ingredient = ["200 grams lettuce", "50 grams marinated mango", "200 grams cabbage", "5 small tomatoes", "300 grams cucumber", "30 grams red onion", " 2 tablespoons olive oil"];

  String useridcheck = "";

  

  @override
  Widget build(BuildContext context){
    
    if(widget.userinfo.email == null)
    return Center(child: CircularProgressIndicator(),);

    return  Scaffold(
      backgroundColor: kLightBlueColor,
      drawer: AppDrawer(widget.userinfo.username,widget.userinfo.userImage),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: kLightBlueColor,
        elevation: 0,   
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: kWhiteColor,
                height:150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.userinfo.username == null ? "Pending" : "Hello, ${widget.userinfo.username}!",
                        style: TextStyle(
                          color: kDarkBlueColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        SizedBox(height:10),
                        Text(widget.userinfo.email == null ? "Email" : "${widget.userinfo.email}",
                        style: TextStyle(
                          color: kDarkBlueColor,
                          fontSize: 20,
                        ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: widget.userinfo.userImage == null ? null : NetworkImage(widget.userinfo.userImage),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 50,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Exercise Suggestion", style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
            SizedBox(height: 20,),    
            Container(
            height: 120.0,
            color: kWhiteColor,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width:10),
                  getExerciseSuggestion("assets/images/Abs.png",context,"Abs"),
                  getExerciseSuggestion("assets/images/Arm.png",context,"Arm"),
                  getExerciseSuggestion("assets/images/Back.png",context,"Back"),
                  getExerciseSuggestion("assets/images/Chest.png",context,"Chest"),
                  getExerciseSuggestion("assets/images/Leg.png",context,"Leg"),
                  getExerciseSuggestion("assets/images/Shoulder.png",context,"Shoulder"),
                  
                ],
              ),
            ),
              
        
          


            SizedBox(height: 50,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Meal Suggestion", style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
            Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 310.0,
            child: new ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[

              getMealSuggestion(context, "assets/images/plate1.png", ingredient, "first", "Mango Salad", "256 Calories", 200,-5,20),
              getMealSuggestion(context, "assets/images/plate2.png", ingredient, "second", "Roast Chicken Salad", "580 Calories",300,-55,-25),
              getMealSuggestion(context, "assets/images/plate3.png", ingredient, "third", "Grilled Salmon", "408 Calories",250,-35,0),
              getMealSuggestion(context, "assets/images/plate4.png", ingredient, "fourth", "Sour Chicken Vege", "387 Calories",250,-35,0),
              
            ],
          )
          ),

          
          ],
        ),
      ),
    );
  }
}


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      // TODO: implement getClip
      var path = new Path();
      path.lineTo(0, size.height-50);
      var controlPoint = Offset(50, size.height);
      var endPoint = Offset(size.width/2,size.height);
      path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      return path;
    }
  
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}


getExerciseSuggestion(String img, BuildContext ctx, String exercisePart){
  return Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: kDarkBlueColor,
          width:100,
          child: FlatButton(
          child: Image.asset(img, color: kWhiteColor, width:60, height: 60,),
          onPressed: (){
            Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => ExerciseScreen(exercisePart)));
          },
        ),
        ),
      ),
      SizedBox(width:10),
    ],
  );
}

getMealSuggestion(BuildContext ctx, String img, List ingredient, String tag, String name, String cal, int size, double top, double left){
  return Stack(
    children:[
      Container(
        margin: EdgeInsets.only(top:50),
        width:250,
        height:250,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 10.0),  
          color: kWhiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Text(name, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kDarkBlueColor,
              ),), 
              Text(cal, style: TextStyle(
                fontSize: 20,
                color: kDarkBlueColor,
              ),),  
              SizedBox(height:50),
            ]
          ),
        ),
      ),
      Positioned(child: Hero(tag:tag,child: Image(image: AssetImage(img), width: size.toDouble(), height:size.toDouble())), top:top, left:left,),            
      Positioned(child: IconButton(icon: Icon(Icons.navigate_next, color: kDarkBlueColor,), onPressed: (){
        Navigator.push(
          ctx,
            MaterialPageRoute(builder: (ctx) => DescriptionScreen(img, ingredient,tag,name)
          ),
        );
      },), bottom:10, right: 10,) 
    ]
  );
}