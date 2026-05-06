import 'package:flutter/material.dart';
import 'package:appbar_animated/appbar_animated.dart';

class Paginainicial extends StatefulWidget {
  const Paginainicial({super.key});

  @override
  State<Paginainicial> createState() => _PaginainicialState();
}

class _PaginainicialState extends State<Paginainicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anomaly Arts')),
      body: const Center(child: Text('Bem-vindo à Página Inicial!')),
    );
  }
}
