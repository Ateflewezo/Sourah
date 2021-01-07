import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/Screens/ResetPassword.dart';
import 'package:hdwallpapers/Screens/Singinpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './CheckCode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckCode extends StatefulWidget {
  @override
  _CheckCodeState createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCode> {
  TextEditingController _sendEmail=TextEditingController();
  TextEditingController _SendCode=TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "ادخل كود التحقق",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/forgetpassword");
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 100),
        children: <Widget>[

          Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textfiledEmail(),
                textfiledCode(),

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
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(

            contentPadding: EdgeInsets.only(right: 20, left: 20),
            labelText: "البريد الالكترونى ",
            labelStyle: TextStyle(
              color: Colors.red,
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
//------------------------code------------------------
  Widget textfiledCode() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: TextFormField(
        controller: _SendCode,
        autofocus: false,
//        keyboardType: TextInputType.,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20, left: 20),
            labelText: "ادخل الكود ",
            labelStyle: TextStyle(
              color: Colors.red,
            ),
            suffixIcon: Icon(
              Icons.lock,
              color: Colors.blueAccent,
              size: 18,
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك ادخل كود صحيح";
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
          onTap: () async{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            String email = prefs.getString('email');
            if (!formkey.currentState.validate()) {
            return;
           }
            if( email == _sendEmail.value.text){

              sendEmail().then((status) async{
                if(status == "ok"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                  );
                }else {
                  return showDialog(context: context ,
                      builder: (context){
                        return AlertDialog(
                          content: Text("من فضلك ادخل كود صحيح"),
                        );
                      }
                  );
                }

              });

            }


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

  Future sendEmail () async{
    var atef;
    var user = await http.post("http://waitbuzz.net/wallpaper/api/checkcode" , body: {
      "email" :_sendEmail.value.text,
      "code":_SendCode.value.text,
    } ).then((data){
      var res=json.decode(data.body);

      var body=res['status'];
      atef=body;


    });

    return atef;
  }

}