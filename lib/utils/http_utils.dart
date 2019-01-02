import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:my_music/api/api.dart';
import 'package:my_music/modole/play_list.dart';
import 'package:my_music/modole/song.dart';

class HttpUtils {
  HttpUtils();

  static HttpUtils instance;
  static const String BASE_URL = 'https://music.163.com';
  Map<String, String> headers = {};

  static HttpUtils getInstance() {
    instance = new HttpUtils();
    instance.headers.clear();
    return instance;
  }

  Future<Response> postHttpClient(String url, Map<String, String> body) {
    http.Client httpClient = new http.Client();
    return httpClient.post(url,
        body: body, headers: headers, encoding: Encoding.getByName('utf-8'));
  }

  HttpUtils addTokenHeader(String name, String value) {
    headers[name] = value;
    return this;
  }

  HttpUtils addTokenHeaders(Map<String, String> heads) {
    headers.addAll(heads);
    return this;
  }

  Future<PlayList> getPlayList() async {
    PlayList playList;
    Map<String, String> headers = {
      "Content-Type": 'application/x-www-form-urlencoded',
      'Accept': '*/*',
    };
    Map<String, String> body = {
      'params':
          's05dNjQFY2vxMTiywQ6RQHrTghmXaTRQZ/H+Q+DVGoVf1WrcGNsHL3sw0EG37+HvgPpzKFxYMHOkXsodwziPj90QsGgGS1sxCJtPgcseWmzE8KbMVaHh9+BOpVD7L4q/0SayIO+jC3Ed2Cjix5TBBWKkhzlECnYnq6qtA7NIt5OBEcylFQbC31EzFKE0KvVrhx+0NttLtQSiDDM2dpZA1V91rMTH/SZbfj+r46D3k8Q=',
      'encSecKey':
          '534953b76fd0dd61a2de19dd5bc18fbf57f7c9143140b4f984a766a0b71b16dec0e4daa6c11bb151cdf9f0b7dc2a7c1fc7a34f9dda96cfb463bca9eb4b09b923a369906cffc3f6fc503e4f5f107e7a92df52ac140ea7e5cdebb11ffcb717d16bef3912498e515c247d53ef6de4c104821fb9f0db59b4d26ebbb6578cb78dc4fd',
    };
    http.Client httpClient = new http.Client();
    await httpClient
        .post(Api.PLAY_LIST_DETAIL, body: body, headers: headers, encoding: Encoding.getByName('utf-8'))
        .whenComplete(() {
          httpClient.close();
        }).then((http.Response r) {
      playList = PlayList.fromJson(json.decode(r.body));
    });
    return playList;
  }

  Future<List<Song>> getSongDetail(List<TrackIds> ids) async {
    List<Song> songs = new List();
    String strIds = parseUriIds(ids);
    String url = Api.SONG_DETAIL + "?ids=$strIds";
    http.Client httpClient = new http.Client();
    await httpClient
        .get(url)
        .whenComplete(() {
      httpClient.close();
    }).then((http.Response r) {
      Map<String, dynamic> lists = json.decode(r.body);
      lists['songs'].forEach((list) {
        Song song = Song.fromJson(list);
        songs.add(song);
      });
    });
    return songs;
  }

  Future<Map> getSongUri(List<TrackIds> ids) async {
    var uriList = new Map();
    String strIds = parseUriIds(ids);
    String url = Api.SONG_URL + "?ids=$strIds&br=999000";
    http.Client httpClient = new http.Client();
    await httpClient
        .get(url)
        .whenComplete(() {
      httpClient.close();
    }).then((http.Response r) {
      Map<String, dynamic> lists = json.decode(r.body);
      lists['data'].forEach((i) {
        uriList[i['id']] = i['url'];
      });
    });
    return uriList;
  }

  Future<Songs> initSongs() async {
    PlayList playList;
    List<Song> songs;
    Map uriList;

    playList = await getPlayList();
    songs = await getSongDetail(playList.mTrackIds);
    uriList = await getSongUri(playList.mTrackIds);
    songs.forEach((song) {
      song.uri = uriList[song.id];
    });
    Songs.songs = songs;
    return Songs();
  }

  String parseUriIds(List<TrackIds> ids) {
    String str = "[";
    ids.forEach((id) {
      str += "${id.id},";
    });
    str = str.substring(0, str.length -2);
    return str + "]";
  }
}
