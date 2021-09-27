import 'dart:io';

import 'package:path/path.dart' as path;

/// 脚本运行路径
Uri get shellPath {
  if (_shellPath == null) {
    // windows下需要这样获取
    if (Platform.isWindows) {
      var _path = Process.runSync(
        "chdir",
        [],
        runInShell: true,
      ).stdout.replaceAll('\r\n', '');
      _shellPath = path.toUri(_path);
    } else {
      _shellPath = Uri.parse(path.join(Platform.environment['PWD']));
    }
  }
  return _shellPath;
}
Uri _shellPath;
