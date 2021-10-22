import 'package:appcripto/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
        icone: "images/bitcoin.png",
        nome: "Bitcoin",
        sigla: "BTC",
        preco: 300.000),
    Moeda(
        icone: "images/etherum.png",
        nome: "Etherum",
        sigla: "ETH",
        preco: 9.716),
    Moeda(icone: "images/xrp.png", nome: "XRP", sigla: "XRP", preco: 3.340),
    Moeda(
        icone: "images/cardano.png",
        nome: "Cardano",
        sigla: "ADA",
        preco: 300.000),
    Moeda(
        icone: "images/ltc.png",
        nome: "USD Coin",
        sigla: "LTC",
        preco: 300.000),
    Moeda(
        icone: "images/litecoin.png", nome: "XRP", sigla: "XRP", preco: 3.340),
  ];
}
