import 'package:flutter/material.dart';

class NewClient extends StatefulWidget {
  @override
  State<NewClient> createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Cliente')),
      body: Center(child: Text('Formulário para novo cliente aqui')),
    );
  }
}
