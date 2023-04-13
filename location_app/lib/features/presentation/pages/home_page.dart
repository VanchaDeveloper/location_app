import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:location_app/features/presentation/cubit/location/location_cubit.dart';
import 'package:location_app/features/presentation/widgets/common.dart';
import 'package:location_app/features/presentation/widgets/theme/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();

  LatLng searchedLocation = const LatLng(37.42796133580664, -122.085749655962);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationCubit>(context).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location App"),
        actions: [
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            child: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              color: color747480.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _latController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                hintText: 'Enter Latitude',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                if (_longController.text.isNotEmpty) {
                  searchedLocation = LatLng(double.parse(_latController.text),
                      double.parse(_longController.text));
                  _goToTheSpecifiedLocation(searchedLocation);
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              color: color747480.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _longController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                hintText: 'Enter Longitude',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                if (_latController.text.isNotEmpty) {
                  searchedLocation = LatLng(double.parse(_latController.text),
                      double.parse(_longController.text));
                  _goToTheSpecifiedLocation(searchedLocation);
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationLoading) {
                  return loadingIndicatorProgressBar();
                } else if (state is LocationSuccess) {
                  return GoogleMap(
                    mapType: MapType.hybrid,
                    markers: Set<Marker>.of(state.markers),
                    initialCameraPosition: state.cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Location permissions are denied"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheSpecifiedLocation(LatLng newLocation) async {
    BlocProvider.of<LocationCubit>(context).addSpecfiedMarker(newLocation);
    CameraPosition location = BlocProvider.of<LocationCubit>(context)
        .addSpecifiedCameraPostion(newLocation);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(location));
  }
}
