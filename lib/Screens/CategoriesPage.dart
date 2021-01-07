import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/CategoriesClicks/CategoryView.dart';
import 'package:hdwallpapers/MyDrwar.dart';
import 'package:http/http.dart' as http;

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  loadCategoryResponse() async {
    var responseData =
        await http.get("http://waitbuzz.net/wallpaper/api/category/list");
    var obj = json.decode(responseData.body);
    var realdata = obj["data"];
    var category = realdata["categories"];

    return category;
  }

  var dataobj;

  @override
  void initState() {
    // TODO: implement initState
    loadCategoryResponse().then((data) {
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
        title:Text("الاقسام",style: TextStyle(color: Colors.white),),
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
      body: dataobj == null
          ? Center(child:
      CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),)
          : GridView.builder(
        padding: EdgeInsets.only(top: 20),

              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 8,
              //  childAspectRatio: 3/5,
                  ),
              itemCount: dataobj == null ? 3 : dataobj.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryView(dataobj[index]["name"],
                              "${dataobj[index]["id"]}")),
                    );
                  },
                  child: gridItem(dataobj[index]["name"],
                      dataobj[index]["image"], "${dataobj[index]['items']}"),
                );
              }),
    );
  }
}

Widget gridItem(String text, String photo, String item) {
  return Stack(
    children: <Widget>[
      Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            image:
                DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover),
            color: Colors.red),
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
