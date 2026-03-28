import 'package:intl/intl.dart';

class Parking {
  static const TABLE_NAME = 'parking_lots';
  static const FIELD_ID = '_id';
  static const FIELD_OBSERVATION = 'observation';
  static const FIELD_DATA = 'data';
  static const FIELD_LATITUDE = 'latitude';
  static const FIELD_LONGITUDE = 'longitude';
  static const FIELD_PHOTO_PATH = 'photo_path';
  static const FIELD_IS_ACTIVE = 'is_active';

  int? id;
  String observation;
  DateTime data;
  double latitude;
  double longitude;
  String? photoPath;
  bool isActive;

  Parking({
    this.id,
    required this.observation,
    required this.data,
    required this.latitude,
    required this.longitude,
    this.photoPath,
    this.isActive = true,
  });

  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  Map<String, dynamic> toMap() => <String, dynamic> {
    FIELD_ID: id,
    FIELD_OBSERVATION: observation,
    FIELD_DATA: DateFormat('yyyy-MM-dd').format(data),
    FIELD_LATITUDE: latitude,
    FIELD_LONGITUDE: longitude,
    FIELD_PHOTO_PATH: photoPath,
    FIELD_IS_ACTIVE: isActive ? 1 : 0,
  };

  factory Parking.fromMap(Map<String, dynamic> map) => Parking(
      id: map[FIELD_ID] is int ? map[FIELD_ID] : null,
      observation: map[FIELD_OBSERVATION] is String ? map[FIELD_OBSERVATION] : '',
      data: map[FIELD_DATA] is String ? DateFormat('yyyy-MM-dd').parse(map[FIELD_DATA]) : DateTime.now(),
      latitude: map[FIELD_LATITUDE] is double ? map[FIELD_LATITUDE] : 0.0,
      longitude: map[FIELD_LONGITUDE] is double ? map[FIELD_LONGITUDE] : 0.0,
      photoPath: map[FIELD_PHOTO_PATH] is String ? map[FIELD_PHOTO_PATH] : '',
      isActive: map[FIELD_IS_ACTIVE] == 1,
  );
}