import 'package:flutter/material.dart';
import 'package:where_i_parked_my_car/dao/parking_dao.dart';
import '../model/parking.dart';
import 'details_page.dart';

class HistoryPage extends StatefulWidget {
  static const ROUTE_NAME = '/history';

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final _parkings = <Parking>[];
  final _dao = ParkingDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getRecords();
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
          subtitle: Text(parking.formattedDate),
          trailing: const Icon(Icons.arrow_forward),

          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsPage.ROUTE_NAME,
              arguments: parking,
            );

            _getRecords();
          },
        );
      },
    );
  }

  void _getRecords() async {
    final parkings = await _dao.list();
    setState(() {
      _parkings.clear();
      _parkings.addAll(parkings);
    });
  }
}