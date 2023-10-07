import 'package:flutter/material.dart';
import 'package:revolvair/presentation/views/home/home_viewmodel.dart';
import 'package:revolvair/presentation/views/home/drawer_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                      title: const Text("Revolvair"),
                    ),
                    drawer: DrawerWidget(homeViewModel: viewModel),
                    body: Column(children: [
                      Expanded(
                        child: Stack(
                          children: [
                              FlutterMap(
                                mapController: mapController,
                                options: MapOptions(
                                    center: LatLng(viewModel.stations[0].lat,
                                        viewModel.stations[0].long),
                                    zoom: 15,
                                    keepAlive: true,
                                    onPositionChanged:
                                        (MapPosition pos, bool hasGesture) {
                                      if (hasGesture) {
                                        viewModel.disablePosition();
                                      }
                                    }),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName: 'com.example.app',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      ...viewModel.stations.map((station) {
                                        return Marker(
                                          point:
                                              LatLng(station.lat, station.long),
                                          width: 80,
                                          height: 80,
                                          builder: (context) => const Icon(
                                            IconData(0xe4c9,
                                                fontFamily: 'MaterialIcons'),
                                            size: 45.0,
                                            color: Colors.blue,
                                          ),
                                        );
                                      }).toList(),
                                      if (viewModel.currentPos != null &&
                                          viewModel.showPosition)
                                        Marker(
                                          point: LatLng(
                                              viewModel.currentPos!.latitude,
                                              viewModel.currentPos!.longitude),
                                          width: 80,
                                          height: 80,
                                          builder: (context) => const Icon(
                                            // Icon Location Marker
                                            IconData(0xe061,
                                                fontFamily: 'MaterialIcons'),
                                            size: 30.0,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: FloatingActionButton(
                                onPressed: () {
                                  if (viewModel.showPosition) {
                                    viewModel.disablePosition();
                                  } else {
                                    viewModel.enablePosition();
                                    mapController.move(
                                        LatLng(
                                            viewModel.currentPos != null
                                                ? viewModel.currentPos!.latitude
                                                : viewModel.stations[0].lat,
                                            viewModel.currentPos != null
                                                ? viewModel
                                                    .currentPos!.longitude
                                                : viewModel.stations[0].long),
                                        15);
                                  }
                                  if (!viewModel.locationServiceEnabled) {
                                    viewModel.requestLocationPermission();
                                  }
                                },
                                backgroundColor: Colors.transparent,
                                child: !viewModel.locationServiceEnabled
                                    // Icon location disabled
                                    ? const Icon(IconData(0xe3a9,
                                        fontFamily: 'MaterialIcons'))
                                    : viewModel.showPosition &&
                                            viewModel.locationServiceEnabled
                                        // Icon location Enable and Active
                                        ? const Icon(IconData(0xe2dc,
                                            fontFamily: 'MaterialIcons'))
                                        // Icon location Enable and Inactive
                                        : const Icon(IconData(0xe3ad,
                                            fontFamily: 'MaterialIcons')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])));
      },
    );
  }
}
