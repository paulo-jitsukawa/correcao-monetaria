import 'package:correcao_monetaria/components/form_container.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          FormContainer(
            'Objetivo',
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Correção Monetária realiza a correção de um valor em relação a inflação ocorrida em um determinado período.\n\n'
                      'Os seguintes índices são suportados pelo aplicativo:\n\n'
                      '- Índice Geral de Preços do Mercado (IGP-M) da Fundação Getúlio Vargas (FGV);\n\n'
                      '- Índice Nacional de Preços ao Consumidor (INPC) do Instituto Brasileiro de Geografia e Estatística (IBGE);\n\n'
                      '- Índice Nacional de Preços ao Consumidor-Amplo (IPCA) do Instituto Brasileiro de Geografia e Estatística (IBGE).\n\n'
                      'O período suportado compreende qualquer intervalo de tempo em que a moeda corrente é o Real (a partir de julho de 1994).'),
                ],
              ),
            ),
          ),
          FormContainer(
            'Funcionamento',
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'O cálculo é realizado sobre o principal com a aplicação iterativa de uma série histórica de um índice de inflação mensal.'
                      ' As séries de IGPM, INPC e IPCA são obtidas do webservice público do Banco Central do Brasil.'
                      ' Elas são armazenadas localmente e atualizadas quando novos dados forem publicados pela instituição.'),
                ],
              ),
            ),
          ),
          FormContainer(
            'Detalhes',
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Versão:  1.0.0\n\n'
                      'Ano:  2020\n\n'
                      'Desenvolvedor:  Paulo Masaru Meneghel Jitsukawa'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
