import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/CategoriesClicks/Abstract.dart';
import 'package:hdwallpapers/GifClicks/GifItemClick.dart';
import 'package:hdwallpapers/HomePageClicks/FirstItemClick.dart';
import 'package:hdwallpapers/MyDrwar.dart';
import 'package:hdwallpapers/Screens/Favouritepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class GifPage extends StatefulWidget {
  @override
  _GifPageState createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
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
  

  List favouriteArray  = [];
//-----------------------getGifLatest-------------------------------
  loadGifLatestResponse() async {
    var responseData = await http.get(
      "http://waitbuzz.net/wallpaper/api/wallpaper/latest_gif",
      headers: {
        "Authorization":
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0",
        'lang':'en'
      },
    );
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var Giflatest = realdata["wallpapers"];

    return Giflatest;
  }
  //-----------------------getGifRated-------------------------------
  loadGifRatedResponse() async {
    var responseData = await http.get(
      "http://waitbuzz.net/wallpaper/api/wallpaper/latest_gif",
      headers: {
        'lang':'en'
      },
    );
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var GifRated = realdata["wallpapers"];

    return GifRated;
  }
//-----------------------getGifRated-------------------------------
  loadGifpouplarResponse() async {
    var responseData = await http.get(
      "http://waitbuzz.net/wallpaper/api/wallpaper/latest_gif",
      headers: {
        "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0",
        'lang':'en'
      },
    );
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var Gifpouplar = realdata["wallpapers"];

    return Gifpouplar;
  }

  //------------postFavoruite--------------------
  Future Addfavorit(id) async {
    var fav;
    var user = await http
        .post("https://waitbuzz.net/wallpaper/api/wallpaper/add_favorit", body: {
      "wallpaper_id": id
    }, headers: {
      'Authorization':
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0',
    }).then((data) {
      var body = json.decode(data.body);
      var favv = body['message'];
      fav=favv;

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
      "lang" : "en"
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

  var dataGiflasted;
  var dataRated;
 var datapouplar;

  TabController _tabController;
  @override
  void initState() {
    loadGifLatestResponse().then((data) {
      setState(() {
        dataGiflasted = data;
      });
      getfavorit().then((data){

      });
    });

    loadGifRatedResponse().then((data) {
      setState(() {
        dataRated = data;
      });
      getfavorit().then((data){

      });
    });
    loadGifpouplarResponse().then((data) {
      setState(() {
        datapouplar = data;
      });
      getfavorit().then((data){

      });
    });



    _tabController =
        new TabController(vsync: DrawerControllerState(), length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        title: Text(
          "صور متحركة",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pushNamed("/homepage");
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,
          ),
        ),
      ),
      endDrawer:MyDrawer(),
      body:dataGiflasted == null ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ) : ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _TabBar(),
          Container(
            height: MediaQuery.of(context).size.height-150,
            child: informatinOrder(),
          )

        ],
      ),
    );
  }

//--------------------------------TabBar--------------------
  Widget _TabBar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
             // color: Theme.of(context).accentColor.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Center(
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  color: Color(getColorHexFromStr("#57476B")),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                indicatorColor: Theme.of(context).primaryColor,
                // indicatorSize: TabBarIndicatorSize.tab,
                tabs: <Widget>[
                 Container(
                   width: 80,
                   //margin: EdgeInsets.all(5),
                   child: Tab(
                     text: "الاخيرة",
                   ),
                 ),
                  Container(
                    width: 80,
                    //margin: EdgeInsets.all(5),
                    child: Tab(
                      text: "التقيمات",
                    ),
                  ),

                  Container(
                    width: 80,
                    //margin: EdgeInsets.all(5),
                    child: Tab(
                      text: "الشائع",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//-------------informationOrder----------------
  Widget informatinOrder() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            //--------------------TABbarView Latest------------
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                dataGiflasted == null ? CircularProgressIndicator() : GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.67,
                        crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 1.5),
                    itemCount:
                    dataGiflasted == null ? 3 : dataGiflasted.length,
                    itemBuilder: (BuildContext context,int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GiftItemClick("${dataGiflasted[index]["id"]}"),

                            ));
                        },
                        child:
                        gridItem(dataGiflasted[index]["image"],dataGiflasted[index]["id"]
                        ),
                      );
                    })
              ],
            ),
            //--------------------tabBRated-----------------
            ListView(
              children: <Widget>[
                dataRated == null ? CircularProgressIndicator() : GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       childAspectRatio: 2/3, crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 1.5,

                    ),
                    itemCount: dataRated == null ? 3 : dataRated.length,
                    itemBuilder: (BuildContext context,int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GiftItemClick("${dataGiflasted[index]["id"]}"),

                              ));
                        },
                        child: gridItem(dataRated[index]["image"],dataRated[index]["id"]
                        ),
                      );
                    })
              ],
            ),
            //-------------------tabBarPouplar--------------
            ListView(
              children: <Widget>[
                datapouplar == null ? CircularProgressIndicator() : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2/3,crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 1.5,
                    ),
                    itemCount: datapouplar == null ? 3 : datapouplar.length,
                    itemBuilder: (BuildContext context,int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GiftItemClick("${dataGiflasted[index]["id"]}"),

                              ));
                        },
                        child: gridItem(datapouplar[index]["image"],datapouplar[index]["id"]
                        ),
                      );
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget gridItem(String image,int id) {
    return Stack(
      children: <Widget>[
        Container(
          height: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              color: Colors.red),
          child: Padding(
            padding: const EdgeInsets.only(right: 5,bottom: 3),
            child: Align(
              alignment:Alignment.bottomLeft,
              child: favouriteArray == null ? SizedBox() : (favouriteArray.contains(id) == false ? InkWell(
                onTap: (){
                  Addfavorit("${id}").then((message){
                    getfavorit();
                  });
                },
                child: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
              ) :
              InkWell(
                onTap: (){
                  Addfavorit("${id}").then((message){
                    getfavorit();
                  });
                },
                child: Icon(Icons.favorite , color: Theme.of(context).accentColor,),
              ))
            ),
          ),
        )
      ],
    );
  }
}
