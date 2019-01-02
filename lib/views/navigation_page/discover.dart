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

class _DiscoverState extends State<Discover> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initPlayList();
  }

  void initPlayList() async {
    await HttpUtils.getInstance().initSongs();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              : new ListView.builder(
                  itemCount: Songs.songs.length,
                  addRepaintBoundaries: false,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Column(
                          children: <Widget>[
                            new Divider(
                              height: 2.0,
                            ),
                            new ListTile(
                              dense: true,
                              leading: new Hero(
                                  tag: Songs.songs[i].id,
                                  child: avatar(
                                      context,
                                      Songs.songs[i].picUrl,
                                      Songs.songs[i].subName)),
                              title: Text(
                                Songs.songs[i].name,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              subtitle: Text(
                                Songs.songs[i].subName,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              ),
                              trailing: Text(
                                  new Duration(
                                          milliseconds:
                                          Songs.songs[i].size)
                                      .toString()
                                      .split('.')
                                      .first,
                                  style: new TextStyle(
                                      fontSize: 12.0, color: Colors.grey)),
                              onTap: () {
                                Navigator.of(context)
                                    .push(new MaterialPageRoute(builder: (context) => PlayMusic( i)));
                              },
                            ),
                          ],
                        );
                  },
                ),
        ));
  }
}
