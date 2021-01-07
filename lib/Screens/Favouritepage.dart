import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/GifClicks/GifItemClick.dart';
import 'package:hdwallpapers/HomePageClicks/FirstItemClick.dart';
import 'package:hdwallpapers/MyDrwar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavouritPage extends StatefulWidget {
  final String favid;

  const FavouritPage( this.favid);
  @override
  _FavouritPageState createState() => _FavouritPageState();
}

class _FavouritPageState extends State<FavouritPage> {
  loadFavouritResponse() async {
    var responseData = await http.get(
      "http://waitbuzz.net/wallpaper/api/wallpaper/favorits",
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0"
      },
    );
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var wallpapers = realdata["wallpapers"];

    return wallpapers;
  }

  var dataobj;
  TabController _tabController;

  @override
  void initState() {
    widget.favid;
    loadFavouritResponse().then((data) {
      setState(() {
        dataobj = data;
//        widget.favid;
      });
    });

    _tabController = TabController(vsync: DrawerControllerState(), length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            elevation: 5,
            title:Text("المفضلة",style: TextStyle(color: Colors.white),),
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed("/homepage");
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.white,
              ),
            ),
            //---   -  - - - - --------------------tabs------------------
          ),
          endDrawer: MyDrawer(),
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _TabBar(),
              informatinOrder(),
            ],
          )),
    );
  }

//---------------------TabBar-----------------------
  Widget _TabBar() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).accentColor),
      child: Center(
        child: Container(
          //  padding: EdgeInsets.only(left:20),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
                color: Colors.purple,
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            indicatorColor: Theme.of(context).primaryColor,
            tabs: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  height: 30,
                  width: 100,
                  child: Center(
                    child: Tab(
                      text: "صور متحركة",
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  height: 30,
                  width: 100,
                  child: Center(
                    child: Tab(
                      text: "صور",
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //-------------------TabBarView-----------------------
  Widget informatinOrder() {
    return Container(
      height: MediaQuery.of(context).size.height - 140,
      color: Theme.of(context).primaryColor,
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
         Directionality(
           textDirection: TextDirection.rtl,
           child: ListView(
             padding: EdgeInsets.only(top: 10),
             children: <Widget>[
               dataobj == null ? Center(child:
               CircularProgressIndicator(
                 backgroundColor: Colors.red,
               ),): GridView.builder(
                   shrinkWrap: true,
                   scrollDirection: Axis.vertical,
                   physics: NeverScrollableScrollPhysics(),
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 1.5,childAspectRatio: 0.70),
                   itemCount:
                   dataobj == null ? 3 : dataobj.length,
                   itemBuilder: (BuildContext context,int index) {
                     return InkWell(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) =>GiftItemClick("${dataobj[index]["id"]}"),
                           ),
                         );
                       },
                       child:
                       gridItem(dataobj[index]["image"],
                           ),
                     );
                   })
             ],
           ),
         ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              padding:EdgeInsets.only(top: 10),
              children: <Widget>[
                dataobj == null ? Center(child:
                CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),) : GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
//                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 1.5
                        ,childAspectRatio: 1.1
                    ),
                    itemCount: dataobj == null ? 3 : dataobj.length,
                    itemBuilder: (BuildContext context,int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>FirstItemClick("${dataobj[index]["id"]}"),
                            ),
                          );
                        },
                        child: gridItem(dataobj[index]["image"],
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gridItem(String image) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: <Widget>[
          Container(
            height: 190,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
                color: Colors.red),
            child: Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 3),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//----------colors--------------
  Widget colorss() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          color: Theme.of(context).primaryColor),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 55,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Go",
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
            height: 45,
            width: MediaQuery.of(context).size.width - 90,
            // decoration: BoxDecoration(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _colors(Colors.yellow),
                SizedBox(
                  width: 5,
                ),
                _colors(Colors.red),
                SizedBox(
                  width: 5,
                ),
                _colors(Colors.white),
                SizedBox(
                  width: 5,
                ),
                _colors(Colors.green),
                SizedBox(
                  width: 5,
                ),
                _colors(Colors.blue),
                SizedBox(
                  width: 5,
                ),
                _colors(Colors.orange),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //---------------Colors------------
  Widget _colors(Color color) {
    return Container(
      //height: 30,
      width: 70,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}
