import 'package:fitness_app/constant.dart';
import 'package:fitness_app/screens/description_screen.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  final String name;
  ExerciseScreen(this.name);

  final data = [
    {
      "title":"Barbell Bench Press",
      "imageURL":"https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-1-700xh.jpg",
      "description": "Do it toward the start of your chest workout for heavy sets in lower rep ranges. Consider varying your grip width for more complete chest development.",
    },
    {
      "title": "Incline Barbell Bench Press",
      "imageURL":"https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-3-700xh.jpg",
      "description":"Many chest workouts start with flat-bench movements first, then progress to inclines, but it's time to get out of that bad habit. Every so often, start with inclines. The benefit is that you'll be fresher and can lift more weight, which puts a greater amount of stress on the upper pec fibers and could lead to more growth.",
    },
    {
      "title":"Seated Machine Chest Press",
      "imageURL":"https://www.bodybuilding.com/images/2016/july/10-best-chest-exercises-for-building-muscle-v2-4-700xh.jpg",
      "description":"Again, do machine exercises at the end of your workout. For anyone looking to build mass, machines give you a greater chance to pump your pecs with minimal shoulder assistance.",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          SizedBox(height: 20,),

          ClipPath(
            clipper: Clipper(),
            child: Container(
              height:140,
              color: kLightBlueColor,
            ),
          ),

          ClipPath(
            clipper: Clipper(),
            child: Container(
              height:110,
              color: kDarkBlueColor,
            ),
          ),

          Positioned(
            top:20,
            child: FlatButton.icon(
              icon:Icon(Icons.navigate_before,color: kWhiteColor,), 
              label:Text("Back", style: TextStyle(color: kWhiteColor)), 
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),


          Column(
            children:[
              Container(margin: EdgeInsets.only(top:40),child: Align(alignment: Alignment.topCenter, child: Text(name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: kWhiteColor),))),
              SizedBox(height: 30,),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight:Radius.circular(20)), 
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            color: kLightBlueColor,
                            width: MediaQuery.of(context).size.width-20, 
                            child: Text(data[index]["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kWhiteColor),)
                          ),
                        ),
                        
                        Image.network(data[index]["imageURL"], width:MediaQuery.of(context).size.width-20),
              
                        ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20), bottomRight:Radius.circular(20)),
                          child: Container(
                            color: kLightBlueColor,
                            width: MediaQuery.of(context).size.width-20,
                            padding:EdgeInsets.all(20),
                            child: Text(data[index]["description"], textAlign: TextAlign.justify, style: TextStyle(fontSize: 14, color: kWhiteColor)),
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    );
                  }
                ),
              ),
            ]
          ),
          

          
        ]
      ),
    );
  }
}

class Clipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      // TODO: implement getClip
      Path path = Path();
      path.lineTo(0, size.height/2);
      path.quadraticBezierTo(size.width/2, size.height, size.width, size.height/2);
      path.lineTo(size.width, 0);
      return path;
    }
  
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
   return true;
  }

}