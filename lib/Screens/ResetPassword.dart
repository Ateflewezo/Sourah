import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/Screens/Singinpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './CheckCode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _sendEmail=TextEditingController();
  TextEditingController _Password=TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "استعادة الرقم السرى ",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckCode()),
            );
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
                textfiledPassword(),

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
  Widget textfiledPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: TextFormField(
        controller:_Password,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20, left: 20),
            labelText: "ادخل الرقم السرى  ",
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
            return "من فضلك ادخل رقم صحيح";
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
//            if( "${email}" == "${_sendEmail.value.text}") {
              sendEmail().then((status) async{
                if(status == 'ok'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SinginPage()),
                  );
                }
              });
//            }
//            else {
//               showDialog(context: context ,
//                  builder: (context){
//                    return AlertDialog(
//                      content: Text("تاكد من الايميل"),
//                    );
//                  }
//              );
//            }
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
    var user = await http.post("http://waitbuzz.net/wallpaper/api/resetpassword" , body: {
      "email" :_sendEmail.value.text,
      "password":_Password.value.text,
    } ).then((data){
      var res=json.decode(data.body);

      var body=res['status'];
      atef=body;
    });
    return atef;
  }

}