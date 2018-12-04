
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../widgets/chat_widget.dart';
import '../class/chatBarItem.dart';



class MainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      return _MainHome();
  }
}

class _MainHome extends State<MainHome> {
  int _currentIndex = 0;
  // List<ChatBarItem> _items = [
  //   ChatBarItem('Amis', Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons'))),
  //   ChatBarItem('Groupes', Icon(CupertinoIcons.book))
  // ];
  
  List<ChatWidget> _children = [
    ChatWidget(Colors.green, ChatBarItem('Amis', Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons')), 0)),
    ChatWidget(Colors.red, ChatBarItem('Groupes', Icon(CupertinoIcons.book), 0)),
  ];

void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
  
  Widget build(BuildContext context) {
   return Scaffold(
     body: _children[_currentIndex], // new
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped,
       currentIndex: _currentIndex, // new
       items: [
        BottomNavigationBarItem(
          icon: this._children[0].item.icon,
          title: Text(this._children[0].item.name),
        ),
        BottomNavigationBarItem(
          icon: this._children[0].item.icon,
          title: Text(this._children[1].item.name),
        )
       ],
     ),
      backgroundColor: Color.fromRGBO(33, 33, 33, 1.0),
      // activeColor: Color.fromRGBO(100, 255, 218, 1.0),
      // inactiveColor: Colors.white,
   );
  }
}

