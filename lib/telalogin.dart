import 'package:flutter/material.dart';

class Telalogin extends StatefulWidget {
  const Telalogin({super.key});

  @override
  State<Telalogin> createState() => _TelaloginState();
}

class _TelaloginState extends State<Telalogin> {
  final _formKey = GlobalKey<FormState>();
  final _senhaController = TextEditingController();
  final _loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _loginController,
              decoration: InputDecoration(
                labelText: 'Login',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Valor obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Valor obrigatório';
                } else if (value.length < 8 || value.length > 20) {
                  return 'A senha precisa ter no mínimo 8 caractéres e no máximo 20.';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // :)
                }
              },
              child: Text('Logar'),
            ),
          ],
        ),
      ),
    );
  }
}
