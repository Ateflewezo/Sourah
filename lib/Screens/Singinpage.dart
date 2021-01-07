import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hdwallpapers/Screens/Homepage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class SinginPage extends StatefulWidget {
  @override
  _SinginPageState createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
  bool valuecheck = true;
  bool value = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();


  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.only(top: 100),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "مرحبا بك",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "سجل دخول ",
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                ],
              ),
            ),
            Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  textfiledEmail(),
                  SizedBox(
                    height: 40,
                  ),
                  textfiledPassword()
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _remember(),
            SizedBox(
              height: 20,
            ),
            loginButton(),
            SizedBox(
              height: 20,
            ),
            forgatpassword(),
            SizedBox(height: 50),
            sinup()
          ],
        ),
      ),
    );
  }

  //---------Email-----------------------
  Widget textfiledEmail() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color:Theme.of(context).accentColor)),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 60.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        enabled: true,
        style: TextStyle(color: Colors.white),
        controller: _email,
        cursorColor: Colors.red,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 25, top: 10,left: 25),
          border:InputBorder.none,
            labelText: "البريد الالكترونى ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            suffixIcon: Icon(
              Icons.message,
              color: Colors.white,
              size: 18,
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك ادخل اسم صحيح";
          }
        },

      ),
    );
  }

  //--------password-----------------
  Widget textfiledPassword() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color:Theme.of(context).accentColor)),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 60.0,
      child: TextFormField(
        controller: _password,
        cursorColor: Colors.red,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Color(getColorHexFromStr("#5225A9")).withOpacity(0.5),
          contentPadding: EdgeInsets.only(right: 25, top: 10,bottom: 10,left: 25),
          border: InputBorder.none,
          hintText: " الرقم السرى",
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14),
            suffixIcon: Icon(
              Icons.lock,
              color: Colors.white,
              size: 18,
            )
        ),
        validator: (String value){
          if(value.isEmpty){
            return "ادخل رقم صحيح";
          }
        },
      ),);
  }

  //----------------rememberMe--------------
  Widget _remember() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: valuecheck,
          onChanged: (bool val) {
            setState(() {
              valuecheck = val;
            });
          },
          // activeColor: Colors.white,
          checkColor: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "تذكرنى",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  //-------Buttons login and skip-------
  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/homepage');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "تخطى",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: InkWell(
              onTap: () {
//                submitForm(model.loadSigninResponse);
                if (!formkey.currentState.validate()) {
                  return;
                }
                formkey.currentState.save();
                formkey.currentState.reset();
                signupuser().then((data) async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('jwt', data["jwt"]);
                  prefs.setString('mobile', data["mobile"]);
                  prefs.setString('name', data["name"]);
                  prefs.setString('email', data["email"]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                });
              },
              child: Container(
                padding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "دخول",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //----------Forgat password------------
  Widget forgatpassword() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/forgetpassword");
          },
          child: Text(
            "هل نسيت كلمة السر ؟",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  //-------------------SingUP------------
  Widget sinup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Text(
          "ليس لديك حساب ؟",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/singup");
          },
          child: Text(
            "تسجيل حساب جديد",
            style: TextStyle(
                color: Theme.of(context).accentColor, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

 /* submitForm(Function postSingin) async {
    if (!formkey.currentState.validate()) {
      return;
    }
    formkey.currentState.save();
    formkey.currentState.reset();
    String _signin =
        await postSingin(_formdata['email'], _formdata['password']);
    if (_signin == 's') {
      Navigator.of(context).pushNamed("/homepage");
    }
  }*/

  Future signupuser() async {
    var atef;
    var user =
        await http.post("http://waitbuzz.net/wallpaper/api/signin", body: {
      "email": _email.value.text,
      "password": _password.value.text,
    }, headers: {
      'fcm_token': '894651558796453124mkjbvgchfxch',
      'os': 'android'
    }).then((data) {
      var res = json.decode(data.body);
      var body = res;
      atef = body;
    });

    return atef;
  }
}
