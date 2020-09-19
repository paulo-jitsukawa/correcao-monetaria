class Result {
  double _corrigido;
  double _correcao;
  double _percentual;

  Result(this._corrigido, this._correcao, this._percentual);

  get corrigido => _corrigido.toString().replaceAll('.', ',');
  get correcao => _correcao.toString().replaceAll('.', ',');
  get percentual => _percentual.toString().replaceAll('.', ',');
}
