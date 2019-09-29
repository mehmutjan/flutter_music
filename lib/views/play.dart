import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_music/modole/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class PlayMusic extends StatefulWidget {
  int index;

  PlayMusic(this.index);

  @override
  State<StatefulWidget> createState() {
    return _PlayMusicState();
  }
}

class _PlayMusicState extends State<PlayMusic>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  String url;
  bool isLocal = false;
  bool isNext = false;
  bool isPrevious = false;
  AudioPlayer _audioPlayer;
  Duration _duration;
  Duration _position;
  int _index;

  get _isPlaying => Songs.playerState == PlayerState.playing;

  get _isPaused => Songs.playerState == PlayerState.paused;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '0:00:00';

  get _positionText => _position?.toString()?.split('.')?.first ?? '0:00:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _index = Songs.index = widget.index;
    url = Songs.songs[_index]?.uri ?? '';

    if (_audioPlayer == null) {
      _audioPlayer = Songs.audioPlayer;
    }

    _audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    _audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });

    _audioPlayer.completionHandler = () {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    };

    _audioPlayer.errorHandler = (msg) {
      print('audioPlayer error : $msg');
      setState(() {
        Songs.playerState = PlayerState.stopped;
        _duration = new Duration(seconds: 0);
        _position = new Duration(seconds: 0);
      });
    };
    _play();
  }

  Future<int> _play() async {
    if (Songs.songs[_index]?.uri == null) {
      scaffoldState.currentState?.showSnackBar(new SnackBar(
          content:
              Text("《${Songs.songs[_index]?.name}》 music cannot play!!!")));
      if (isNext) {
        _skipNext();
      }
      if (isPrevious) {
        _skipPrevious();
      }
      return 0;
    }
    final result = await _audioPlayer.play(Songs.songs[_index]?.uri ?? '',
        isLocal: isLocal, stayAwake: true);
    if (result == 1) setState(() => Songs.playerState = PlayerState.playing);
    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => Songs.playerState = PlayerState.paused);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        Songs.playerState = PlayerState.stopped;
        _position = new Duration();
      });
    }
    return result;
  }

  _skipPrevious() async {
    isNext = false;
    isPrevious = true;
    _stop();
    setState(() {
      if (_index == 0) {
        _index = Songs.songs.length - 1;
      } else {
        _index -= 1;
      }
      Songs.index = _index;
      _audioPlayer.setUrl(Songs.songs[_index].uri);
      _play();
    });
  }

  _skipNext() async {
    isNext = true;
    isPrevious = false;
    _stop();
    setState(() {
      if (_index == Songs.songs.length - 1) {
        _index = 0;
      } else {
        _index += 1;
      }
      Songs.index = _index;
      _audioPlayer.setUrl(Songs.songs[_index].uri);
      _play();
    });
  }

  void _onComplete() {
    setState(() => Songs.playerState = PlayerState.stopped);
    _skipNext();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: CachedNetworkImageProvider(Songs.songs[_index].picUrl)),
      ),
      child: Container(
        color: Color(0xF571777D),
        child: Scaffold(
          key: scaffoldState,
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              AppBar(
                elevation: 0.0,
                backgroundColor: Color(0x0000000),
                centerTitle: true,
                title: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(Songs.songs[_index].title,
                          style: TextStyle(fontSize: 20.0)),
                      Text(
                        Songs.songs[_index].album,
                        style: TextStyle(fontSize: 12.0, color: Colors.white70),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
              ),
              Container(
                padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/diezi.png'),
                  ),
                ),
                child: Container(
                  child: Center(
                    child: ClipOval(
                      child: Image(
                        width: 200.0,
                        height: 200.0,
                        image: CachedNetworkImageProvider(
                            Songs.songs[_index].picUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: ListTile(
                  leading: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        _position != null
                            ? '${_positionText ?? ''}'
                            : _duration != null ? _durationText : '',
                        style: new TextStyle(fontSize: 12.0),
                      )),
                  title: new Stack(
                    children: <Widget>[
                      LinearProgressIndicator(
                        value: 0.5,
                        valueColor: AlwaysStoppedAnimation(Colors.grey),
                      ),
                      LinearProgressIndicator(
                        value: _position != null && _position.inMilliseconds > 0
                            ? _position.inMilliseconds /
                                _duration.inMilliseconds
                            : 0.0,
                        valueColor: AlwaysStoppedAnimation(Colors.purple),
                      ),
                    ],
                  ),
                  trailing: Text(
                    _position != null
                        ? ' ${_durationText ?? ''}'
                        : _duration != null ? _durationText : '',
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: BottomAppBar(
              elevation: 0.0,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.repeat, color: Colors.white),
                    iconSize: 35.0,
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_previous, color: Colors.white),
                    iconSize: 35.0,
                    onPressed: () => _skipPrevious(),
                  ),
                  IconButton(
                    icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline,
                        color: Colors.white),
                    iconSize: 50.0,
                    onPressed: _isPlaying ? () => _pause() : () => _play(),
                    splashColor: Colors.transparent,
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next, color: Colors.white),
                    iconSize: 35.0,
                    onPressed: () => _skipNext(),
                    splashColor: Colors.transparent,
                  ),
                  IconButton(
                    icon: Icon(Icons.playlist_play, color: Colors.white),
                    iconSize: 35.0,
                    onPressed: null,
                    splashColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
