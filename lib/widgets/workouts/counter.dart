import 'package:flutter/material.dart';

//ignore: must_be_immutable
class Counter extends StatefulWidget {
  void Function (int setCount, int repCount, String val) addOn;
  void Function (int setCount, int repCount, String val) minusOut;
  int setCount;
  int repCount;
  Counter(this.addOn,this.minusOut,this.setCount, this.repCount);
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        Column(
          children: [
            Text("Set", style: TextStyle(fontWeight: FontWeight.bold),),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: (){
                    widget.minusOut(widget.setCount,widget.repCount,"set");
                    setState(() {
                      if(widget.setCount > 0){
                        widget.setCount -= 1;
                      }
                    });
                  },
                ),
                Text("${widget.setCount}"),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: (){
                    widget.addOn(widget.setCount,widget.repCount,"set");
                    setState(() {
                      widget.setCount += 1;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      
        Column(
          children: [
          Text("Rep",  style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children:[
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: (){
                    setState(() {
                      widget.minusOut(widget.setCount,widget.repCount,"rep");
                      if(widget.repCount > 0){
                        widget.repCount -= 1;
                      }
                    });
                  },
                ),
                Text("${widget.repCount}"),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: (){
                    widget.addOn(widget.setCount,widget.repCount,"rep");
                    setState(() {
                      widget.repCount += 1;
                    });
                  },
                ),
              ],
            ),
          ],
        ),

        
      ],
    );
  }
}