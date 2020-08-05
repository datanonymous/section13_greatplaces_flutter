import 'package:flutter/material.dart';

const GOOGLE_API_KEY = 'AIzaSyA220H9a4rHdrCgBq7XtSxYNs832EwQQ1E';
//https://developers.google.com/maps/documentation/maps-static/overview

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude &key=$GOOGLE_API_KEY';
  }
}