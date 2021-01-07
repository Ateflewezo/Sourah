import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/Screens/Homepage.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:hdwallpapers/Models/Sinup_model.dart';
//import '../Scoped_model/main_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SingUPScreen extends StatefulWidget {
  @override
  _SingUPScreenState createState() => _SingUPScreenState();
}

class _SingUPScreenState extends State<SingUPScreen> {
  // MainModel model = MainModel();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  /* final Map<String, dynamic> _formdata = {
    "name": null,
    "mobile": null,
    "email": null,
    "password": null,
  };*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 40, top: 20),
              child: Text(
                "تسجيل حساب جديد",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  _name("الاسم", Colors.white),
                  SizedBox(
                    height: 15,
                  ),
                  _Email("البريد الالكترونى", Colors.white),
                  SizedBox(
                    height: 15,
                  ),
                  _Password("كلمة المرور", Colors.white),
                  SizedBox(
                    height: 15,
                  ),
                  _ConfirmPassword("تاكيد كلمة المرور", Colors.white),
                  SizedBox(
                    height: 15,
                  ),
                  _phone("رقم التليفون", Colors.white)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _rigister(),
            SizedBox(
              height: 60,
            ),
            login()
          ],
        ),
      ),
    );
  }

  //-----------------Name----------
  Widget _name(String hinttext, Color fontcolor) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Theme.of(context).accentColor)),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 60.0,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controller1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 25, top: 10,left: 25),
            border: InputBorder.none,
            labelText: hinttext,
            labelStyle: TextStyle(
              color: fontcolor,
            ),
            suffixIcon: Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 18,
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك ادخل اسم صحيح";
          }
        },
        /*  onSaved: (value) {
          _formdata['name'] = value;
        },*/
      ),
    );
  }

//--------------Email-------------------
  Widget _Email(String hinttext, Color fontcolor) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color:Theme.of(context).accentColor)),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 60.0,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controller2,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 25, top: 10,left: 25),
            border: InputBorder.none,
            labelText: hinttext,
            labelStyle: TextStyle(
              color: fontcolor,
            ),
            suffixIcon: Icon(
              Icons.mail_outline,
              color: Colors.white,
              size: 18,
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك ادخل بريد صحيح";
          }
        },
        /* onSaved: (value) {
          _formdata['email'] = value;
        },*/
      ),
    );
  }

  //-------------password-----------------
  Widget _Password(String hinttext, Color fontcolor) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color:Theme.of(context).accentColor)),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 60.0,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 25, top: 10,left: 25),
            border: InputBorder.none,
            labelText: hinttext,
            labelStyle: TextStyle(color: fontcolor),
            suffixIcon: Icon(
              Icons.lock_open,
              color: Colors.white,
              size: 18,
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك ادخل رقم صحيح";
          }
        },
        /*  onSaved: (value) {
          _formdata["password"] = value;
        },*/
      ),
    );
  }

  //----------------confirmPassword-------------
  Widget _ConfirmPassword(String hinttext, Color fontcolor) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color:Theme.of(context).accentColor)),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 60.0,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        obscureText: true,
        validator: (String value) {
          if (_controller.text != value) {
            return 'كلمتا المرور غير متطابقتين';
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 25, top: 10,left: 25),
            border: InputBorder.none,
            labelText: hinttext,
            labelStyle: TextStyle(color: fontcolor),
            suffixIcon: Icon(
              Icons.lock,
              color: Colors.white,
              size: 18,
            )),
      ),
    );
  }

  //--------------phone-----------------
  Widget _phone(String hinttext, Color fontcolor) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color:Theme.of(context).accentColor)),
      margin: EdgeInsets.only(right: 10, left: 10),
      height: 60.0,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _controller3,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 25, top: 10,left: 25),
            border: InputBorder.none,
            labelText: hinttext,
            labelStyle: TextStyle(color: fontcolor),
            suffixIcon: Icon(
              Icons.phone_iphone,
              color: Colors.white,
              size: 18,
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك ادخل رقم صحيح";
          }
        },
        /* onSaved: (value) {
          _formdata["mobile"] = value;
        },*/
      ),
    );
  }

//--------------------registerButton-----------------
  Widget _rigister() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: InkWell(
          onTap: () {
//            submitForm(model.loadSignUpResponse);
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
              prefs.setString("password", data['password']);
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
            width: 130,
            decoration: BoxDecoration(
              color:Theme.of(context).accentColor,
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
    );
  }

//-------------------------login---------
  Widget login() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/singin");
          },
          child: Text(
            "تسجيل دخول",
            style: TextStyle(
                color: Theme.of(context).accentColor, decoration: TextDecoration.underline),
          ),
        ),
        Text(
          "بالفعل لدى حساب؟",
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  /*submitForm(Function postSignUp)async {
    if (!formkey.currentState.validate()) {
      return;
    }
    formkey.currentState.save();
    formkey.currentState.reset();
    SignUp _signUp= await postSignUp(
      _formdata['name'],
      _formdata['mobile'],
      _formdata['email'],
      _formdata['password']
    );
    
    if(_signUp.status == 'ok'){
    Navigator.of(context).pushNamed("/homepage");}
    
    

  }*/

  Future signupuser() async {
    var atef;
    var user =
        await http.post("http://waitbuzz.net/wallpaper/api/signup", body: {
      "name": _controller1.value.text,
      "mobile": _controller3.value.text,
      "email": _controller2.value.text,
      "password": _controller.value.text,
    }, headers: {
      'fcm_token': '894651558796453124mkjbvgchfxch',
      'os': 'android'
    }).then((data) {
      var res = json.decode(data.body);

      var body = res;
      atef = body["data"];
    });

    return atef;
  }
}
