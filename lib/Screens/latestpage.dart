import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/HomePageClicks/FirstItemClick.dart';
import 'package:hdwallpapers/MyDrwar.dart';
import 'package:hdwallpapers/Screens/Searchpage.dart';
import 'package:hdwallpapers/Screens/WallpaperByColor.dart';

//import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Latestpage extends StatefulWidget {
  @override
  _LatestpageState createState() => _LatestpageState();
}

class _LatestpageState extends State<Latestpage> {
  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  List favouriteArray = [];

//-------------------getcolors--------------------
  loadcolorResponse() async {
    var responseData = await http.get(
      "http://waitbuzz.net/wallpaper/api/color/list",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0",
        'lang': 'en'
      },
    );
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var color = realdata["olors"];
    return color;
  }

//-----------------getLasted------------------------
  loadLatestResponse() async {
    var responseData = await http
        .get("http://waitbuzz.net/wallpaper/api/wallpaper/latest_wallpaper");
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var Lasted = realdata["wallpapers"];
    return Lasted;
  }

  //------------postFavoruite--------------------
  Future Addfavorit(id) async {
    var fav;
    var user = await http.post(
        "https://waitbuzz.net/wallpaper/api/wallpaper/add_favorit",
        body: {
          "wallpaper_id": id
        },
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0',
        }).then((data) {
      var body = json.decode(data.body);
      var favv = body['message'];
      fav = favv;
    });
    return fav;
  }

  //--------------------getAddfavourit---------------------------
  Future getfavorit() async {
    var fav;
    var user = await http
        .get("https://waitbuzz.net/wallpaper/api/wallpaper/favorits", headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0',
      "lang": "en"
    }).then((data) {
      var body = json.decode(data.body);
      var favv = body['data']["wallpapers"];
      for (var item in favv) {
        setState(() {
          favouriteArray.add(item["id"]);
        });
      }
    });
    return fav;
  }

  var dataobj;

  var datalasted;

  @override
  void initState() {
    // TODO: implement initState
    loadcolorResponse().then((data) {
      setState(() {
        dataobj = data;
      });
    });
    loadLatestResponse().then((data) {
      setState(() {
        datalasted = data;
      });
      getfavorit().then((data) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        title: Text(
          "الاخيرة",
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
      endDrawer: MyDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: datalasted == null
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              )
            : Column(
                children: <Widget>[
                dataobj==null?Center(
                  child: CircularProgressIndicator(),
                ):  colorss(),
                  Container(
                    height: MediaQuery.of(context).size.height - 140,
                    width: MediaQuery.of(context).size.width,
                    child: datalasted == null
                        ? CircularProgressIndicator()
                        : GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.all(5),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.65,
                            ),
                            itemCount:
                                datalasted == null ? 3 : datalasted.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FirstItemClick(
                                          "${datalasted[index]["id"]}"),
                                    ),
                                  );
                                },
                                child: gridItem(
                                    datalasted[index]["name"],
                                    datalasted[index]["image"],
                                    datalasted[index]["id"]),
                              );
                            }),
                  )
                ],
              ),
      ),
    );
  }

//-----------------------griditem----------------
  Widget gridItem(String text, String image, int id) {
    return Stack(
      children: <Widget>[
        Container(
          height: 170,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          ),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    favouriteArray == null
                        ? SizedBox()
                        : (favouriteArray.contains(id) == false
                            ? InkWell(
                                onTap: () {
                                  Addfavorit("${id}").then((message) {
                                    getfavorit();
                                  });
                                },
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Addfavorit("${id}").then((message) {
                                    getfavorit();
                                  });
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).accentColor,
                                ),
                              ))
                  ],
                ),
              )),
        ),
      ],
    );
  }

  //--------------------tap-------
  Widget colorss() {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "اذهب",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 90,
              // decoration: BoxDecoration(),
              child: dataobj == null
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: dataobj == null ? 0 : dataobj.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WallpaperByColor(
                                              "${dataobj[index]["id"]}",
                                            )),
                                  );
                                },
                                child: _colors(dataobj[index]['code'])),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        );
                      })),
        ],
      ),
    );
  }

  //---------------Colors------------
  Widget _colors(color) {
    return Container(
      width: 70,
      height: 40,
      decoration: BoxDecoration(
          color: Color(getColorHexFromStr(color)),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
