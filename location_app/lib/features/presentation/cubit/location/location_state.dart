part of 'location_cubit.dart';

abstract class LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<Marker> markers;
  final CameraPosition cameraPosition;
  LocationSuccess({required this.markers, required this.cameraPosition});
}

class LocationFailure extends LocationState {}
