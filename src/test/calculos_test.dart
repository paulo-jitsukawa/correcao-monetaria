import 'package:correcao_monetaria/services/calculos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cálculos', () {
    test('Correção monetária.', () {
      final principal = 1000.0;
      final serie = [
        {'data': '01/01/2020', 'valor': '0.21'},
        {'data': '01/02/2020', 'valor': '0.25'},
        {'data': '01/03/2020', 'valor': '0.07'},
        {'data': '01/04/2020', 'valor': '-0.31'},
        {'data': '01/05/2020', 'valor': '-0.38'},
        {'data': '01/06/2020', 'valor': '0.26'},
        {'data': '01/07/2020', 'valor': '0.36'}
      ];
      final inicio = DateTime(2020, 2);
      final fim = DateTime(2020, 6);
      final result = Calculos().compute(principal, serie, inicio, fim);

      var corrigido = 1000 + 1000 * (0.25 / 100);
      corrigido += corrigido * (0.07 / 100);
      corrigido += corrigido * (-0.31 / 100);
      corrigido += corrigido * (-0.38 / 100);
      corrigido += corrigido * (0.26 / 100);

      final val =
      double.parse(result.corrigido.toString().replaceAll(',', '.'));

      expect(val, corrigido);
    });
  });
}
