abstract class MapEvent {}

class LocationUpdated extends MapEvent {
  final double latitude;
  final double longitude;
  LocationUpdated(this.latitude, this.longitude);
}
