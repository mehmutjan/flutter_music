import 'package:flutter/material.dart';
import 'package:my_music/i18n/music_strings.dart';

class Mine extends StatefulWidget {
  Mine({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MineState();
  }
}

class _MineState extends State<Mine> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(MusicStrings.of(context).homeAppBarTitle()),
      ),
      body: new Center(
        child: Text('此页面一片空白'),
      ),
    );
  }
}
