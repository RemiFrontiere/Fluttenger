import './pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './fragments/third_fragment.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './widgets/google_sign_in_btn.dart';
import './class/userDetail.dart';

void main() => runApp(new MyApp());


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new UserOptions(), // Default or main screen of the app
//     );
//   }
// }
class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => new _MyApp();
}

class _MyApp extends State<MyApp> {
  bool showPerf;
  bool paintSizeActivated;
  
  @override
  void initState() {
      super.initState();
      this.showPerf = false;
  }

  void callbackPerf(bool value) {
    setState(() {
      this.showPerf = value;
    });
  }
  void callbackPaintSize(bool value) {
    setState(() {
      this.paintSizeActivated = value;
      debugPaintSizeEnabled=value;
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fluttenger',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      showPerformanceOverlay: showPerf,
      home: UserOptions(this.callbackPerf, this.callbackPaintSize),
      // home: new HomePage(this.callbackPerf, this.callbackPaintSize),
    );
  }
}


class UserOptions extends StatefulWidget {

  Function callbackPerfHP;
  Function callbackPaintSizeHP;
  UserOptions(this.callbackPerfHP, this.callbackPaintSizeHP);

  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final GoogleSignIn _gSignIn = new GoogleSignIn();


  void callbackPerf(bool value) {
    this.widget.callbackPerfHP(value);
  }
  void callbackPaintSize(bool value) {
    this.widget.callbackPaintSizeHP(value);
  }
  void callbackLogout() {
    this._signOut();
  }
  

  Future<FirebaseUser> _signIn(BuildContext context) async {

    GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();
    GoogleSignInAuthentication authentication =
        await googleSignInAccount.authentication;




    FirebaseUser user = await _fAuth.signInWithGoogle(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    UserInfoDetails userInfo = new UserInfoDetails(
        user.providerId, user.displayName, user.email, user.photoUrl, user.uid);

    List<UserInfoDetails> providerData = new List<UserInfoDetails>();
    providerData.add(userInfo);

    UserDetails details = new UserDetails(
        user.providerId,
        user.uid,
        user.displayName,
        user.photoUrl,
        user.email,
        user.isAnonymous,
        user.isEmailVerified,
        providerData);

    print("User Name : ${user.displayName}");
    
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new HomePage(this.callbackPerf, this.callbackPaintSize, this.callbackLogout, details),
      ),
    );
    return user;
  }

  void _signOut() {
    _gSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final String userName = "Aseem";

    return new MyInhWidget(
        userName: userName,
        child: new Scaffold(
          //backgroundColor: Colors.blueGrey,
          body: new Center(
              child: new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Builder(
                  builder: (BuildContext context) {
                    return new Material(
                      borderRadius: new BorderRadius.circular(30.0),
                      child: new Material(
                        elevation: 5.0,
                        child: GoogleSignInButton(
                          onPressed: () => _signIn(context)
                              .then((FirebaseUser user) => print(user))
                              .catchError((e) => print(e))
                        )
                      ),
                    );
                  },
                ),
                // new Builder(
                //   builder: (BuildContext context) {
                //     return new Material(
                //       borderRadius: new BorderRadius.circular(30.0),
                //       child: new Material(
                //         elevation: 5.0,
                //         child: new MaterialButton(
                //           minWidth: 150.0,
                //           onPressed: () => _signOut(context),
                //           child: new Text('Sign Out'),
                //           color: Colors.lightBlueAccent,
                //         ),
                //       ),
                //     );
                //   },
                // )
              ],
            ),
          )),
        ));
  }
}

class MyInhWidget extends InheritedWidget {
  const MyInhWidget({Key key, this.userName, Widget child})
      : super(key: key, child: child);

  final String userName;

  //const MyInhWidget(userName, Widget child) : super(child: child);

  @override
  bool updateShouldNotify(MyInhWidget old) {
    return userName != old.userName;
  }

  static MyInhWidget of(BuildContext context) {
    // You could also just directly return the name here
    // as there's only one field
    return context.inheritFromWidgetOfExactType(MyInhWidget);
  }
}
