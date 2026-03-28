import 'package:flutter/material.dart';
import 'package:where_i_parked_my_car/model/parking.dart';
import '../dao/parking_dao.dart';

class FindCarPage extends StatefulWidget {
  static const ROUTE_NAME = '/car';

  @override
  _FindCarPageState createState() => _FindCarPageState();
}

class _FindCarPageState extends State<FindCarPage> {

  Parking? _parking = null;
  final _dao = ParkingDao();

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

  @override
  void initState() {
    super.initState();
    _getLastOne();
  }

  Widget _body() {

    if (_parking == null) {
      return const Center(
        child: Text("Nenhum estacionamento ativo"),
      );
    }

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

          Text(
            _parking!.observation,
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

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text("Finalizar"),
              onPressed: _finish,
            ),
          ),
        ],
      ),
    );
  }

  void _getLastOne() async {
    final parking = await _dao.getLastOne();

    setState(() {
      _parking = parking;
    });
  }

  void _finish() async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Finalizar estacionamento"),
        content: const Text("Você já encontrou o carro?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Sim"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _dao.finish(_parking!);

      Navigator.pop(context);
    }
  }
}