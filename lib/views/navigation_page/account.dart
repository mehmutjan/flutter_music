import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
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
        title: Text('我'),
      ),
      body: new Center(
        child: Text('此页面一片空白'),
      ),
    );
  }
}
