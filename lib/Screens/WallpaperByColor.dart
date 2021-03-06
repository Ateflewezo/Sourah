

import 'package:flutter/material.dart';
import 'package:hdwallpapers/HomePageClicks/FirstItemClick.dart';
import 'package:hdwallpapers/MyDrwar.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
class WallpaperByColor extends StatefulWidget {

  final String id ;

  const WallpaperByColor( this.id) ;
  @override
  _WallpaperByColorState createState() => _WallpaperByColorState();
}

class _WallpaperByColorState extends State<WallpaperByColor> {
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
  loadcolorResponse() async {
    var responseData = await http.get(
      "http://waitbuzz.net/wallpaper/api/color/list",
      headers: {
        "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0",
        'lang':'en'
      },
    );
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var color = realdata["olors"];

    return color;
  }

  var dataobj ;
  var data;

  Future getWallpapers () async {
    var wallpapers ;
    await http.post("http://waitbuzz.net/wallpaper/api/wallpaper/by_color" , body : {
      "color_id" : widget.id
    }, headers:  {
      "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0",
      "lang" : "ar"
    }).then((data){
      var body = json.decode(data.body);
      var dataa = body["data"];
      var walls = dataa['wallpapers'];
      wallpapers = walls;
    });
    return wallpapers;
  }

  @override
  void initState() {
    getWallpapers().then((wallpapers){
      setState(() {
        data = wallpapers;

      });
    });
    loadcolorResponse().then((data){
      setState(() {
        dataobj = data;
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
        title:Text("لونك",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pushNamed("/homepage");
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,
          ),
        ),
      ),
      endDrawer: MyDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:  data == null ? Center(
          child: CircularProgressIndicator() ,
        ): Column(
          children: <Widget>[
            colorss(),
           Container(
             height: MediaQuery.of(context).size.height-140,
             child:  data == null ? CircularProgressIndicator() :GridView.builder(
                 shrinkWrap: true,
                 scrollDirection: Axis.vertical,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3,childAspectRatio: 2/3),
                 itemCount: data == null ? 3 : data.length,
                 itemBuilder: (BuildContext context,int index) {
                   return InkWell(
                     onTap: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => FirstItemClick("${data[index]["id"]}")),
                       );
                     },
                     child: gridItem( data[index]['name'] ,data[index]["image"]),
                   );
                 }),
           )
          ],
        ),
      ),
    );
  }


  //--------------GridItem--------------
  Widget gridItem(String text, String photo) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 170,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(photo), fit: BoxFit.cover)),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

//--------------------tap-------
  Widget colorss() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(10)),
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
              child: dataobj == null ? CircularProgressIndicator() : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:dataobj == null ? 0 : dataobj.length,
                  itemBuilder: (BuildContext context,int index) {
                    return  Row(
                      children: <Widget>[
                        SizedBox(width: 5,),
                        _colors(dataobj[index]['code']),
                        SizedBox(width: 5,)
                      ],
                    );
                  })
          ),
        ],
      ),
    );
  }

  //---------------Colors------------
  Widget _colors(color) {
    return Container(
      width: 70,
      height: 40,
      decoration:
      BoxDecoration(color: Color(getColorHexFromStr(color)), borderRadius: BorderRadius.circular(10)),
    );
  }
}

