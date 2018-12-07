import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../class/chatBarItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ChatWidget extends StatefulWidget {
 Color _color;
 ChatBarItem _item;

//  List<String> list = ['Rémi', 'Olivier', 'Aubry', 'Wandy','Kevin', 'Maxence', 'Florian', 'Hugo'];


 ChatBarItem get item => _item;
 Color get color => _color;

 ChatWidget(this._color, this._item);

  @override
  State<StatefulWidget> createState() {
    return new _ChatWidgetState();
  }
}

    // for(var i = 0; i < widget.list.length; i++){
    //   containers.add(
    //     new Container(
    //       height: 50.0,
    //       // color: Colors.red,
    //       child: new Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           Text(widget.list[i]),
    //           Container(
    //             height: 30.0,
    //             child: 
    //               FloatingActionButton(
    //               onPressed: () {
    //                 showDialog(context: context, child:
    //                   new AlertDialog(
    //                     title: new Text("MortMesC"),
    //                     content: new Text(widget.list[i]),
    //                   )
    //                 );
    //                 print(widget.list[i]);
    //               },
    //               tooltip: 'B',
    //               child: new Icon(
    //                 Icons.add
    //               ),
    //             ),
    //           )
    //         ],
    //       )
    //     )
    //   );
    // }

    // return containers;       
  // }

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _controller = new TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  _openAddFriendSnackbar() {
    return showModalBottomSheet(
      context: context,
      builder: (builder){
        return new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: new Container(
            color: Color.fromRGBO(33, 33, 33, 1.0),
            padding: new EdgeInsets.all(20.0),
            child: Center(
              child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  child: Text(
                    "Rechercher une personne",
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ), 
                ),
                Container(
                  child: Stack(
                      alignment: const Alignment(1.0, 1.0),
                      children: <Widget>[
                        new TextField(
                          // autofocus: true,
                          controller: _controller,
                          decoration: InputDecoration(
                            // helperText: "Saisissez un nom",
                            hintText: "Saisissez un nom",
                            prefixIcon: Icon(
                              Icons.account_box,
                              size: 28.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                              _controller.clear();
                            }),
                          )
                        )
                      ]
                  )
                ),
                Container(
                  margin:  EdgeInsets.only(top: 10.0),
                  height: 250.0,
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
                          itemCount: snapshot.data.documents.length,
                        );
                      }
                    },
                  ),
                ),
              ]
              ),
            ),
          )
        );
      }
    );
  }

  // Widget buildItem(BuildContext context, DocumentSnapshot document) {

  // }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document['id'] == 1) {
      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: new CircleAvatar(
                    backgroundImage: new NetworkImage(document['photoUrl'])
                ),
                // child: CachedNetworkImage(
                //   // placeholder: Container(
                //   //   child: CircularProgressIndicator(
                //   //     strokeWidth: 1.0,
                //   //     valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                //   //   ),
                //   //   width: 50.0,
                //   //   height: 50.0,
                //   //   padding: EdgeInsets.all(15.0),
                //   // ),
                //   // imageUrl: document['photoUrl'],
                //   // width: 50.0,
                //   // height: 50.0,
                //   // fit: BoxFit.cover,
                // ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              new Flexible(
                child: Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        child: Text(
                          'Nom: ${document['nickname']}',
                          style: TextStyle(color: Colors.black87),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      new Container(
                        child: Text(
                          'A propos: ${document['aboutMe'] ?? 'Not available'}',
                          style: TextStyle(color: Colors.black87),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
                    showDialog(context: context, child:
                      new AlertDialog(
                        title: new Text("MortMesC"),
                        content: new Text(document['nickname']),
                      )
                    );
            // Navigator.push(
            //     context,
            //     new MaterialPageRoute(
            //         // builder: 
            //         // (context) => new Chat(
            //         //       peerId: document.documentID,
            //         //       peerAvatar: document['photoUrl'],
            //         //     )
            //             ));
          },
          color: Colors.blueGrey,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              this.widget.item.name,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Scaffold.of(context).showBottomSheet(_openAddFriendSnackbar());

        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      backgroundColor: this.widget.color,
    );
  }
}