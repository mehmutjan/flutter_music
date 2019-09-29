import 'package:flutter/material.dart';
import 'package:my_music/modole/song.dart';
import 'package:my_music/utils/http_utils.dart';
import 'package:my_music/views/navigation_page/account.dart';
import 'package:my_music/views/navigation_page/discover.dart';
import 'package:my_music/views/navigation_page/mine.dart';
import 'package:my_music/views/play.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initSongs();
  }

  initSongs() async {
    await HttpUtils.getInstance().initSongs();
    setState(() {
      _isLoading = false;
    });
  }

  final _widgetOptions = [
    new Discover(),
    new Mine(),
    new Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    Songs.audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: new Scaffold(
          body: _widgetOptions[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_music), title: Text('发现')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('我的')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), title: Text('账号')),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.purple,
            onTap: _onItemTapped,
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Songs.playerState == PlayerState.paused
                      ? Icon(Icons.play_circle_outline)
                      : Icon(Icons.pause_circle_outline),
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => PlayMusic(Songs.index ?? 0)));
                    }),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('music player will be stopped..'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                ),
              ),
              new FlatButton(
                onPressed: () {
                  Songs.audioPlayer.stop();
                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
