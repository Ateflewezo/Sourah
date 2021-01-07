import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hdwallpapers/HomePageClicks/CliCKimage.dart';
import 'package:hdwallpapers/Screens/Favouritepage.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:image_crop/image_crop.dart';

class FirstItemClick extends StatefulWidget {
  final String id;

  const FirstItemClick(this.id);

  _FirstItemClickState createState() => _FirstItemClickState();
}

class _FirstItemClickState extends State<FirstItemClick> {
  // String _message = "";
  var filepath;

  File cropped;
  var img;

  // String _path = "";
  var rating = 1.0;
  var data;
  var tags;
  var datafav;

  Future getWallpapers() async {
    var wallpapers;
    await http.post("https://waitbuzz.net/wallpaper/api/wallpaper/view", body: {
      "wallpaper_id": widget.id
    }, headers: {
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0",
      "lang": "en"
    }).then((data) {
      var body = json.decode(data.body);
      var walls = body['wallpaper'];
      wallpapers = walls;
    });
    return wallpapers;
  }

  @override
  void initState() {
    getWallpapers().then((wallpapers) {
      setState(() {
        data = wallpapers;
        print(convertTags());
      });
    });
  }

  convertTags() {
    tags = data["tags"]
        .split(',') // split the text into an array
        .map((String text) => text) // put the text inside a widget
        .toList();
    return tags;
  }

  //------------postFavoruite--------------------
  Future Addfavorit() async {
    var fav;
    var user = await http
        .post("http://waitbuzz.net/wallpaper/api/wallpaper/add_favorit", body: {
      "wallpaper_id": widget.id
    }, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0',
    }).then((data) {
      var body = json.decode(data.body);
      var favv = body['message'];
      fav = favv;
    });
    return fav;
  }

  TextEditingController _controller = TextEditingController();

//  cropped != null ? Image.file(cropped) :
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 280,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 350.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: firstimage(),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/homepage");
                          },
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 330.0,
                        left: 15,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Addfavorit().then((ddsa) {
                                    getWallpapers().then((wallpaper) {
                                      setState(() {
                                        data = wallpaper;
                                      });
                                    });
                                  });
                                },
                                child: data["is_fav"] == "false"
                                    ? Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                onTap: () {
                                  _settingModalBottomSheet(context);
                                },
                                child: Icon(
                                  Icons.save,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 370,
                        right: 20,
                        child: Text(data["name"]),
                      ),
                    ],
                  ),
                ),
                information(),
                informationIcon(),
                tages(),
                informationImage(),
              ],
            ),
    );
  }

  //---------------------------------image-------------------
  Widget firstimage() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClickImage(data["image"]),
          ),
        );
      },
      child: data == null
          ? CircularProgressIndicator()
          : Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: img == null ? NetworkImage(data["image"]) : img,
                      fit: BoxFit.cover)),
            ),
    );
  }

  //----------------------information------------------
  Widget information() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                color: Colors.white),
            child: Column(
              children: <Widget>[Text("المشاهدات"), Text("${data["views"]}")],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                Text("التحميلات"),
                Text("${data["downloads"]}")
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                Text("التقيمات"),
                SmoothStarRating(
                  starCount: 5,
                  rating: double.parse("${data["rate"]}"),
                  size: 23,
                ),
                SizedBox(
                  height: 3,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  //-------------iconsInformation-------------------------
  Widget informationIcon() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    return _showDialoggg();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.green[500],
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(
                      Icons.photo,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text("خلفية"),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    _showDiolge();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text("تقيم"),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    downloadImage().then((data) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text("تم حفظ الجزء الصورة بنجاح"));
                          });
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text("حفظ"),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Share.share('check out my website https://example.com');
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text("مشاركة"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //---------------------Tages------------------------
  Widget tages() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            width: 70,
            child: Center(
              child: Text(
                "Tages",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          data == null
              ? CircularProgressIndicator()
              : Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 90,
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: tags == null ? 3 : tags.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            SizedBox(width: 5),
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Center(
                                child: Text(
                                  tags[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        );
                      }),
                ),
        ],
      ),
    );
  }

  //---------------------Information Image---------------
  Widget informationImage() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                Text("الابعاد"),
                Text("${data["resolution"]}")
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
                color: Colors.white),
            child: Column(
              children: <Widget>[Text("الحجم"), Text("${data["size"]}")],
            ),
          ),
        ),
      ],
    );
  }

  //-------------------reportSheetButtom-------------------
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
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      child: Text(
                        " تقرير الصورة ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: _controller,
                          maxLines: 5,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  gapPadding: 20,
                                  borderRadius: BorderRadius.circular(10)),
                              hintMaxLines: 3,
                              hintText: ("اكتب تقريرك"),
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Reportpost().then((data) async {
                            print(data);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                  ],
                ),
              ),
            ),
          );
        });
  }

  //---------------------Rating*****---------------------
  _showDiolge() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: SmoothStarRating(
                onRatingChanged: (value) {
                  print(value);
                  setState(() {
                    rating = value;
                  });
                  Navigator.pop(context);
                  _showDiolge();
                },
                starCount: 5,
                rating: rating,
                size: 40.0,
                spacing: 0.0),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Center(
                  child: FlatButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "تقيم",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      RateImage().then((sa) {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              )
            ],
          );
        });
  }

