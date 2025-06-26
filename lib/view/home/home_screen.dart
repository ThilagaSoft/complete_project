import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_pro/bloc/location/map_bloc.dart';
import 'package:map_pro/bloc/location/map_state.dart';
import 'package:map_pro/core/theme/app_color.dart';
import 'package:map_pro/view/widgets/common_appBar.dart';
import 'package:map_pro/view/widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget
{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()
     async {
        return false;
      },
      child: Scaffold(
        appBar: CommonAppBar(title: "Welcome",),
        drawer: CommonDrawer(
          onHomeTap: ()
          {
            Navigator.pushNamed(context, '/lang');
          },
          onProfileTap: ()
          {
          },
          onLogoutTap: ()
          {
          },
          headerColor: AppColors.primary,
          title: "Hello, User!",
        ),
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state.currentLocation == null) {
              return Center(child: CircularProgressIndicator());
            }

            return FlutterMap(
              options: MapOptions(
                initialCameraFit: CameraFit.bounds(
                  bounds: LatLngBounds.fromPoints(state.rectangleBounds),
                  padding: EdgeInsets.all(20),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: [...state.rectangleBounds, state.rectangleBounds.first],
                      borderColor: Colors.blue,
                      borderStrokeWidth: 2,
                      color: Colors.blue.withOpacity(0.2),
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: state.currentLocation!,
                      width: 40,
                      height: 40,
                      child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                    ...state.nearbyPonds.map((pond) => Marker(
                      point: pond,
                      width: 30,
                      height: 30,
                      child: Icon(Icons.water_drop, color: Colors.blue, size: 30),
                    )),
                    ...state.nearbyTemples.map((temple) => Marker(
                      point: temple,
                      width: 30,
                      height: 30,
                      child: Icon(Icons.temple_hindu, color: Colors.orange, size: 30),
                    )),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
