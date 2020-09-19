import 'package:correcao_monetaria/components/form_container.dart';
import 'package:correcao_monetaria/components/form_data_container.dart';
import 'package:correcao_monetaria/components/form_icon_container.dart';
import 'package:correcao_monetaria/models/result.dart';
import 'package:correcao_monetaria/models/variables.dart';
import 'package:correcao_monetaria/services/calculos.dart';
import 'package:correcao_monetaria/services/series.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Home extends StatefulWidget {
  final Map<int, dynamic> _series;

  Home(this._series);

  @override
  _HomeState createState() => _HomeState(this._series);
}

class _HomeState extends State<Home> {
  final Map<int, dynamic> _series;
  Result _result;

  final _indices = Series().indices;
  final _items = Series().getCodigos();

  var _enable = false;
  var _vars = Variables(
    DateTime(
      DateTime.now().year,
      DateTime.now().month - 2,
    ),
    DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
    ),
  );

  _HomeState(this._series);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FormIconContainer(
            'Índice de inflação',
            Icons.arrow_downward,
            DropdownButton<int>(
              iconSize: 0.0,
              value: _vars.codigo,
              elevation: 16,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              underline: Container(
                height: 0,
                color: Colors.white,
              ),
              onChanged: (int newValue) {
                setState(() {
                  _vars.codigo = newValue;
                  _result = null;
                });
              },
              items: _items.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(_indices
                      .firstWhere((indice) => indice.codigo == value)
                      .nome),
                );
              }).toList(),
            ),
          ),
          FormDataContainer('Mês inicial', Icons.calendar_today,
              _buildMonthText(_vars.inicio), () {
            showMonthPicker(
              context: context,
              initialDate: _vars.inicio,
              // Data em que o Real entrou nos índices de inflação
              firstDate: DateTime(1994, 7),
              lastDate: _vars.fim,
              locale: Locale("pt"),
            ).then((date) {
              if (date != null) {
                setState(() {
                  _vars.inicio = date;
                  _result = null;
                });
              }
            });
          }),
          FormDataContainer(
              'Mês final', Icons.calendar_today, _buildMonthText(_vars.fim),
              () {
            showMonthPicker(
              context: context,
              initialDate: _vars.fim,
              firstDate: _vars.inicio,
              lastDate: DateTime(
                DateTime.now().year,
                DateTime.now().month - 1,
              ),
              locale: Locale("pt"),
            ).then((date) {
              if (date != null) {
                setState(() {
                  _vars.fim = date;
                  _result = null;
                });
              }
            });
          }),
          FormContainer(
            'Valor a ser corrigido',
            TextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
              style: TextStyle(fontWeight: FontWeight.bold),
              onChanged: (value) {
                value = value.replaceAll(',', '.');
                var val = double.tryParse(value);
                setState(() {
                  final valid = val != null && val > 0;
                  _enable = valid;
                  if (valid) {
                    _vars.principal = val;
                    _vars.corrigido = val;
                  }
                  _result = null;
                });
              },
              decoration: InputDecoration(
                prefixText: 'R\$ ',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: const Text(
                'CORRIGIR VALOR',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              elevation: 5,
              onPressed: _enable
                  ? () {
                      FocusManager.instance.primaryFocus.unfocus();
                      setState(() {
                        _result = Calculos().compute(
                          _vars.principal,
                          _series[_vars.codigo],
                          _vars.inicio,
                          _vars.fim,
                        );
                      });
                    }
                  : null,
            ),
          ),
          _result == null
              ? Container()
              : FormContainer(
                  'Resultado',
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Índice de correção no período: ' + _result.correcao,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Valor percentual correspondente: ' +
                              _result.percentual +
                              '%',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Valor corrigido na data final: R\$ ' +
                              _result.corrigido,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Text _buildMonthText(DateTime date) => Text(
        date.month == 1
            ? 'Janeiro de ${date.year}'
            : date.month == 2
                ? 'Fevereiro de ${date.year}'
                : date.month == 3
                    ? 'Março de ${date.year}'
                    : date.month == 4
                        ? 'Abril de ${date.year}'
                        : date.month == 5
                            ? 'Maio de ${date.year}'
                            : date.month == 6
                                ? 'Junho de ${date.year}'
                                : date.month == 7
                                    ? 'Julho de ${date.year}'
                                    : date.month == 8
                                        ? 'Agosto de ${date.year}'
                                        : date.month == 9
                                            ? 'Setembro de ${date.year}'
                                            : date.month == 10
                                                ? 'Outubro de ${date.year}'
                                                : date.month == 11
                                                    ? 'Novembro de ${date.year}'
                                                    : 'Dezembro de ${date.year}',
        style: TextStyle(fontWeight: FontWeight.bold),
      );
}
