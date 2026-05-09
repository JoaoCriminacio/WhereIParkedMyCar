import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../dao/parking_dao.dart';
import '../model/parking.dart';

class RegisterPage extends StatefulWidget {
  static const ROUTE_NAME = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController observacaoController = TextEditingController();
  final _dao = ParkingDao();
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

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
    if (_currentPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          SizedBox(
            height: 250,
            width: double.infinity,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: const MarkerId("carro"),
                  position: LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude
                  ),
                ),
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude
                ),
                zoom: 17,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
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
              onPressed: _save,
              child: const Text("Salvar localização"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await _isLocationServiceEnabled();

    if (!serviceEnabled) return;

    bool permissionGranted = await _isPermissionGranted();

    if (!permissionGranted) return;

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _currentPosition = LatLng(
        position.latitude,
        position.longitude,
      );
    });
  }

  Future<bool> _isPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        _showMessage("Permissão de localização negada",);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showDialogMessage(
        "Para usar este recurso, habilite a permissão de localização nas configurações do aplicativo",
      );

      await Geolocator.openAppSettings();

      return false;
    }

    return true;
  }

  Future<bool> _isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await _showDialogMessage(
        "Para utilizar este recurso, você deverá habilitar o serviço de localização do disposito",
      );

      await Geolocator.openLocationSettings();

      return false;
    }

    return true;
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  Future<void> _showDialogMessage(String msg) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Atenção"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  void _save() async {
    if (observacaoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Digite uma observação")),
      );
      return;
    }

    final newParking = Parking(
      id: null,
      observation: observacaoController.text,
      data: DateTime.now(),
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
      isActive: true
    );

    await _dao.save(newParking);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Estacionamento salvo com sucesso!"),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }
}