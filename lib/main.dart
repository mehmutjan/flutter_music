import 'package:flutter/material.dart';
import 'package:my_music/app.dart';
//import 'package:permission_handler/permission_handler.dart';

void main() {
//  requestPermission();
  runApp(MusicApp());
}
//void main() => runApp(MusicApp());

//Future requestPermission() async {
//  // 申请权限
//
//  Map<PermissionGroup, PermissionStatus> permissions =
//      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
//
//  // 申请结果
//
//  PermissionStatus permission =
//      await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
//
//  if (permission == PermissionStatus.granted) {
//    print('权限申请通过');
//  } else {
//    print('权限申请被拒绝');
//  }
//}
