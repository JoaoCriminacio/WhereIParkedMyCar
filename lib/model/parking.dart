import 'package:intl/intl.dart';

class Parking {

  int? id;
  String observation;
  DateTime data;
  double latitude;
  double longitude;
  String? photoPath;

  Parking({
    this.id,
    required this.observation,
    required this.data,
    required this.latitude,
    required this.longitude,
    this.photoPath,
  });

  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(data);
  }
}