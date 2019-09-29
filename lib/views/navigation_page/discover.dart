import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_music/modole/play_list.dart';
import 'package:my_music/modole/song.dart';
import 'package:my_music/utils/http_utils.dart';
import 'package:my_music/views/play.dart';
import 'package:my_music/widgets/avatar.dart';

class Discover extends StatefulWidget {
  Discover({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DiscoverState();
  }
}

class _DiscoverState extends State<Discover>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Songs.songs.length == 0) {
      initPlayList();
    }

    if (Songs.songs.length > 0) {
      isLoading = false;
    }
  }

  void initPlayList() async {
    await HttpUtils.getInstance().initSongs();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text('歌单'),
        ),
        body: new Container(
          child: isLoading
              ? new Center(
                  child: new CircularProgressIndicator(),
                )
              : new ListView.separated(
                  itemCount: Songs.songs.length,
//                  cacheExtent: 20.0,
                  itemBuilder: (context, i) {
                    return Column(
                      children: <Widget>[
                        new ListTile(
                          dense: true,
                          leading: new Hero(
                              tag: Songs.songs[i].id,
                              child: avatar(context, Songs.songs[i].picUrl,
                                  Songs.songs[i].subName)),
                          title: Text(
                            Songs.songs[i].name,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          subtitle: Text(
                            Songs.songs[i].subName,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                          trailing: Text(
                              new Duration(milliseconds: Songs.songs[i].size)
                                  .toString()
                                  .split('.')
                                  .first,
                              style: new TextStyle(
                                  fontSize: 12.0, color: Colors.grey)),
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => PlayMusic(i)));
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1.0,
                    );
                  },
                ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
