import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/delegates.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_common.dart';
import 'package:export_support_customer/Screens/Map/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AppointmentLocation extends StatefulWidget {
  @override
  _AppointmentLocationState createState() => _AppointmentLocationState();
}

class _AppointmentLocationState extends State<AppointmentLocation>
    implements LocationDelegate {
  String _buttonTitle = '';
  AppBloc? _appBloc;
  AppLocalizations? _localizations;
  Location? _location;

  @override
  initState() {
    _location = Location();
    super.initState();
  }

  @override
  void getLocation(String address, LatLng coordinate) {
    _appBloc?.submittedOrder.address = address;
    _appBloc?.submittedOrder.coordinate = coordinate;

    setState(() {
      _buttonTitle =
          _localizations!.translate(LocalizedKey.changeLocationButtonTitle);
    });
  }

  _onButtonTapped(BuildContext context) {
    Common.instance.loading(context);
    _handleGoToMap();
  }

  _handleGoToMap() {
    try {
      _location!.hasPermission().then((onValue) {
        _checkPermissinStatus(onValue);
      }).catchError((onError) {
        print("onError: ${onError.message}");
      });
    } on PlatformException catch (e) {
      print("e: ${e.message}");
    }
  }

  _onRequestPermission() {
    _location!.requestPermission().then((onValue) {
      _checkPermissinStatus(onValue, isPermissionAsked: true);
    }).catchError((onError) {
      print("request permission: ${onError.message}");
    });
  }

  _checkPermissinStatus(PermissionStatus status,
      {bool isPermissionAsked = false}) {
    switch (status) {
      case PermissionStatus.granted:
        _goToMap();
        break;
      case PermissionStatus.denied:
        if (isPermissionAsked) {
          Common.instance.dismiss(context);
          _alertWhenPermissionIsDenied();
        } else {
          _onRequestPermission();
        }
        break;
      case PermissionStatus.deniedForever:
        Common.instance.dismiss(context);
        _alertWhenPermissionIsDenied();
        break;
      default:
        break;
    }
  }

  _goToMap() async {
    LocationData userCurrentLocationData = await _location!.getLocation();
    Common.instance.dismiss(context);
    Common.instance.notavigateTo(
        page: MapPage(
          delegate: this,
          selectedCoordinate: _appBloc!.submittedOrder.coordinate!,
          userLocationData: userCurrentLocationData,
        ),
        pageName: "MapPage",
        context: context);
  }

  _alertWhenPermissionIsDenied() {
    Alert().warning(
        context: context,
        message:
            "In order to be able to use location please go to sitting and enable location",
        onPressed: () {
          Common.instance.dismiss(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);
    _localizations = AppLocalizations.of(context);

    _buttonTitle = _appBloc?.submittedOrder.coordinate == null
        ? _localizations!.translate(LocalizedKey.setLocationButtonTitle)
        : _localizations!.translate(LocalizedKey.changeLocationButtonTitle);

    return Column(
      children: <Widget>[
        Text(
          _localizations!.translate(LocalizedKey.serviceAvailableCityNote),
          style:
              TextStyle(fontSize: Screen.fontSize(size: 18), color: Colors.red),
        ),
        AppointmentCommon(
            text: _appBloc!.submittedOrder.address ?? '',
            buttonTitle: _buttonTitle,
            onPressed: () {
              _onButtonTapped(context);
            }),
      ],
    );
  }
}
