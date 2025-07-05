import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:deu_cis/product/models/event.dart';

class GoogleMapWidget extends StatefulWidget {
  final Event event;

  const GoogleMapWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    try {
      if (widget.event.latitude != null && widget.event.longitude != null) {
        final double lat = double.parse(widget.event.latitude!);
        final double lng = double.parse(widget.event.longitude!);

        final marker = Marker(
          markerId: MarkerId(widget.event.id.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: widget.event.locationName ?? 'Event Location',
          ),
        );

        _markers = {marker};
      }
    } catch (e) {
      debugPrint('Error initializing markers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double mapHeight = MediaQuery.of(context).size.width * 0.35;

    if (widget.event.latitude == null ||
        widget.event.longitude == null ||
        widget.event.latitude!.isEmpty ||
        widget.event.longitude!.isEmpty) {
      return SizedBox(
        height: mapHeight,
        child: Center(
          child: Text(
            'Location data not available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    try {
      final double lat = double.parse(widget.event.latitude!);
      final double lng = double.parse(widget.event.longitude!);

      return SizedBox(
        height: mapHeight,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                setState(() {
                  _isMapReady = true;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 14,
              ),
              markers: _markers,
              myLocationEnabled: false,
              compassEnabled: true,
              zoomControlsEnabled: true,
              mapToolbarEnabled: true,
              liteModeEnabled: false,
            ),
            if (!_isMapReady)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.7),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error rendering map: $e');
      return SizedBox(
        height: mapHeight,
        child: Center(
          child: Text(
            'Error displaying map',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}
