import 'package:correcao_monetaria/models/result.dart';
import 'package:intl/intl.dart';

class Calculos {
  // Singleton
  static final Calculos _instance = Calculos.internal();
  factory Calculos() => _instance;
  Calculos.internal();

  final _formatter = DateFormat('01/MM/yyyy');

  Result compute(
    double principal,
    List<dynamic> serie,
    DateTime inicio,
    DateTime fim,
  ) {
    final begin = _formatter.format(inicio);
    final end = _formatter.format(fim);

    var sum = principal;
    var step = 0;

    for (int i = 0; i < serie.length; i++) {
      final date = serie[i]['data'];
      if (date == begin || date == end) {
        step++;
      }

      if (step > 0) {
        final value = double.parse(serie[i]['valor']);
        sum += sum * (value / 100);

        if (step > 1) {
          break;
        }
      }
    }

    final corrigido = sum;
    final correcao = corrigido / principal;
    final percentual = correcao * 100 - 100;

    return Result(corrigido, correcao, percentual);
  }
}
