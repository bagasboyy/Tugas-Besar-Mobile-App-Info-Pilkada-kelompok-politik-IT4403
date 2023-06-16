import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(LokasiKPUPage());
}

class LokasiKPUPage extends StatelessWidget {
  LokasiKPUPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lokasi KPU'),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(
                minZoom: 10.0,
                center: LatLng(40.71, -74.00),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 45.0,
                      height: 45.0,
                      point: LatLng(40.73, -74.00),
                      builder: (context) => Container(
                        child: IconButton(
                          icon: Icon(Icons.accessibility),
                          onPressed: () {
                            print('Marker tapped!');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }
}
