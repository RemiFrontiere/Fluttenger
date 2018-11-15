import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsFragment extends StatefulWidget {

  Function callbackPref;
  Function callbackPaintSize;
  SettingsFragment(this.callbackPref, this.callbackPaintSize);

  @override
  _SettingsFragment createState() => new _SettingsFragment();
}

class _SettingsFragment extends State<SettingsFragment> {

  bool paintSizeValue;
  bool perfValue;

  @override
  void initState() {
      super.initState();
      this.perfValue = false;
      this.paintSizeValue = false;
      this.updateValue();
  }

  void updateValue() async{
    final prefs = await SharedPreferences.getInstance();
    
    setState(() {
      if(prefs != null && prefs.getBool('showPerf') != null)
        this.perfValue = prefs.getBool('showPerf');
      if(prefs != null && prefs.getBool('showPaintSize') != null)
        this.paintSizeValue = prefs.getBool('showPaintSize');
    });
  }

  void updateShowPerf(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showPerf', value);
    this.perfValue = value;
    this.widget.callbackPref(value);
  }

  void updateShowPaintSize(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showPaintSize', value);
    this.paintSizeValue = value;
    this.widget.callbackPaintSize(value);
  }

  bool getPerf(){
    if(this.perfValue)
      return this.perfValue;
    else
      return false; 
  }

    bool getPaint(){
    if(this.paintSizeValue)
      return this.paintSizeValue;
    else
      return false; 
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(child: settings(context));
  }


  Widget settings(BuildContext context) {
    return new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
              "Afficher les performances",
                style: new TextStyle(fontSize:20.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto")
              ),
              new Switch(onChanged: updateShowPerf, value: getPerf())
            ],
          ),
          Row(
            children: <Widget>[
              new Text(
              "Afficher les layouts",
                style: new TextStyle(fontSize:20.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto")
              ),
              new Switch(onChanged: updateShowPaintSize, value:getPaint())
            ]
          ),
        ],
    );
  }
}



