import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './CheckCode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _sendEmail=TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "هل نسيت كلمة السر",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/singin");
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("هل نسيت كلمة السر"),
                Text(
                  "ادخل البريد الالكترونى ونحن سوف نرسل "
                      "الطريقة لتغير رقم السرى ",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textfiledEmail(),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _Send(),
        ],
      ),
    );
  }

//---------------------Email-------------------------
  Widget textfiledEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: TextFormField(
        controller: _sendEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20, left: 20),
            labelText: "البريد الالكترونى ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            suffixIcon: Icon(
              Icons.mail_outline,
              color: Colors.blueAccent,
              size: 18,
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك ادخل بريد صحيح";
          }
        },
      ),
    );
  }
  //---------------------sendButton---------------------
  Widget _Send() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: InkWell(
          onTap: () {
            if (!formkey.currentState.validate()) {
              return;
            }
//            formkey.currentState.save();
//            formkey.currentState.reset();
            sendEmail().then((status) async{
                  if(status == "ok"){
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('email', _sendEmail.value.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckCode(
                      )),
                    );
                  }else {
                    return showDialog(context: context ,
                      builder: (context){
                      return AlertDialog(
                        content: Text("من فضلك أدخل إيميل آخر"),
                      );
                      }
                    );
                  }

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
                "ارسال",
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

  Future sendEmail () async {
    var atef;
    var user = await http.post(
        "http://waitbuzz.net/wallpaper/api/sendmail", body: {
      "email": _sendEmail.value.text,
    }).then((data) {
      var res = json.decode(data.body);

      var body = res["status"];
      atef = body;
    });
    return atef;
  }

//  void showAlert(BuildContext context,String text) {
//    showDialog(
//        context: context,
//        builder: (context) => AlertDialog(
//          content: Text(text),
//        ));
//  }
}
