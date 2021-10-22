import 'package:appcripto/pages/moedas_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: MoedasPage(),
        title: 'Moedabase',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
