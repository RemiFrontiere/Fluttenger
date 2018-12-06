import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../class/chatBarItem.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatWidget extends StatefulWidget {
 Color _color;
 ChatBarItem _item;

 List<String> list = ['Rémi', 'Olivier', 'Aubry', 'Wandy','Kevin', 'Maxence', 'Florian', 'Hugo'];


 ChatBarItem get item => _item;
 Color get color => _color;

 ChatWidget(this._color, this._item);

  @override
  State<StatefulWidget> createState() {
    return new _ChatWidgetState();
  }
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _controller = new TextEditingController();  
  
  @override
  void initState() {
    super.initState();
  }

  
  List<Container> _getUsersList(){

    List<Container> containers = new List<Container>();

    for(var i = 0; i < widget.list.length; i++){
      containers.add(
        new Container(
          height: 50.0,
          // color: Colors.red,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.list[i]),
              Container(
                height: 30.0,
                child: 
                  FloatingActionButton(
                  onPressed: () {
                    showDialog(context: context, child:
                      new AlertDialog(
                        title: new Text("MortMesC"),
                        content: new Text(widget.list[i]),
                      )
                    );
                    print(widget.list[i]);
                  },
                  tooltip: 'B',
                  child: new Icon(
                    Icons.add
                  ),
                ),
              )
            ],
          )
        )
      );
    }

    return containers;       
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
                  child: ListView(children: _getUsersList()),
                ),
              ]
              ),
            ),
          )
        );
      }
    );
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