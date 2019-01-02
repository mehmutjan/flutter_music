import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _NavigationState();
  }
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 1;
  final _widgetOptions = [
    Text('Index 0: Home'),
    Text('Index 1: mine'),
    Text('Index 2: School'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(icon: Icon(Icons.music_note), title: Text('发现')),
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('我的')),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('账号')),
      ],
      currentIndex: _selectedIndex,
      fixedColor: Colors.purple,
      onTap: _onItemTapped,
    );
  }
}