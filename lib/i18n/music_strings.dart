import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'music_messages_all.dart';

class MusicStrings {
  MusicStrings(Locale locale) : _localeName = locale.toString();

  final String _localeName;

  static Future<MusicStrings> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then<MusicStrings>((Object _) {
      Intl.defaultLocale = localeName;
      return MusicStrings(locale);
    });
  }

  static MusicStrings of(BuildContext context) {
    return Localizations.of<MusicStrings>(context, MusicStrings);
  }

  String appTitle() {
    return Intl.message(
        'Music App',
        name: 'appTitle',
        desc: 'Label for the App tab',
        locale: _localeName
    );
  }

  String homeAppBarTitle() {
    return Intl.message(
        'Music Demo',
        name: 'homeAppBarTitle',
        desc: '',
        locale: _localeName
    );
  }
}
