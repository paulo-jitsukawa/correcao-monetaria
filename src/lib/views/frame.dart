import 'package:correcao_monetaria/components/menu.dart';
import 'package:correcao_monetaria/services/series.dart';
import 'package:correcao_monetaria/views/home.dart';
import 'package:flutter/material.dart';

import 'info.dart';

class Frame extends StatefulWidget {
  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  final _pageController = PageController();
  Future<Map<int, dynamic>> _future;

  Future<Map<int, dynamic>> fetch() async {
    final service = Series();

    var series = Map<int, dynamic>();

    await Future.forEach(service.indices, (indice) async {
      series[indice.codigo] = await service.fetch(indice);
    });

    return series;
  }

  @override
  void initState() {
    super.initState();
    _future = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, dynamic>>(
        future: _future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Material(
                type: MaterialType.transparency,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: const Text(
                      'Carregando dados...',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Material(
                  type: MaterialType.transparency,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Erro ao carregar dados.',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 20),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Verifique se sua conexão com a Internet está ativa.',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                                padding: EdgeInsets.all(15),
                                child: const Text(
                                  'Tentar Novamente',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                elevation: 5,
                                onPressed: () {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  setState(() {
                                    _future = fetch();
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Scaffold(
                      appBar: AppBar(
                        title: const Text('Calculadora'),
                        centerTitle: true,
                      ),
                      body: Home(snapshot.data),
                      drawer: Menu(_pageController),
                    ),
                    Scaffold(
                      appBar: AppBar(
                        title: const Text('Informações'),
                        centerTitle: true,
                      ),
                      body: Info(),
                      drawer: Menu(_pageController),
                    ),
                  ],
                );
              }
          }
        });
  }
}
