import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const ROUTE_NAME = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController observacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Registrar Estacionamento"),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Text("Mapa aparecerá aqui"),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text("Tirar Foto"),
              onPressed: () {},
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: observacaoController,
            decoration: const InputDecoration(
              labelText: "Observação",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text("Salvar localização"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}