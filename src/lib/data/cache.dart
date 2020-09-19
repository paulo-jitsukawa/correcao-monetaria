import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as dir;

class Cache {
  int _indice;
  File _file;

  Cache(this._indice);

  Future<File> _getFile() async {
    if (_file == null) {
      final directory = await dir.getApplicationDocumentsDirectory();
      final path = join(directory.path, '$_indice.json');
      _file = File(path);
    }
    return _file;
  }

  Future<String> read(String data) async {
    var file = await _getFile();
    final serie = await file.readAsString();
    return serie.lastIndexOf(data) > 0 ? serie : null;
  }

  void write(String serie) async {
    var file = await _getFile();
    file.writeAsStringSync(serie);
  }

  void clean() async {
    var file = await _getFile();
    file.deleteSync();
  }
}
