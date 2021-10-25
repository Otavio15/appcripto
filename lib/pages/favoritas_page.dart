import 'package:appcripto/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'moedas_detalhes_page.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({Key? key}) : super(key: key);

  @override
  _FavoritasPageState createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  final real = NumberFormat.currency(locale: 'pt_BR', name: "R\$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Moedas Favoritas")),
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12),
        child: Consumer<FavoritasRepositories>(
          builder: (context, favoritas, child) {
            return favoritas.lista.isEmpty
                ? ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Ainha não há moedas favoritas"),
                  )
                : ListView.builder(
                    itemCount: favoritas.lista.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MoedasDetalhes(favoritas.lista[index])));
                        },
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Image.asset(
                                        favoritas.lista[index].icone,
                                        height: 35,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          favoritas.lista[index].nome,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          favoritas.lista[index].sigla,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 35,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.indigo.shade100),
                                          color: Colors.blue.withOpacity(0.08)),
                                      child: Text(
                                        real.format(
                                            favoritas.lista[index].preco),
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    PopupMenuButton(
                                      icon: Icon(Icons.more_vert),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: ListTile(
                                            title:
                                                Text("Remover dos favoritos"),
                                            onTap: () {
                                              Navigator.pop(context);
                                              Provider.of<FavoritasRepositories>(
                                                      context,
                                                      listen: false)
                                                  .remove(
                                                      favoritas.lista[index]);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
