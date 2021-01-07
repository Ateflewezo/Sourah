import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _controller;
  TextEditingController _emill;
  TextEditingController _controller3;

  String _name;
  String _email;
  String _mobile;


  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name");
    _email=prefs.getString("email");
    _mobile=prefs.getString("mobile");
    setState(() {
      _controller = new TextEditingController(text: _name);
      _emill=new TextEditingController(text: _email);
      _controller3=new TextEditingController(text: _mobile);
    });
  }

  @override
  void initState() {
    super.initState();
    _name = "";
    _email="";
    _mobile="";
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'الصفحة الشخصية ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/homepage");
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              iconSize: 40,
              onPressed: () {
                Navigator.of(context).pushNamed("/editprofile");
              },
            )
          ],
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              elevation: 5.0,
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    name("الاسم", Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Email("البريد الالكترونى", Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    phone("التليفون", Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  //---------------------name-----------
  Widget name(String hinttext, Color fontcolor) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(


        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 40, left: 40),
            labelText: hinttext,
            fillColor: Colors.white,

            labelStyle: TextStyle(
              color: fontcolor,
            ),
            suffixIcon: Icon(
              Icons.person_pin,
              color: Colors.red,
              size: 18,
            )),
        onChanged: (String str) {
          setState(() {
            _name = str;
          });
        },
        controller: _controller,
      ),
    );
  }

  //------------------- Email----------------------
  Widget Email(String hinttext, Color fontcolor) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 40, left: 40),
            labelText: hinttext,
            labelStyle: TextStyle(color: fontcolor),
            suffixIcon: Icon(
              Icons.mail_outline,
              color: Colors.red,
              size: 18,
            )),
        onChanged: (String str) {
          setState(() {
            _email = str;
          });
        },
        controller: _emill,

      ),
    );
  }

  //-----------------------------phone----------------
  Widget phone(String hinttext, Color fontcolor) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(

        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.red,
            contentPadding: EdgeInsets.only(right: 40, left: 40),
            labelText: hinttext,
            labelStyle: TextStyle(
              color: fontcolor,
            ),
            suffixIcon: Icon(
              Icons.phone_iphone,
              color: Colors.red,
              size: 18,
            )),
        onChanged: (String str) {
          setState(() {
            _mobile = str;
          });
        },
        controller: _controller3,
      ),
    );
  }
}
