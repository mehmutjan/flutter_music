
class PlayList {
  List<Tracks> mTracks = new List();
  List<TrackIds> mTrackIds = new List();
  int code;

  PlayList(this.mTracks, this.mTrackIds, this.code);

  PlayList.fromJson(Map<String, dynamic> json) {
    List<dynamic> tra = json['playlist']['tracks'];
    List<dynamic> traIds = json['playlist']['trackIds'];
    tra.forEach((t) {
      Tracks tracks = Tracks.fromJson(t);
      mTracks.add(tracks);
    });

    traIds.forEach((id) {
      TrackIds trackIds = TrackIds.fromJson(id);
      mTrackIds.add(trackIds);
    });
    code = json['code'];
  }
}

class Tracks {
  int id;
  String name;
  int size;
  String subName;
  String picUrl;

  Tracks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    Map<String, dynamic> h = json['h'];
    size = h != null  ? h['size'] : 0;
    subName = json['al']['name'];
    picUrl = json['al']['picUrl'];
  }
}

class TrackIds {
  final int id;

  TrackIds(this.id);

  TrackIds.fromJson(Map<String, dynamic> json) : id = json['id'];
}
