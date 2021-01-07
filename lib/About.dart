import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  //-----------------getContactUs-----------------------
  loadContactUsResponse() async {
    var responseData = await http.get(
        "http://waitbuzz.net/wallpaper/api/contact_us",
        headers: {'lang': 'en'});
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    // var detailss = realdata["details"];

    return realdata;
  }

  //------------------getAbout-----------------------
  loadAboutResponse() async {
    var responseData = await http.get(
        "http://waitbuzz.net/wallpaper/api/about",
        headers: {'lang': 'ar'});
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
     //var detailss = realdata["details"];

    return realdata;
  }

  var dataobj;
  var dataabout;
  @override
  void initState() {
    
    loadContactUsResponse().then((data) {
      setState(() {
        dataobj = data;
      });
    });
    loadAboutResponse().then((data) {
      setState(() {
        dataabout = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "من نحن",
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
          ),
        ),
      ),
      body: dataabout == null
          ? Center(child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),):ListView(
        children: <Widget>[
          dataabout == null
              ? CircularProgressIndicator():_About(dataabout["details"]),
          dataobj == null
              ? CircularProgressIndicator()
              : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: dataobj == null ? 0 : dataobj.length,
              itemBuilder: (BuildContext context, int index) {
                return _information(
                    dataobj[index]['key'], dataobj[index]['value']);
              }),
        ],
      )
    );
  }

  //---------------information-------------------
  Widget _information(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(key),
                  Text(value),
                ],
              ),
              Icon(
                Icons.email,
                color: Colors.yellow,
                size: 40,
              )
            ],
          )),
    );
  }

  //--------About--------------
  Widget _About(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
  
}
