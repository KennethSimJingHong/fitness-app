import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constant.dart';

class RemainingStat extends StatefulWidget {
  int gainWeight;
  int loseWeight;
  int total;
  RemainingStat(this.gainWeight,this.loseWeight,this.total);
  @override
  _RemainingStatState createState() => _RemainingStatState();
}

class _RemainingStatState extends State<RemainingStat> {
  
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      Column(
        children: [
          Text("Gain Weight",style: TextStyle(color: kLightBlueColor, fontSize: 16, fontWeight: FontWeight.bold),),
          SizedBox(height:5),
          Text("${widget.gainWeight - widget.total} cal",style: TextStyle(color: kLightBlueColor, fontSize: 20, fontWeight: FontWeight.bold),),
        ],
      ), 
      Column(
        children: [
          Text("Lose Weight",style: TextStyle(color: kLightBlueColor, fontSize: 16, fontWeight: FontWeight.bold),),
          SizedBox(height:5),
          Text("${widget.loseWeight - widget.total} cal",style: TextStyle(color: kLightBlueColor, fontSize: 20, fontWeight: FontWeight.bold),),
        ],
      ), 
      ],
    );
  }
}

class RemainingHyd extends StatefulWidget {
  int waterIntake;
  RemainingHyd(this.waterIntake);
  @override
  _RemainingHydState createState() => _RemainingHydState();
}

class _RemainingHydState extends State<RemainingHyd> {
  @override
  int total = 0;
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Water Intake",style: TextStyle(color: kLightBlueColor, fontSize: 16, fontWeight: FontWeight.bold),),
        SizedBox(height:5),
        Text("${total} ml",style: TextStyle(color: kLightBlueColor, fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(height:20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(FontAwesomeIcons.minusCircle, color: kDarkBlueColor,), onPressed: (){
              setState(() {
                if(total > 0){
                  total -= 240;
                }
              });
            },),
            Stack(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height:100,
                    width:80,
                    color: kDarkBlueColor,
                  ),
                ),
                Positioned(
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height:95,
                      width:75,
                      color: kWhiteColor,
                    ),
                  ),
                  left:2.5,
                  bottom:2.5,
                ),
                
                Positioned(
                  child: ClipPath(
                    clipper: MyWaterClipper(),
                    child: Container(

                      height: total == 0 ? 0 : (total > widget.waterIntake ? 90 : (90 * total/widget.waterIntake)),
                      width:70,
                      color: total > widget.waterIntake ? Colors.green[200] : Colors.blue[100],
                    ),
                  ),
                  left:5,
                  bottom:5,
                ),
              ],
            ),
            IconButton(icon: Icon(FontAwesomeIcons.plusCircle, color: kDarkBlueColor,), onPressed: (){
              setState(() {
                total += 240;

              });
            },),
          ],
        ),
        SizedBox(height: 20,),
        Text("240ml per click"),
      ],
    );
  }
}


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      // TODO: implement getClip
      var path = new Path();
      path.lineTo(0, size.height);
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


class MyWaterClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      // TODO: implement getClip
      var path = new Path();
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.quadraticBezierTo(size.width/2, size.height-80, 0, 0);

      return path;
    }
  
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}