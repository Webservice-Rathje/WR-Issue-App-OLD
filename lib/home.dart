import 'package:flutter/material.dart';
import 'report.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.pinkAccent,
        title: Text("WR Issue"),
      ),
      body:
      Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children:
          <Widget>[
            Column(
              children:
              <Widget>[
                Container(height: 50,),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Report Issue", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => report_issue())
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
