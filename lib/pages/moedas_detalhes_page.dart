import 'package:appcripto/models/moeda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoedasDetalhes extends StatefulWidget {
  Moeda moeda;

  MoedasDetalhes(this.moeda);

  @override
  _MoedasDetalhesState createState() => _MoedasDetalhesState();
}

class _MoedasDetalhesState extends State<MoedasDetalhes> {
  NumberFormat real = NumberFormat.currency(locale: "pt_BR", name: "R\$");

  final _key = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double _valorMoeda = 0.0;

  _comprar() {
    if (_key.currentState!.validate()) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Compra realizada com sucesso!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.moeda.nome)),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.moeda.icone,
                  width: 50,
                ),
                SizedBox(width: 20),
                Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800]),
                )
              ],
            ),
            SizedBox(height: 10),
            (_valorMoeda > 0)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: Text(
                        "${widget.moeda.sigla}:    ${_valorMoeda}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.05),
                    ),
                  )
                : SizedBox(
                    height: 42,
                  ),
            SizedBox(height: 15),
            Form(
              key: _key,
              child: TextFormField(
                controller: _valor,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Valor R\$",
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    "Reais",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (valor) {
                  if (valor!.isEmpty) {
                    return "Informe o valor da compra";
                  } else if (double.parse(valor) < 50) {
                    return "Compra minima tem que ser menor que R\$50";
                  }
                  return null;
                },
                onChanged: (valor) {
                  setState(() {
                    _valorMoeda = (valor.isEmpty)
                        ? 0
                        : double.parse(valor) / widget.moeda.preco;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: () {
                  _comprar();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Comprar",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
