import 'package:flutter/material.dart';

class FindCarPage extends StatefulWidget {
  static const ROUTE_NAME = '/car';

  @override
  _FindCarPageState createState() => _FindCarPageState();
}

class _FindCarPageState extends State<FindCarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Localização do Carro"),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Text("Mapa com marcador do carro"),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[200],
            child: const Center(
              child: Text("Foto do local"),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Observação: Perto do mercado",
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.navigation),
              label: const Text("Navegar até o carro"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}