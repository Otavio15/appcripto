import 'package:appcripto/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';

class MoedasPage extends StatelessWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepository.tabela;

    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("Cripto Moedas"),
      )),
      body: ListView.separated(
        itemCount: tabela.length,
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(tabela[index].icone),
            title: Text(tabela[index].nome),
            trailing: Text(tabela[index].preco.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