//------------------rate------------------
  Widget _buildRate() {
    return SmoothStarRating(
        onRatingChanged: (v) {
          rating = v;
          setState(() {});
        },
        starCount: 5,
        rating: rating,
        size: 40.0,
        color: Colors.yellowAccent,
        borderColor: Colors.yellowAccent,
        spacing: 0.0);
  }

//---------------postReport---------------
  Future Reportpost() async {
    var atef;
    var user = await http
        .post("http://waitbuzz.net/wallpaper/api/wallpaper/report", body: {
      "comment": _controller.value.text,
      "wallpaper_id": "${data['id']}"
    }, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0',
    }).then((data) {
      var res = json.decode(data.body);
      var body = res["status"];
      atef = body;
    });
    return atef;
  }

  // send rate
  Future RateImage() async {
    var atef;
    var user = await http
        .post("http://waitbuzz.net/wallpaper/api/wallpaper/rate", body: {
      "rate": "${rating}",
      "wallpaper_id": "${data['id']}"
    }, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvdGFtd2VsL2FwaS9zaWduaW4iLCJpYXQiOjE1NTcwNjE0OTEsImV4cCI6MjE0NzQ4MzY0NywibmJmIjoxNTU3MDYxNDkxLCJqdGkiOiI3YkZoVXNEZGJXMkFtU0ZhIn0.cdPkuwKnMeqbGfX2we1Dfao7N9k6jkX3Ib1bAQaquH0',
    }).then((datsa) {
      getWallpapers().then((wallpaper) {
        setState(() {
          data = wallpaper;
        });
      });
    });
  }

  Future downloadImage() async {
    var datas;
    var response = await http.get(data["image"]);
    var _filepath =
        await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    setState(() {
      filepath = _filepath;
    });
    return datas;
  }

  void _showDialoggg() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
              child: new Text(
            " وضع الصورة كخلفية",
            style: TextStyle(fontSize: 20),
          )),
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Wallpaper.homeScreen(data["image"]);
                    Navigator.pop(context);
                  },
                  child: Text("الشاشة الرئيسية"),
                ),
                InkWell(
                  onTap: () {
                    Wallpaper.lockScreen(data["image"]);
                    Navigator.pop(context);
                  },
                  child: Text("شاشة القفل"),
                ),
                InkWell(
                  onTap: () {
                    Wallpaper.bothScreen(data["image"]);
                    Navigator.pop(context);
                  },
                  child: Text("كلاهما"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                ),
                child: Center(
                  child: Text(
                    "ألغاء",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
