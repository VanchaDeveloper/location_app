import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationLoading());

  List<Marker> marker = [];

  void getCurrentLocation() async {
    LocationLoading();
    _determineCurrentLocation().then((value) async {
      addMarker(value.latitude, value.longitude);
      CameraPosition cameraPosition =
          addCameraPosition(value.latitude, value.longitude);
      emit(LocationSuccess(markers: marker, cameraPosition: cameraPosition));
    }).onError((error, stackTrace) {
      emit(LocationFailure());
    });
  }

  void addMarker(double lat, double long) {
    marker.add(
      Marker(
        markerId: const MarkerId("Current Location"),
        position: LatLng(lat, long),
        infoWindow:
            const InfoWindow(title: "My Current Location", snippet: '*'),
      ),
    );
    // return marker;
  }

  CameraPosition addCameraPosition(double lat, double long) {
    CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    return cameraPosition;
  }

  Future<Position> _determineCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void addSpecfiedMarker(LatLng newLocation) {
    marker.add(
      Marker(
        markerId: const MarkerId("Current Location"),
        position: newLocation,
        infoWindow: const InfoWindow(title: "Searched Location", snippet: '*'),
      ),
    );
  }

  CameraPosition addSpecifiedCameraPostion(LatLng newLocation) {
    CameraPosition location = CameraPosition(
        bearing: 192.8334901395799,
        target: newLocation,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    return location;
  }
}
