import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<LocationUpdated>(_onLocationUpdated);
  }

  Future<void> _onLocationUpdated(LocationUpdated event, Emitter<MapState> emit) async {
    final center = LatLng(event.latitude, event.longitude);
    final rectangle = _generateRectangle(center, 2000);

    final ponds = await _fetchNearby(center, 'natural=water');
    final temples = await _fetchNearby(center, 'amenity=place_of_worship');

    emit(state.copyWith(
      currentLocation: center,
      rectangleBounds: rectangle,
      nearbyPonds: ponds,
      nearbyTemples: temples,
    ));
  }

  Future<List<LatLng>> _fetchNearby(LatLng center, String tag) async {
    try {
      final url = Uri.parse(
          'https://overpass-api.de/api/interpreter?data=[out:json];'
              '('
              'node(around:1000,${center.latitude},${center.longitude})[$tag];'
              'way(around:1000,${center.latitude},${center.longitude})[$tag];'
              'relation(around:1000,${center.latitude},${center.longitude})[$tag];'
              ');'
              'out center;'
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final elements = data['elements'] as List;
        return elements.map((e) {
          if (e['type'] == 'node') {
            return LatLng(e['lat'], e['lon']);
          } else if (e['center'] != null) {
            return LatLng(e['center']['lat'], e['center']['lon']);
          } else {
            return null;
          }
        }).whereType<LatLng>().toList();
      } else {
        print('Overpass API error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Fetch nearby error: $e');
      return [];
    }
  }

  void startLocationUpdates() async {
    final permission = await _handlePermission();
    if (!permission) return;

    Geolocator.getPositionStream().listen((pos) {
      add(LocationUpdated(pos.latitude, pos.longitude));
    });
  }

  Future<bool> _handlePermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    if (permission == LocationPermission.deniedForever) return false;
    return true;
  }

  List<LatLng> _generateRectangle(LatLng center, double meters) {
    final d = Distance();
    final half = meters / 2;
    return [
      d.offset(center, half, 45),
      d.offset(center, half, 135),
      d.offset(center, half, 225),
      d.offset(center, half, 315),
    ];
  }
}
