import 'package:fitness_app/constant.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  final String image;
  final List ingredient;
  final String tagging;
  final String name;
  DescriptionScreen(this.image, this.ingredient,this.tagging, this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: kLightBlueColor,
                height:300,
              ),
            ),
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: kDarkBlueColor,
                height:250,
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: ClipPath(
                clipper: BottomClipper(),
                child: Container(
                  color: Colors.red[100],
                  height:MediaQuery.of(context).size.height - 200,
                ),
              ),
            ),

            Align(
            alignment: Alignment.bottomRight,
            child: ClipPath(
              clipper: BottomClipper(),
              child: Container(
                color: kLightRedColor,
                height:MediaQuery.of(context).size.height - 220,
              ),
            ),
          ),
            





            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              FlatButton.icon(
                icon:Icon(Icons.navigate_before,color: kWhiteColor,), 
                label:Text("Back", style: TextStyle(color: kWhiteColor)), 
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              Hero(
                tag: tagging,
                child: Center(
                  child: Image.asset(
                    image,
                    width: 300,
                    height:300,
                  ),
                ),
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( child: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  SizedBox(height:55),
                  Container(
                    margin: EdgeInsets.only(left:10),
                    child: Text("Ingredients", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kWhiteColor),)),
                  Container(
                    margin: EdgeInsets.only(left:(MediaQuery.of(context).size.width/2)/2,top:10),
                    height:160,
                    child: ListView.builder(
                      itemCount: ingredient.length,
                      itemBuilder: (context,index){
                        return Text("${index + 1}. ${ingredient[index]}", style: TextStyle(color: kWhiteColor, fontSize: 15),);
                      }
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],  
      )
    );
  }
}


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      Path path = Path();
      path.lineTo(0, size.height);
      path.quadraticBezierTo(size.width-50, size.height-50, size.width, 0);
      path.lineTo(size.width, 0);
      return path;
    }
  
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}

class BottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      Path path = Path();
      path.moveTo(0, size.height * 0.45);
      path.cubicTo(size.width * 0.5, size.height * 0.35, size.width * 0.5, size.height * 0.85, size.width, size.height * 0.35);
      //path.quadraticBezierTo(size.width - (size.width-50), size.height - (size.height-50), size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      return path;
    }
  
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}