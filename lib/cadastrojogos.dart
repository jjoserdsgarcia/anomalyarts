import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Cadastrojogos extends StatefulWidget {
  const Cadastrojogos({super.key});

  @override
  State<Cadastrojogos> createState() => _CadastrojogosState();
}

class _CadastrojogosState extends State<Cadastrojogos> {
  final _formKey = GlobalKey<FormState>();
  final _nomeJogoController = TextEditingController();
  final _precoController = TextEditingController();
  final _anoController = TextEditingController();
  final _urlController = TextEditingController();
  var categoriaSelecionada = 'Cate1';

  bool ehNumero(String numero) {
    return double.tryParse(numero) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nomeJogoController,
              decoration: InputDecoration(
                labelText: 'Título',
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
              controller: _precoController,
              decoration: InputDecoration(
                labelText: 'Preço',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Valor obrigatório';
                } else if (!ehNumero(value)) {
                  return 'Somente números podem ser usados.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _anoController,
              decoration: InputDecoration(
                labelText: 'Ano de Lançamento',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Valor obrigatório';
                } else if (!ehNumero(value)) {
                  return 'Somente números podem ser usados.';
                } else if (value.length != 4) {
                  return 'Digite um ano válido.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Imagem (URL)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Valor obrigatório';
                }
                return null;
              },
            ),
            RadioGroup<String>(
              groupValue: categoriaSelecionada,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    categoriaSelecionada = value;
                  });
                }
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Cate1'),
                      Radio.adaptive(value: '1'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Cate2'),
                      Radio.adaptive(value: '2'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Cate3'),
                      Radio.adaptive(value: '3'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Cate4'),
                      Radio.adaptive(value: '4'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Cate5'),
                      Radio.adaptive(value: '5'),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final supabase = Supabase.instance.client;
                    await supabase.from('games').insert({
                      'nome_jogo': _nomeJogoController.text,
                      'preco': _precoController.text,
                      'ano_lancamento': _anoController.text,
                      'url_images': _urlController.text,
                      'categoria': categoriaSelecionada,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cadastro realizado com sucesso!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cadastro realizado com NÃO SUCESSO!"),

                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                      ),
                    );
                  }
                }
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
