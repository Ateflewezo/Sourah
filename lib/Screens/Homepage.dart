import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hdwallpapers/HomePageClicks/FirstItemClick.dart';
import 'package:hdwallpapers/MyDrwar.dart';
import 'package:hdwallpapers/Screens/CategoriesPage.dart';
import 'package:hdwallpapers/Screens/Favouritepage.dart';
import 'package:hdwallpapers/Screens/Searchpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../CategoriesClicks/CategoryView.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

   String _searchText = "";
   Icon _searchIcon = new Icon(Icons.search); 
   Widget _appBarTitle = new Text( 'الصفحة الرئيسية' );
   TextEditingController _filter =TextEditingController();

  void _searchPressed() {
  setState(() {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        onSubmitted: (value){
          if (value.length > 0) {
            searchBar(value).then((data){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage(data) ),
                );
            });
          }
           
        },
        controller: _filter,
        decoration: new InputDecoration(
          hintText: 'Search...'
        ),
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text('الصفحة الرئيسية');
      _filter.clear();
    }
  });
}

  TextEditingController search = TextEditingController();
  String searchWord ;
  
  List favouriteArray  = [];
//-------------------getCategory--------------------
  loadCategoryResponse() async {
    var responseData =
        await http.get("https://waitbuzz.net/wallpaper/api/category/list",);
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var category = realdata["categories"];
    return category;
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
  
  // ------------- search bar ----------------

    Future searchBar(String name) async {
    var fav;
    var user = await http
        .post("https://waitbuzz.net/wallpaper/api/wallpaper/search", body: {
      "name": name
    }, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0',
    }).then((data) {
      var body = json.decode(data.body);
      var favv = body['data']["data"];
      fav=favv;

    });
    return fav;
  }

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

  //----------------------getLasted-----------------------
  loadLatestResponse() async {
    var responseData = await http
        .get("https://waitbuzz.net/wallpaper/api/wallpaper/latest_wallpaper");
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var Lasted = realdata["wallpapers"];

    return Lasted;
  }

  //------------------------getPouplar-----------------------
  loadpouplarResponse() async {
    var responseData = await http
        .get("https://waitbuzz.net/wallpaper/api/wallpaper/popular_wallpaper");
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var Pouplar = realdata["wallpapers"];
    return Pouplar;
  }

  //--------------------getRatedWallpaper-------------------------
  loadRatedWallpapersResponse() async {
    var responseData = await http
        .get("https://waitbuzz.net/wallpaper/api/wallpaper/rated_wallpaper",headers: {
          "lang":"en"
    });
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var RatedWallpapers = realdata["wallpapers"];

    return RatedWallpapers;
  }

  var dataobj;
  var ourbar;
  var datalasted;
  var datapouplar;
  var dataRatedWallpapers;

  @override
  void initState() {
    // TODO: implement initState
    //-----------------getCategory------------
    loadCategoryResponse().then((data) {
      setState(() {
        dataobj = data;
        ourbar = Text(
          "الصفحة الرئيسية",
          style: TextStyle(color: Colors.white),
        );
      });
    });
    //---------------------getlasted---------------------
    loadLatestResponse().then((data) {
      setState(() {
        datalasted = data;
      });
    });
    //------------------geTPouplar-----------------
    loadpouplarResponse().then((data) {
      setState(() {
        datapouplar = data;
      });
    });
    //------------getRatedWallpapers--------------
    loadRatedWallpapersResponse().then((data) {
      setState(() {
        dataRatedWallpapers = data;
      });
      getfavorit().then((data){

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0.0,
          title: _appBarTitle,
          centerTitle: true,
          leading:  InkWell(
            onTap: (){
              _searchPressed();
            },
            child: _searchIcon,
          )
          ),
        
        endDrawer: MyDrawer(),

        body: Directionality(
          textDirection: TextDirection.rtl,
          child: dataRatedWallpapers == null
              ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,

            ),
          ): ListView(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Container(
                    height: 350,
                    child: dataRatedWallpapers == null
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : Swiper(
                            viewportFraction: 0.9,
                            scale: 1.0,
                            scrollDirection: Axis.horizontal,
                            itemCount: dataRatedWallpapers == null
                                ? 0
                                : dataRatedWallpapers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>FirstItemClick("${dataRatedWallpapers[index]["id"]}"),
                                    ),
                                  );
                                  
                                }
                                ,
                                child: firstimage(
                                    dataRatedWallpapers[index]["name"],
                                    dataRatedWallpapers[index]["image"],
                                    dataRatedWallpapers[index]["id"]
                                    ),
                              );
                            }),
                  )),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/categories");
                  },
                  child: title("الاقسام")),
              SizedBox(
                height: 10,
              ),
              //-----------------------------Categories---------------------------
              Container(
                height: 100,
                padding: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Theme.of(context).accentColor.withOpacity(0.1),
                ),
                child: dataobj == null
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: dataobj == null ? 3 : dataobj.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryView(
                                        dataobj[index]["name"],
                                        "${dataobj[index]["id"]}")),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5,
                                ),
                                gridItem(
                                    dataobj[index]["name"],
                                    dataobj[index]["image"],
                                    "${dataobj[index]['items']}"),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          );
                        }),
              ),
              SizedBox(
                height: 20,
              ),

              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/latest");
                  },
                  child: title("الاحدث")),
              SizedBox(
                height: 10,
              ),
              //--------------------------------lastet--------------
              Container(
                height: 200,
                padding: EdgeInsets.only(right: 15),
                child: datalasted == null
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: datalasted == null ? 3 : datalasted.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>FirstItemClick("${datalasted[index]["id"]}"),
                                  ),
                                );
                              }
                                ,
                                child: lastestWallpapers(datalasted[index]["name"],
                                    datalasted[index]["image"],datalasted[index]["id"]),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          );
                        }),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/popular");
                  },
                  child: title("الشائع")),
              SizedBox(
                height: 10,
              ),
              //--------------------------------popular---------------------
              Container(
                height: 200,
                padding: EdgeInsets.only(right: 15),
                child: datapouplar == null
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: datapouplar == null ? 3 : datapouplar.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>FirstItemClick("${datapouplar[index]["id"]}"),
                                  ),
                                );
                              }
                                ,
                                child: popularWallpapers(datapouplar[index]["name"],
                                    datapouplar[index]["image"],datapouplar[index]["id"]),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          );
                        }),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }

  //------------firstimage----------
  Widget firstimage(String text, String image , int id) {
    return new Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width - 65,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                         favouriteArray == null ? SizedBox() : (favouriteArray.contains(id) == false ? InkWell(
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
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  //--------------title-------------------
  Widget title(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 3,
                height: 30,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 2,
              ),
            ],
          ),
          Text(
            "عرض الكل",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

//-----------------lastest Wallpaper--------------
  Widget lastestWallpapers(String text, String image,int id) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        favouriteArray == null ? SizedBox() : (favouriteArray.contains(id) == false ? InkWell(
                          onTap: (){
                            Addfavorit("${id}").then((message){
                              getfavorit();
                            });
                          },
                          child: Icon(
                            Icons.favorite_border,
                            color:  Theme.of(context).accentColor,
                          ),
                        ) :
                        InkWell(
                          onTap: (){
                            Addfavorit("${id}").then((message){
                              getfavorit();
                            });
                          },
                          child: Icon(Icons.favorite , color:  Theme.of(context).accentColor,),
                        ))
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  //------------------Popular Wallpaper------------
  Widget popularWallpapers(String text, String image,int id) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        favouriteArray == null ? SizedBox() : (favouriteArray.contains(id) == false ? InkWell(
                          onTap: (){
                            Addfavorit("${id}").then((message){
                              getfavorit();
                            });
                          },
                          child: Icon(
                            Icons.favorite_border,
                            color:  Theme.of(context).accentColor,
                          ),
                        ) :
                        InkWell(
                          onTap: (){
                            Addfavorit("${id}").then((message){
                              getfavorit();
                            });
                          },
                          child: Icon(Icons.favorite , color:  Theme.of(context).accentColor,),
                        ))
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget gridItem(String text, String photo, String item) {
    return Stack(
      children: <Widget>[
        Container(
          height: 105,
          width: 105,
          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(60),
              shape: BoxShape.circle,
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  image: NetworkImage(photo), fit: BoxFit.cover),
              ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    item,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
