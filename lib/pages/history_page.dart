import 'package:flutter/material.dart';
import '../model/parking.dart';
import 'details_page.dart';

class HistoryPage extends StatefulWidget {
  static const ROUTE_NAME = '/history';

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final _parkings = <Parking>[
    Parking(
      id: 1,
      observation: "Perto do mercado",
      data: DateTime.now(),
      latitude: -25.4284,
      longitude: -49.2733,
    ),
    Parking(
      id: 2,
      observation: "Shopping",
      data: DateTime.now(),
      latitude: -25.4300,
      longitude: -49.2700,
    ),
    Parking(
      id: 3,
      observation: "Faculdade",
      data: DateTime.now(),
      latitude: -25.4320,
      longitude: -49.2680,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Histórico"),
    );
  }

  Widget _body() {

    if (_parkings.isEmpty) {
      return const Center(
        child: Text("Nenhum estacionamento registrado"),
      );
    }

    return ListView.builder(
      itemCount: _parkings.length,
      itemBuilder: (context, index) {

        final parking = _parkings[index];

        return ListTile(
          leading: const Icon(Icons.local_parking),
          title: Text('${parking.id} - ${parking.observation}'),
          subtitle: Text(parking.data.toString()),
          trailing: const Icon(Icons.arrow_forward),

          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsPage.ROUTE_NAME,
              arguments: parking,
            );
          },
        );
      },
    );
  }
}