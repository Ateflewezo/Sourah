import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  Future clearCache()async{

      var appDir = (await getTemporaryDirectory()).path;
      var done = Directory(appDir).delete(recursive: true);
      return done;
  }

  bool _value1 = true;

  void _onChanged1(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "الاعدادات",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/homepage");
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.only(right: 10, left: 10),
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "السماح للاشعارات",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Switch(
                      activeColor: Colors.white,
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Colors.white,
                      value: _value1,
                      onChanged: _onChanged1),
                ],
              ),
            ),
            Divider(
              height: 0.8,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Text("Clear Cache",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    "MB 0",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    onTap: (){
                      clearCache().then((data){
                         return showDialog(
                           context: context,
                           builder: (BuildContext context){
                             return AlertDialog(
                               content: Text("تم مسح ملف الكاش بنجاح"),
                             );
                           }
                         );
                      });
                    },
                      child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 0.8,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "تقيم التطبيق",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                textAlign: TextAlign.right,
              ),
            ),
            Divider(
              height: 0.8,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "مزيد من التطبيقات",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                textAlign: TextAlign.right,
              ),
            ),
            Divider(
              height: 0.8,
              color: Colors.white,
            ),
            InkWell(
              onTap: () {
                Share.share('check out my website https://example.com');
              },
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "مشاركة التطبيق",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Divider(
              height: 0.8,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/about");
                },
                child: Text(
                  "من نحن",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Divider(
              height: 0.8,
              color: Colors.white,
            ),
            InkWell(
              onTap: (){
                _settingModalBottomSheet(context);
              },
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "سياسة الاستخدام",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding:
            const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
            child: Material(
              elevation: 3.0,
              child: Container(
                height:MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.greenAccent
                ),
              ),
            ),
          );
        });
  }

}
