
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';


class MainHome extends StatefulWidget {
  @override
  _MainHome createState() => new _MainHome();
}

class _MainHome extends State<MainHome> {
  static const IconData group = IconData(0xe7ef, fontFamily: 'MaterialIcons');

  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(group),
          title: Text('Amis'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book),
          title: Text('Groupes'),
        )
      ],
      backgroundColor: Color.fromRGBO(33, 33, 33, 1.0),
      activeColor: Color.fromRGBO(100, 255, 218, 1.0),
      inactiveColor: Colors.white,
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
            new Text(
              "Afficher les layouts",
                style: new TextStyle(fontSize:20.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto")
              );
        } else if (index == 1) {
            new Text(
              "Afficher les layouts",
                style: new TextStyle(fontSize:20.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto")
              );
        } else if (index == 2) {
          // return SearchScreen();
        } else {
          // return SettingsScreen();
        }
      },
      
    );
  }
}
