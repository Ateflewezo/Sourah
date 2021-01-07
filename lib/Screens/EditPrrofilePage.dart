import 'package:flutter/material.dart';
import 'package:hdwallpapers/Screens/PorfilePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _controller=TextEditingController();
  TextEditingController _namee ;
  TextEditingController _emaill ;
  TextEditingController _phonee;
  String _name;
  String _email;
  String _mobile;
  Future<String> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name");
    _email=prefs.getString("email");
    _mobile=prefs.getString("mobile");
    setState(() {
      _namee = new TextEditingController(text: _name);
      _emaill=new TextEditingController(text: _email);
      _phonee=new TextEditingController(text: _mobile);
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
          'تعديل صفحتك',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/profile");
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            Container(
              height: 500,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      name("الاسم", Colors.black),
                      SizedBox(
                        height: 15,
                      ),
                      Email("البريد الالكترونى", Colors.black),
                      _Password("الرقم السرى ", Colors.black),
                      SizedBox(
                        height: 15,
                      ),
                      _ConfirmPassword("تاكيد الرقم السرى", Colors.black),
                      SizedBox(
                        height: 15,
                      ),
                      phone("رقم التليفون", Colors.black),
                      SizedBox(
                        height: 15,
                      ),
                      _rigister()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-----------------name-------------------
  Widget name(String hinttext, Color fontcolor) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(

        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 40, left: 40),
          labelText: hinttext,
          labelStyle: TextStyle(
            color: fontcolor,
          ),
        ),
        onChanged: (String str) {
          setState(() {
            _name = str;
          });
        },

        controller: _namee,
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
          labelStyle: TextStyle(
            color: fontcolor,
          ),
        ),
        onChanged: (String str) {
          setState(() {
            _email = str;
          });
        },
        controller: _emaill,
      ),
    );
  }

  //-------------password-----------------
  Widget _Password(String hinttext, Color fontcolor) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller:_controller,
        //keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 40, left: 40),
          labelText: hinttext,
          labelStyle: TextStyle(
            color: fontcolor,
          ),
        ),
      ),
    );
  }

  //----------------confirmPassword-------------
  Widget _ConfirmPassword(String hinttext, Color fontcolor) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        obscureText: true,
        validator: (String value) {
          if (_controller.text != value) {
            return 'كلمتا المرور غير متطابقتين';
          }
        },
      //  keyboardType: TextInputType.,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 40, left: 40),
          labelText: hinttext,
          labelStyle: TextStyle(
            color: fontcolor,
          ),
        ),
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
          contentPadding: EdgeInsets.only(right: 40, left: 40),
          labelText: hinttext,
          labelStyle: TextStyle(
            color: fontcolor,
          ),
        ),
        onChanged: (String str) {
          setState(() {
            _mobile = str;
          });
        },
        controller: _phonee,
      ),
    );
  }

  //-----------update--------------------
  Widget _rigister() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: InkWell(
          onTap: () {
            // submitForm();
            Updateprofile().then((status) async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              if(status == "ok"){
               setState(() {
              prefs.setString('mobile', _phonee.value.text );
              prefs.setString('name',  _namee.value.text );
              prefs.setString('email',  _emaill.value.text );
              prefs.setString("password", _controller.value.text );  
               });
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            });
          },
          child: Container(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
            ),
            height: 50,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.indigo[700],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "تحديث",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*submitForm() {
    if (!formkey.currentState.validate()) {
      return;
    }
    formkey.currentState.save();
    formkey.currentState.reset();
    Navigator.of(context).pushNamed("/profile");
  }*/
  Future Updateprofile () async{
    var check;
    var user = await http.post("http://waitbuzz.net/wallpaper/api/user/update" , body: {
      "name" : _namee.value.text,
      "mobile" : _phonee.value.text,
      "email" : _emaill.value.text,
      "password" : _controller.value.text,
    } , headers: {
      'fcm_token': '894651558796453124mkjbvgchfxch',
      'os': 'android',
      'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0L3dhbGxwYXBlci9hcGkvc2lnbmluIiwiaWF0IjoxNTYxMjMzMTY2LCJleHAiOjEwODkyNDMzMTY2LCJuYmYiOjE1NjEyMzMxNjYsImp0aSI6IjZiY2RmYjgzMmJJQU14UWoifQ.pi_9WsK_WIR9krYkOyXQCzTVg_V0zIJCRY8F92Mg4Ik',
    }).then((data){
      var  res   = json.decode(data.body);
      var status  = res["status"];
      check = status;
    });

    return check;
  }

}
