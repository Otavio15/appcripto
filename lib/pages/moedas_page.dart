import 'package:appcripto/config/app_settings.dart';
import 'package:appcripto/models/moeda.dart';
import 'package:appcripto/repositories/favoritas_repository.dart';
import 'package:appcripto/repositories/moeda_repository.dart';
import 'package:provider/provider.dart';
import 'moedas_detalhes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;

  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> selecionadas = [];

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['local'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['local'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['local'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text("Usar $locale"),
            onTap: () {
              context.read<AppSettings>().setLocale(locale, name);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  late FavoritasRepositories favoritas;
  _mostrarDetalhes(Moeda moeda) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => MoedasDetalhes(moeda)));
  }

  _setQuantidadeList(int index) {
    setState(() {
      selecionadas.contains(tabela[index])
          ? selecionadas.remove(tabela[index])
          : selecionadas.add(tabela[index]);
    });
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Center(
          child: Text("Cripto Moedas"),
        ),
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Center(
          child: Text("${selecionadas.length} Selecionadas"),
        ),
      );
    }
  }

  _limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    favoritas = Provider.of<FavoritasRepositories>(context);
    readNumberFormat();
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemCount: tabela.length,
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: selecionadas.contains(tabela[index])
                ? CircleAvatar(child: Icon(Icons.check))
                : Image.asset(tabela[index].icone, width: 40),
            title: Row(
              children: [
                Text(
                  tabela[index].nome,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favoritas.lista
                    .any((element) => element.sigla == tabela[index].sigla))
                  Icon(Icons.star, color: Colors.amber, size: 15),
              ],
            ),
            trailing: Text(
              real.format(tabela[index].preco),
            ),
            selected: selecionadas.contains(tabela[index]),
            selectedTileColor: Colors.indigo[50],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            onLongPress: () {
              _setQuantidadeList(index);
            },
            onTap: () {
              selecionadas.length > 0
                  ? _setQuantidadeList(index)
                  : _mostrarDetalhes(tabela[index]);
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (selecionadas.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                _limparSelecionadas();
              },
              icon: Icon(Icons.star),
              label: Text(
                "FAVORITAR",
                style: TextStyle(letterSpacing: 0, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }
}
