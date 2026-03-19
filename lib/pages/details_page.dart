import 'package:flutter/material.dart';
import '../model/parking.dart';

class DetailsPage extends StatefulWidget {
  static const ROUTE_NAME = '/details';

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {

    final parking = ModalRoute.of(context)!.settings.arguments as Parking;

    return Scaffold(
      appBar: _appBar(),
      body: _body(parking),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Detalhes do Estacionamento"),
    );
  }

  Widget _body(Parking parking) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Text("Mapa"),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Text("Foto do local"),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Observação: ${parking.observation}",
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 10),

          Text(
            "Data: ${parking.formattedDate}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}