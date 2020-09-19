class Variables {
  DateTime fim;
  DateTime inicio;
  int codigo;
  double principal;
  double corrigido;
  double correcao;
  double percentual;

  Variables(
    this.inicio,
    this.fim, {
    this.codigo = 433, // IPCA
    this.principal = 0.0,
    this.corrigido = 0.0,
    this.correcao = 0.0,
    this.percentual = 0.0,
  });
}
