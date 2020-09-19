import 'dart:convert';
import 'package:correcao_monetaria/data/bacen.dart';
import 'package:correcao_monetaria/data/cache.dart';
import 'package:correcao_monetaria/models/indice.dart';

class Series {
  // Singleton
  static final Series _instance = Series.internal();
  factory Series() => _instance;
  Series.internal() {
    _indices = _bacen.indices;
  }

  final _bacen = Bacen();

  List<Indice> _indices;
  List<Indice> get indices => _indices;

  List<int> getCodigos() {
    var idx = List<int>();
    _indices.forEach((indice) => idx.add(indice.codigo));
    return idx;
  }

  Future<dynamic> fetch(Indice indice) async {
    final cache = Cache(indice.codigo);
    final date = _bacen.getNextDate();

    // Tenta obter a série da cache se sua data de atualização for válida
    try {
      final serie = await cache.read(date);
      if (serie != null) {
        return json.decode(serie);
      }
    } on Exception {}

    final txt = await _bacen.getData(indice);

    // Tenta salvar a série atualizada na cache
    try {
      cache.write(txt);
    } on Exception {}

    return json.decode(txt);
  }
}
