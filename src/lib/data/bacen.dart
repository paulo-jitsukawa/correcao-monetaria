import 'package:correcao_monetaria/models/indice.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Bacen {
  final _formatter = DateFormat('dd/MM/yyyy');

  String getNextDate() {
    final now = DateTime.now();
    final past = DateTime(now.year, now.month - 1);
    final next = _formatter.format(past);
    return next;
  }

  Future<String> getData(Indice indice) async {
    final now = DateTime.now();
    final fim = _formatter.format(now);

    try {
      final response = await http
          .get('http://api.bcb.gov.br/dados/serie/bcdata.sgs.${indice.codigo}'
              '/dados?formato=json&dataInicial=01/07/1994&dataFinal=$fim');

      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception {}
    return null;
  }

  get indices => [
        Indice(
          189,
          'IGPM',
          'IGP-M: Índice Geral de Preços do Mercado',
        ),
        Indice(
          188,
          'INPC',
          'INPC: Índice Nacional de Preços ao Consumidor',
        ),
        Indice(
          433,
          'IPCA',
          'IPCA: Índice Nacional de Preços ao Consumidor Amplo',
        ),
      ];
}
