import 'package:audioplayers/audioplayers.dart';

enum PlayerState { stopped, playing, paused }

class Songs {
  static List<Song> songs;
  static Song song; // current playing song
  static int index; // current playing song index
//  static MusicFinder player = new MusicFinder();
  static AudioPlayer audioPlayer = new AudioPlayer();
  static PlayerState playerState = PlayerState.stopped;

}

class Song {
  int id;
  String artist;
  String title;
  String album;
  int albumId;
  int duration;
  String uri;
  String albumArt;
  int count;
  int isNav;
  List<String> columns;

  String name;
  int size = 0;
  String subName;
  String picUrl;

  Song(this.id, this.artist, this.title, this.album, this.albumId,
      this.duration, this.uri, this.albumArt);

  Song.toMap(Map m) {
    id = m["id"];
    artist = m["artist"];
    title = m["title"];
    album = m["album"];
    albumId = m["albumId"];
    duration = m["duration"];
    uri = m["uri"];
    albumArt = m["albumArt"];
  }

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = name =  json['name'];
    album = subName = json['album']['name'];
    albumId = json['album']['id'];
    picUrl = json['album']['picUrl'];
    artist = json['artists'][0]['name'];
  }
}
