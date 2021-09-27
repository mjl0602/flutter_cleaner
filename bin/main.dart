import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'utils/shellPath.dart';

late ArgResults argResults;

main(List<String> args) {
  var argParser = ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: "查看指令帮助",
    )
    ..addFlag(
      'all',
      abbr: 'a',
      negatable: false,
      help: "全部清理",
    );

  /// 解析输入
  argResults = argParser.parse(args);

  /// 输入help或者没有输入任何参数
  if (argResults['help'] || argResults.arguments.length == 0) {
    print('命令帮助');
    print('${argParser.usage}');
    return 1;
  }

  var list = Directory.fromUri(shellPath).listSync(recursive: true);
  for (var item in list) {
    if (item is File && path.basename(item.path) == 'pubspec.yaml') {
      var directoryName = path.basename(item.parent.path);
      print("Target: $directoryName");
      print("Cleaning...");
      var res = Process.runSync(
        "flutter",
        ["clean"],
        runInShell: true,
        workingDirectory: item.parent.path,
      ).stdout.replaceAll('\r\n', '');
      print('Clean End: $res');
    }
  }
}
