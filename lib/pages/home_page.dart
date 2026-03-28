import 'package:flutter/material.dart';
import 'package:where_i_parked_my_car/pages/register_page.dart';
import 'find_car_page.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Onde Estacionei Meu Carro?"),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Icon(
            Icons.directions_car,
            size: 100,
            color: Colors.blue,
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add_location),
              label: const Text("Salvar localização do carro"),
              onPressed: () {
                Navigator.pushNamed(context, RegisterPage.ROUTE_NAME)
                    .then((_) => setState(() {}));
              },
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.map),
              label: const Text("Ver carro estacionado"),
              onPressed: () {
                Navigator.pushNamed(context, FindCarPage.ROUTE_NAME)
                    .then((_) => setState(() {}));
              },
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text("Histórico"),
              onPressed: () {
                Navigator.pushNamed(context, HistoryPage.ROUTE_NAME);
              },
            ),
          ),
        ],
      ),
    );
  }
}