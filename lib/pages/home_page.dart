import '../fragments/first_fragment.dart';
import '../fragments/third_fragment.dart';
import 'package:flutter/material.dart';
import '../class/userDetail.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {

  Function callbackPerfHP;
  Function callbackPaintSizeHP;
  Function callbackLogoutHP;
  UserDetails userDetails;

  HomePage(this.callbackPerfHP, this.callbackPaintSizeHP, this.callbackLogoutHP, this.userDetails);


  final drawerItems = [
    new DrawerItem("Chat", Icons.chat_bubble),
    new DrawerItem("Paramètres", Icons.settings),
    new DrawerItem("Déconnection", Icons.power_settings_new)

  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  String myProfilePic = "https://plus.google.com/u/0/photos/113994502080936909684/albums/profile/6536153061168109314?iso=false";


    @override
    void initState() {
      super.initState();
      print("User Name :" + widget.userDetails.displayName);
    }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MainHome();
      case 1:
        return new SettingsFragment(this.callbackPerf, this.callbackPaintSize);
      case 2:
        // Scaffold.of(context).showSnackBar(new SnackBar(
        //   content: new Text('Déconnection réussite'),
        // ));
        Navigator.pop(context);
        this.widget.callbackLogoutHP();
        break;

      default:
        return new Text("Error");
    }
  }

  void callbackPerf(bool value) {
    this.widget.callbackPerfHP(value);
  }
  void callbackPaintSize(bool value) {
    this.widget.callbackPaintSizeHP(value);
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountEmail: new Text(widget.userDetails.email),
                accountName: new Text(widget.userDetails.displayName),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(widget.userDetails.photoUrl)
                  ),
                  onTap: () => print("This is your current account."),
                )
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
