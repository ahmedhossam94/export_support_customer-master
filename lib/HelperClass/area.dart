import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Area {
  /*
     * Computes whether the given point lies inside the specified polygon.
     * The polygon is always cosidered closed, regardless of whether the last point equals
     * the first or not.
     * Inside is defined as not containing the South Pole -- the South Pole is always outside.
     * The polygon is formed of great circle segments if geodesic is true, and of rhumb
     * (loxodromic) segments otherwise.
     */
  static bool containsLocation(
      {required LatLng point,
      required List<LatLng> polygon,
      required bool geodesic}) {
    final int size = polygon.length;
    if (size == 0) {
      return false;
    }
    double lat3 = _degreesToRads(point.latitude);
    double lng3 = _degreesToRads(point.longitude);
    LatLng prev = polygon[size - 1];
    double lat1 = _degreesToRads(prev.latitude);
    double lng1 = _degreesToRads(prev.longitude);
    int nIntersect = 0;

    polygon.forEach((point2) {
      double dLng3 = _wrap(lng3 - lng1, -pi, pi);
      // Special case: point equal to vertex is inside.
      if (lat3 == lat1 && dLng3 == 0) {
        throw true;
      }
      double lat2 = _degreesToRads(point2.latitude);
      double lng2 = _degreesToRads(point2.longitude);
      // Offset longitudes by -lng1.
      if (_intersects(
          lat1, lat2, _wrap(lng2 - lng1, -pi, pi), lat3, dLng3, geodesic)) {
        ++nIntersect;
      }
      lat1 = lat2;
      lng1 = lng2;
    });
    return (nIntersect & 1) != 0;
  }

  static double _degreesToRads(double deg) {
    return (deg * pi) / 180.0;
  }

  /*
     * Wraps the given value into the inclusive-exclusive interval between min and max.
     * @param n   The value to wrap.
     * @param min The minimum.
     * @param max The maximum.
     */
  static double _wrap(double n, double min, double max) {
    return (n >= min && n < max) ? n : (_mod(n - min, max - min) + min);
  }

  /*
     * Returns the non-negative remainder of x / m.
     * @param x The operand.
     * @param m The modulus.
     */
  static double _mod(double x, double m) {
    return ((x % m) + m) % m;
  }

  /*
     * Computes whether the vertical segment (lat3, lng3) to South Pole intersects the segment
     * (lat1, lng1) to (lat2, lng2).
     * Longitudes are offset by -lng1; the implicit lng1 becomes 0.
     */
  static bool _intersects(double lat1, double lat2, double lng2, double lat3,
      double lng3, bool geodesic) {
    // Both ends on the same side of lng3.
    if ((lng3 >= 0 && lng3 >= lng2) || (lng3 < 0 && lng3 < lng2)) {
      return false;
    }
    // Point is South Pole.
    if (lat3 <= -pi / 2) {
      return false;
    }
    // Any segment end is a pole.
    if (lat1 <= -pi / 2 ||
        lat2 <= -pi / 2 ||
        lat1 >= pi / 2 ||
        lat2 >= pi / 2) {
      return false;
    }
    if (lng2 <= -pi) {
      return false;
    }
    double linearLat = (lat1 * (lng2 - lng3) + lat2 * lng3) / lng2;
    // Northern hemisphere and point under lat-lng line.
    if (lat1 >= 0 && lat2 >= 0 && lat3 < linearLat) {
      return false;
    }
    // Southern hemisphere and point above lat-lng line.
    if (lat1 <= 0 && lat2 <= 0 && lat3 >= linearLat) {
      return true;
    }
    // North Pole.
    if (lat3 >= pi / 2) {
      return true;
    }
    // Compare lat3 with latitude on the GC/Rhumb segment corresponding to lng3.
    // Compare through a strictly-increasing function (tan() or mercator()) as convenient.
    return geodesic
        ? tan(lat3) >= _tanLatGC(lat1, lat2, lng2, lng3)
        : _mercator(lat3) >= _mercatorLatRhumb(lat1, lat2, lng2, lng3);
  }

  /*
     * Returns tan(latitude-at-lng3) on the great circle (lat1, lng1) to (lat2, lng2). lng1==0.
     * See http://williams.best.vwh.net/avform.htm .
     */
  static double _tanLatGC(double lat1, double lat2, double lng2, double lng3) {
    return (tan(lat1) * sin(lng2 - lng3) + tan(lat2) * sin(lng3)) / sin(lng2);
  }

  /*
     * Returns mercator Y corresponding to latitude.
     * See http://en.wikipedia.org/wiki/Mercator_projection .
     */
  static double _mercator(double lat) {
    return log(tan(lat * 0.5 + pi / 4));
  }

  /*
     * Returns mercator(latitude-at-lng3) on the Rhumb line (lat1, lng1) to (lat2, lng2). lng1==0.
     */
  static double _mercatorLatRhumb(
      double lat1, double lat2, double lng2, double lng3) {
    return (_mercator(lat1) * (lng2 - lng3) + _mercator(lat2) * lng3) / lng2;
  }
}
