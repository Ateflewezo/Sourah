import 'package:flutter/material.dart';
import 'package:hdwallpapers/HomePageClicks/FirstItemClick.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
class AbstractPage extends StatefulWidget {
  final String name ;
  final String id ;

  const AbstractPage( this.name, this.id);
  @override
  _AbstractPageState createState() => _AbstractPageState();
}

class _AbstractPageState extends State<AbstractPage> {
  var data;

  Future getWallpapers () async {
    var wallpapers ;
    await http.post("http://waitbuzz.net/wallpaper/api/wallpaper/by_category" , body : {
      "category_id" : widget.id
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
  void initState() {
    getWallpapers().then((wallpapers){
      setState(() {
        data = wallpapers;

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
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  //------------------home----------
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/homepage");
                    },
                    title: Text(
                      "الصفحة الرئيسية",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                  //------------------latest--------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/latest");
                    },
                    title: Text(
                      "الاخيرة",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.view_list,
                      color: Colors.white,
                    ),
                  ),
                  //--------------------Popular---------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/popular");
                    },
                    title: Text(
                      "شائع",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.local_florist,
                      color: Colors.white,
                    ),
                  ),
                  //--------------rated------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/rated');
                    },
                    title: Text(
                      "تقيم",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.group,
                      color: Colors.white,
                    ),
                  ),
                  //-----------------categories--------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/categories");
                    },
                    title: Text(
                      "الاقسام",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.folder_open,
                      color: Colors.white,
                    ),
                  ),

//---------------------Gifs-------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/Gif");
                    },
                    title: Text(
                      "شائع",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.gif,
                      color: Colors.white,
                    ),
                  ),
                  //----------------favourite-------------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/favourite');
                    },
                    title: Text(
                      "المفضلة",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                  //--------------profile---------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    title: Text(
                      "الصفحة الشخصية",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.person_pin_circle,
                      color: Colors.white,
                    ),
                  ),
                  //---------------settings-------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/setting");
                    },
                    title: Text(
                      "الاعدادات",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  //-----------------login--------------
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/singin");
                    },
                    title: Text(
                      "تسجيل خروج",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(
                      Icons.settings_backup_restore,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            colorss(),
            data == null ? CircularProgressIndicator() :GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3),
                itemCount: data == null ? 3 : data.length,
                itemBuilder: (BuildContext context,int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirstItemClick("${data[index]["id"]}")),
                      );
                    },
                    child: gridItem( "dsadas" ,data[index]["image"]),
                  );
                }),
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
                      image: AssetImage(photo), fit: BoxFit.cover)),
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
                          color: Colors.red,
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
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
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
      width: 70,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}
