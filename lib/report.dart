import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';


class report_issue extends StatefulWidget {
  @override
  _report_issueState createState() => _report_issueState();
}

class _report_issueState extends State<report_issue> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //check for gps permission and get it, if permission false
    check_gps() async{
        LocationPermission permission = await Geolocator.checkPermission();
        if(permission == LocationPermission.denied){
          LocationPermission permission = await Geolocator.requestPermission();
        }
        else if(permission == LocationPermission.deniedForever){
          await Geolocator.openAppSettings();
        }
        //get current location
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    }
    //get last known location
    last_gps() async{
        Position position = await Geolocator.getLastKnownPosition();
        print(position);
    }
    check_gps();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Report Issue"),
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
                Form(
                  key: formKey,
                  child: Column(
                    children:
                    <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: null,
                        decoration: const InputDecoration(
                            labelText: "Ihre Nachricht *"
                        ),
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(20)
                        ],
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Dieses Feld ist ein Pflichtfeld";
                          }
                          else if (value.length > 200){
                            return "Ihre Nachricht darf maximal 200 Zeichen enthalten";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      RaisedButton(
                        child:
                          Text("Foto aufnehmen"),
                        onPressed: (){getImage();}
                      ),
                      Container(height: 30),
                      Align(alignment: Alignment.centerLeft,
                      child:
                        RaisedButton(
                          color: Colors.pink,
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            <Widget>[
                              Text(
                                "Send Report",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate()){
                              print("Moin");
                            }
                          }
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
