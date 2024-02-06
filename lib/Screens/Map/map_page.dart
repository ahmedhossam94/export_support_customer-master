import 'dart:async';
import 'dart:io';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/area.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/delegates.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as Geocoder;

class MapPage extends StatefulWidget {
  MapPage(
      {Key? key,
      required this.delegate,
      required this.selectedCoordinate,
      required this.userLocationData})
      : super(key: key);

  final LocationDelegate delegate;
  final LocationData userLocationData;
  final LatLng selectedCoordinate;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController>? _controller;
  CameraPosition? _userNewPosition;
  Marker? _marker;
  Set<Marker>? _markers;
  bool _enableSelectButton = false;
  LocationDelegate? _delegate;
  AppLocalizations? _localizations;
  LatLng? _initLocation;

  final LatLng _center = LatLng(0, 0);

  @override
  void initState() {
    _controller = Completer();
    _enableSelectButton = true;
    _delegate = widget.delegate;
    _initLocation = widget.selectedCoordinate;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initUserLocation();
    });

    super.initState();
  }

  _initUserLocation() async {
    if (widget.selectedCoordinate != null) {
      _userNewPosition =
          CameraPosition(target: widget.selectedCoordinate, zoom: 16.0);
    } else {
      _userNewPosition = CameraPosition(
          target: LatLng(widget.userLocationData.latitude ?? 0,
              widget.userLocationData.longitude ?? 0),
          zoom: 16.0);
      //_goToMyLocation();
    }

    setState(() {
      _setMarker(position: _userNewPosition!);
    });
  }

  _goToMyLocation() async {
    try {
      final GoogleMapController googleMapController = await _controller!.future;
      //LocationData userCurrentLocationData = await _location.getLocation();

      _userNewPosition = CameraPosition(
          target: LatLng(widget.userLocationData.latitude ?? 0,
              widget.userLocationData.longitude ?? 0),
          zoom: 16.0);

      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(_userNewPosition!));
    } on PlatformException catch (e) {
      print("e: ${e.message}");
    }
  }

  _setMarker({@required CameraPosition? position}) {
    _marker =
        Marker(markerId: MarkerId("user_position"), position: position!.target);
    _markers = Set.from([_marker]);
  }

  _onMapCreated(GoogleMapController controller) {
    _controller?.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    setState(() {
      _userNewPosition = position;
      _setMarker(position: position);
      _enableSelectButton = false;
    });
  }

  _onCameraIdle() {
    setState(() {
      _enableSelectButton = true;
    });
  }

  List<LatLng> _getListOfPoint() {
    List<LatLng> points = [];

    // points.add(LatLng(21.635952, 39.210524));
    // points.add(LatLng(21.595576, 39.225554));
    // points.add(LatLng(21.567272, 39.230945));
    // points.add(LatLng(21.558340, 39.232586));
    // points.add(LatLng(21.540486, 39.238037));
    // points.add(LatLng(21.529619, 39.180246));
    // points.add(LatLng(21.523162, 39.163917));
    // points.add(LatLng(21.541123, 39.155532));
    // points.add(LatLng(21.544092, 39.144005));
    // points.add(LatLng(21.542979, 39.137458));
    // points.add(LatLng(21.543445, 39.133908));
    // points.add(LatLng(21.546322, 39.128759));
    // points.add(LatLng(21.551869, 39.125134));
    // points.add(LatLng(21.581286, 39.126689));
    // points.add(LatLng(21.601107, 39.120870));
    // points.add(LatLng(21.606312, 39.120701));
    // points.add(LatLng(21.631691, 39.112168));
    // points.add(LatLng(21.664556, 39.110725));
    // points.add(LatLng(21.670828, 39.128797));
    // points.add(LatLng(21.659535, 39.133201));
    // points.add(LatLng(21.640716, 39.147070));
    // points.add(LatLng(21.635431, 39.157418));
    // points.add(LatLng(21.634691, 39.194007));
    // points.add(LatLng(21.633898, 39.201086));
    // points.add(LatLng(21.635952, 39.210524));

    points.add(LatLng(21.540486, 39.238037));
    points.add(LatLng(21.529619, 39.180246));
    points.add(LatLng(21.523162, 39.163917));
    points.add(LatLng(21.509372, 39.131252));
    points.add(LatLng(21.505227, 39.108656));
    points.add(LatLng(21.802087, 39.033202));
    points.add(LatLng(21.840400, 39.199704));
    points.add(LatLng(21.685229, 39.247259));
    points.add(LatLng(21.650817, 39.254975));
    points.add(LatLng(21.615544, 39.269775));
    points.add(LatLng(21.557869, 39.290917));
    points.add(LatLng(21.552525, 39.282800));
    points.add(LatLng(21.548453, 39.272312));
    points.add(LatLng(21.549811, 39.262644));
    points.add(LatLng(21.545151, 39.255158));
    points.add(LatLng(21.543320, 39.252512));
    points.add(LatLng(21.540486, 39.238037));

    return points;
  }

  Set<Polyline> _getPolyLines() {
    Set<Polyline> polyLines = Set();

    Polyline polyLine = Polyline(
        polylineId: PolylineId("Initial_ployLines_id"),
        points: _getListOfPoint(),
        width: 1,
        geodesic: true);

    polyLines.add(polyLine);
    return polyLines;
  }

  _onSelectButtonTapped() async {
    if (_userNewPosition == null) {
      Alert().warning(
          context: context,
          title: _localizations!.translate(
              LocalizedKey.serviceNotAvailableInSelectRegionAlertTitle),
          message: _localizations!.translate(
              LocalizedKey.serviceNotAvailableInSelectRegionAlertMessage),
          onPressed: () {
            Common.instance.dismiss(context);
          });
    } else {
      setState(() {
        _enableSelectButton = false;
      });

      bool isInsidePath = Area.containsLocation(
          point: _userNewPosition!.target,
          polygon: _getListOfPoint(),
          geodesic: true);

      // if (isInsidePath){
      //   String address = "";
      //   var geocoderCoordinate = Geocoder.Coordinates(_userNewPosition?.target.latitude, _userNewPosition?.target.longitude);
      //   if (geocoderCoordinate != null) {
      //     var addressList = await Geocoder.Geocoder.local.findAddressesFromCoordinates(geocoderCoordinate);
      //     if (_delegate != null) {
      //       LatLng coordinate = LatLng(_userNewPosition.target.latitude, _userNewPosition.target.longitude);
      //       if (addressList.length > 0 && addressList.first != null) {
      //         String streetNumber = addressList.first.subThoroughfare == null ? addressList.first.featureName : addressList.first.subThoroughfare;
      //         String streetName = addressList.first.thoroughfare == null ? "" : " ${addressList.first.thoroughfare}";
      //         String district = addressList.first.subLocality == null ? "" : ", ${addressList.first.subLocality}";
      //         String city = addressList.first.locality == null ? "" : ", ${addressList.first.locality}";

      //         address = streetNumber + streetName + district + city;
      //       } else {
      //         address = "${_userNewPosition.target.latitude}, ${_userNewPosition.target.longitude}";
      //       }
      //       _delegate.getLocation(address, coordinate);
      //       Common.instance.dismiss(context);
      //     }
      //   } else {
      //     address = "${_userNewPosition.target.latitude}, ${_userNewPosition.target.longitude}";
      //   }
      // } else {
      //   Alert().warning(
      //     context: context,
      //     title: _localizations.translate(LocalizedKey.serviceNotAvailableInSelectRegionAlertTitle),
      //     message: _localizations.translate(LocalizedKey.serviceNotAvailableInSelectRegionAlertMessage),
      //     onPressed: () { Common.instance.dismiss(context); });
      // }
      setState(() {
        _enableSelectButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: _initLocation ?? _center, zoom: 16.0),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            onCameraMove: (onCameraMove) {
              _onCameraMove(onCameraMove);
            },
            onCameraIdle: () {
              _onCameraIdle();
            },
            markers: _markers!,
            polylines: _getPolyLines(),
          ),
          MapActionButtons(
            onMyLocationPressed: () {
              _goToMyLocation();
            },
            onSelectPessed: _enableSelectButton ? _onSelectButtonTapped : () {},
          )
        ],
      ),
    );
  }
}

class MapActionButtons extends StatelessWidget {
  MapActionButtons(
      {Key? key,
      required this.onMyLocationPressed,
      required this.onSelectPessed})
      : super(key: key);

  final Function() onMyLocationPressed;
  final Function() onSelectPessed;

  @override
  Widget build(BuildContext context) {
    AppLocalizations _localizations = AppLocalizations.of(context);

    return SafeArea(
      right: false,
      top: false,
      left: false,
      bottom: true,
      child: Container(
        alignment: FractionalOffset.bottomCenter,
        padding: EdgeInsets.symmetric(
            vertical: 28, horizontal: Platform.isIOS ? 24 : 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: FractionalOffset.centerRight,
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.my_location,
                    color: Colors.grey[700],
                  ),
                  onPressed: onMyLocationPressed),
            ),
            Container(
              height: 16,
            ),
            CommonButton(
                title: _localizations.translate(LocalizedKey.selectButtonTitle),
                onPressed: onSelectPessed)
          ],
        ),
      ),
    );
  }
}
