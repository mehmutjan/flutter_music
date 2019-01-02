import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget avatar(context, String src, String title) {
  return new Material(
//    borderRadius: new BorderRadius.(30.0),
    elevation: 2.0,
    child: src != null
        ? new CircleAvatar(
            backgroundColor: Colors.white,
            child: Image(image: CachedNetworkImageProvider(src)),
          )
        : new CircleAvatar(
            backgroundColor: Theme.of(context).cardColor,
            child: new Text(title[0].toUpperCase()),
          ),
  );
}
