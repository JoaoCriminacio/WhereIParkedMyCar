import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/parking.dart';

class DetailsPage extends StatefulWidget {
  static const ROUTE_NAME = '/details';

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {

    final _parking = ModalRoute.of(context)!.settings.arguments as Parking?;

    return Scaffold(
      appBar: _appBar(),
      body: _body(_parking),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Detalhes do Estacionamento"),
    );
  }

  Widget _body(Parking? parking) {
    if (parking == null) {
      return const Center(
        child: Text("Erro ao carregar estacionamento"),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            SizedBox(
              height: 200,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: {
                  Marker(
                    markerId: const MarkerId("carro"),
                    position: LatLng(
                      parking.latitude,
                      parking.longitude,
                    ),
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    parking.latitude,
                    parking.longitude,
                  ),
                  zoom: 17,
                ),
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
      ),
    );
  }
}