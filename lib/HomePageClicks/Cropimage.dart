import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Cropimage extends StatefulWidget {
  final String image;

  const Cropimage( this.image);
  @override
  _CropimageState createState() => _CropimageState();
}

class _CropimageState extends State<Cropimage> {

  @override
  void setState(fn) {
    // TODO: implement setState
    widget.image;
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          _image(),
        ],
      ),
    );
  }
  Widget _image(){
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(widget.image),fit: BoxFit.cover,
          )
      ),
    );
  }
  
}
