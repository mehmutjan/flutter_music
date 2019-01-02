import 'package:flutter/material.dart';
import 'package:my_music/views/home.dart';
import 'package:my_music/i18n/music_strings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class _MusicLocalizationsDelegate extends LocalizationsDelegate<MusicStrings> {
  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == "zh" || locale.languageCode == "en";
  }

  @override
  Future<MusicStrings> load(Locale locale) {
    return MusicStrings.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<MusicStrings> old) {
    return false;
  }
}

class MusicApp extends StatefulWidget {
  MusicApp({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    return new _MusicAppState();
  }
}

class _MusicAppState extends State<MusicApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme.of(context).platform,
      ),
      title: '音乐',
      home: new HomePage(),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        _MusicLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const <Locale>[
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
    );
  }
}