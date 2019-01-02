# my_music

musicplayer

## 配置程序图标 

	//引入依赖
    dev_dependencies:
      ...
      flutter_launcher_icons: "^0.6.1"
      
    //在根目录新建icon文件夹
    flutter_icons:
      image_path: "icon/icon.png"
      android: true
      ios: true
    
    //执行命令
    flutter pub pub run flutter_launcher_icons:main


## Regenerating the i18n files

   这个目录中的文件基于`../lib/music_strings.dart`它定义了所有可本地化的字符串使用的musics应用程序 [Dart `intl` package](https://github.com/dart-lang/intl).

重建一切需要两个步骤。

使用 `examples/musics` 作为当前目录, 生成
`intl_messages.arb` from `lib/music_strings.dart`:

```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/music_strings.dart
```
`intl_messages.arb`文件是一个 json 格式映射, 其中有一个条目
在 `music_strings.dart` 中定义的每个 `Intl.message()` 功能。这文件被用来创建英语和西班牙语本地化,`musics_en.arb` 和 `musics_es.arb`。`intl_messages.arb` 签入存储库, 因为它仅用作
另一个 `.arb` 文件

以 `examples/musics` 为当前目录, 生成 `music_messages_<locale>.dart` 为每个`musics_<locale>.arb` 文件和 `music_messages_all.dart`, 它导入所有的消息文件：

	1.intl_messages.arb 为基础新建 musics_zh.arb 和 musics_en.arb 文件

```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n --generated-file-prefix=music_ --no-use-deferred-loading lib/i18n/music_strings.dart lib/i18n/music_*.arb 
```

`musicStrings` 类使用生成的 `initializeMessages()` function(`music_messages_all.dart`) 来加载本地化的消息和 `Intl.message()` 来查找它们。
