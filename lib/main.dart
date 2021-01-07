import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdwallpapers/Screens/PorfilePage.dart';
import './Screens/splash.dart';
import './Screens/Singinpage.dart';
import './Screens/Singup.dart';
import './Screens/ForgetPasswordPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//------------Drawer-----------------
import './Screens/Homepage.dart';
import './Screens/latestpage.dart';
import './Screens/Favouritepage.dart';
import './Screens/PorfilePage.dart';
import './Screens/EditPrrofilePage.dart';
import './Screens/CategoriesPage.dart';
import './Screens/popularPage.dart';
import './Screens/RatedPage.dart';
import './Screens/GifPage.dart';
import './Screens/SettingPages.dart';
import './About.dart';
//---------------HomePageClicks--------
import './HomePageClicks/FirstItemClick.dart';
import './HomePageClicks/CliCKimage.dart';
//----------------CategoriesPageClicks--------
import './CategoriesClicks/Abstract.dart';

import './CategoriesClicks/CategoryView.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {

  final  FirebaseMessaging  _messaging = FirebaseMessaging();


  @override
  void initState() { 
    _messaging.getToken().then((token){
      print(token);
    });
    
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(getColorHexFromStr('#221e38')),
        fontFamily: 'cairo',
        accentColor: Color(getColorHexFromStr('#ea1f50')),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/singin': (context) => SinginPage(),
        '/singup': (context) => SingUPScreen(),
        '/forgetpassword':(context)=>ForgetPassword(),
        '/homepage': (context) => Homepage(),
        '/latest': (context) => Latestpage(),
        '/favourite': (context) => FavouritPage(""),
        '/profile': (context) => ProfilePage(),
        '/editprofile': (context) => EditProfile(),
        '/categories':(context)=>CategoriesPage(),
        '/popular':(context)=>PopularPage(),
        '/rated':(context)=>RatedPage(),
        '/Gif':(context)=>GifPage(),
        '/setting':(context)=>SettingPage(),
        '/about':(context)=>AboutPage(),
//---------------------HomePageClicks----------------
//       '/firstItemClick':(context)=>FirstItemClick(),
       // '/clickImage':(context)=>ClickImage(),
//-------------------CategoriesPageClicks----------------
        // '/baby':(context)=>BabyPage(),
     //  "/Abstract":(context)=>AbstractPage(),

      },

    );
  }
}
