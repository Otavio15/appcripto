import 'package:flutter/material.dart';

import 'configuracoes_page.dart';
import 'favoritas_page.dart';
import 'moedas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtuual = 0;
  late PageController pc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pc = PageController(initialPage: paginaAtuual);
  }

  _setPaginaAtual(pagina) {
    setState(() {
      paginaAtuual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          MoedasPage(),
          FavoritasPage(),
          ConfiguracoesPage(),
        ],
        onPageChanged: _setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtuual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todas"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritas"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Conta"),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: Duration(microseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
