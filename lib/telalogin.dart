import 'package:anomalyarts/paginainicial.dart';
import 'package:anomalyarts/paginainicialadmin.dart';
import 'package:anomalyarts/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final supabase = Supabase.instance.client;
                  final usuarios = await supabase
                      .from('login')
                      .select()
                      .eq('usuario', _loginController)
                      .eq('senha', Utils.gerarMd5(_senhaController.text));
                  if (usuarios.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuário ou Senha incorretos.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuário autenticado com sucesso.'),
                        backgroundColor: const Color.fromARGB(
                          255,
                          63,
                          130,
                          255,
                        ),
                      ),
                    );
                    if (usuarios.first['is_adm']) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return TelaInicialAdmin();
                          },
                        ),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return Paginainicial();
                          },
                        ),
                      );
                    }
                  }
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
