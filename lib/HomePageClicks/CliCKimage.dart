import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/HomePageClicks/Cropimage.dart';
import 'package:hdwallpapers/HomePageClicks/FirstItemClick.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';

import 'package:image_picker_saver/image_picker_saver.dart';
class ClickImage extends StatefulWidget {
  final String image;

  const ClickImage( this.image);

  @override
  _ClickImageState createState() => _ClickImageState();
}

class _ClickImageState extends State<ClickImage> {


  Future _cropImage() async {
    var response = await http.get(widget.image);
    var _filepath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _filepath,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
     if (croppedFile != null) {
    var ourpath = await ImagePickerSaver.saveFile(fileData: croppedFile.readAsBytesSync());
     }
      
    
}

  @override
  void initState() {
    widget.image;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
           Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back, color: Colors.white,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: (){
            },
            child: IconButton(
              icon: Icon(Icons.image, color: Colors.red,),
              onPressed: () {
                     _cropImage().then((data){
                return showDialog(
                  context:context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      content : Text("تم حفظ الجزء المختار من الصورة بنجاح")
                    );
                  }
                ) ;
              });
              },
            ),
          )
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 60),
          children: <Widget>[
            Image(),

          ],
        ),
      ),

    );
  }

  //-----------------ContainerImage-------------
  Widget Image() {
    return Center(
      child:
           Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.cover)),
      ),
    );
  }


}

