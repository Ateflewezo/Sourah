import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                //------------------home----------
                ListTile(
                  onTap: () {
                    Navigator.of(context)..pop()..pushNamed("/homepage");
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
                    Navigator.of(context)..pop()..pushNamed("/latest");
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
                    Navigator.of(context)..pop()..pushNamed("/popular");
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
                //----------------rated------------
                SizedBox(
                  height: 7,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)..pop()..pushNamed('/rated');
                  },
                  title: Text(
                    "تقيم",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.rate_review,
                    color: Colors.white,
                  ),
                ),
                //-----------------categories--------------
                SizedBox(
                  height: 7,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)..pop()..pushNamed("/categories");
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
                    Navigator.of(context)..pop()..pushNamed("/Gif");
                  },
                  title: Text(
                    "صور متحركة",
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
            Navigator.of(context)..pop()..pushNamed("/favourite");
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
                    Navigator.of(context)..pop()..pushNamed('/profile');
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
                    Navigator.of(context)..pop()..pushNamed("/setting");
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
                    Navigator.of(context)..pop()..pushNamed("/singin");
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
    );
  }
}
