import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
// 35.8 51.4

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  var pointIsPinned = false;
  String appBarTitle = Strings.get('place-marker-title')!;
  var radius = 0.0;
  late MapController _mapController;
  var flags = InteractiveFlag.all;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var circleMarkers = <CircleMarker>[
      if (pointIsPinned)
      CircleMarker(
        radius: radius,
        color: Theme.of(context).accentColor.withOpacity(0.3),
        point: _mapController.center,
        useRadiusInMeter: true,
      )
    ];
    
    var markers = <Marker>[
      if (pointIsPinned)
        Marker(
          width: 30,
          height: 30,
          point: _mapController.center,
          builder: (ctx) => Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(30),
            ),
          )
        )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        elevation: 1,
      ),
      body: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(35.8, 51.4),
                    zoom: 7,
                    interactiveFlags: flags,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    CircleLayerOptions(circles: circleMarkers),
                  ],
                ),
                Center(
                  child: buildMarkerIcon(Theme.of(context).errorColor, Theme.of(context).primaryColor, 15),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                      child: Text(
                        radius == 0 ? 'No limit' : '${(radius/1000).toStringAsPrecision(2)} km',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Slider(
                      value: radius/1000,
                      onChanged: pointIsPinned ? (value) {
                        setState(() {
                          radius = 1000*value;
                        });
                      } : null,
                      min: 0,
                      max: 14,
                    ),
                  ],
                ),
                flex: 2,
              ),
              Flexible(
                child: TextButton(onPressed: confirmPressed, child: Text(Strings.get('confirm')!)),
                flex: 1,
                fit: FlexFit.tight,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildMarkerIcon(Color firstColor, Color secondColor, double size) {
    return AnimatedContainer(
      width: size,
      height: size,
      decoration: BoxDecoration (
        color: pointIsPinned ? secondColor.withOpacity(0.7) : firstColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(size),
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void confirmPressed() {
    if (pointIsPinned) {
      var point = _mapController.center;
      Navigator.of(context).pop({'lat': point.latitude, 'lng' : point.longitude});
    } else {
      placeMarker();
    }
  }

  void placeMarker() {
    setState(() {
      pointIsPinned = true;
      flags = InteractiveFlag.pinchZoom;
      appBarTitle = Strings.get('aod-title')!;
    });
  }

}
