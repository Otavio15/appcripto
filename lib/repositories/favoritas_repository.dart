import 'dart:collection';

import 'package:appcripto/adapters/moeda_hive_adapter.dart';
import 'package:appcripto/models/moeda.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritasRepositories extends ChangeNotifier {
  List<Moeda> _lista = [];
  late LazyBox box;

  FavoritasRepositories() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(MoedaHiveAdapter());
    box = await Hive.openLazyBox<Moeda>("moedas_favoritas");
  }

  _readFavoritas() {
    box.keys.forEach((element) async {
      Moeda m = await box.get(element);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);

  saveAll(List<Moeda> moeda) {
    moeda.forEach((valor) {
      if (!_lista.any((atual) => atual.sigla == valor.sigla)) {
        _lista.add(valor);
        box.put(valor.sigla, valor);
      }
    });
    notifyListeners();
  }

  remove(Moeda m) {
    _lista.remove(m);
    box.delete(m.sigla);
    notifyListeners();
  }
}
