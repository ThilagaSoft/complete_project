import 'package:latlong2/latlong.dart';

class MapState {
  final LatLng? currentLocation;
  final List<LatLng> rectangleBounds;
  final List<LatLng> nearbyPonds;
  final List<LatLng> nearbyTemples;

  MapState({
    this.currentLocation,
    this.rectangleBounds = const [],
    this.nearbyPonds = const [],
    this.nearbyTemples = const [],
  });

  MapState copyWith({
    LatLng? currentLocation,
    List<LatLng>? rectangleBounds,
    List<LatLng>? nearbyPonds,
    List<LatLng>? nearbyTemples,
  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      rectangleBounds: rectangleBounds ?? this.rectangleBounds,
      nearbyPonds: nearbyPonds ?? this.nearbyPonds,
      nearbyTemples: nearbyTemples ?? this.nearbyTemples,
    );
  }
}
