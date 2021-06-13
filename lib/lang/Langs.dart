import 'package:flutter/material.dart';
import 'package:rapidoc_utils/utils/app_localizations.dart';

final AppLocalizationsWrapper<English> appLocalizationsWrapper = AppLocalizationsWrapper({
  Locale('fr', "FR"): () => French(),
  Locale('ar', "DZ"): () => Arabic(),
  Locale('en', "US"): () => English(),
});

class English {
  String get mapNormal => "Normal";
  String get mapTerrain => "Terrain";
  String get mapHybrid => "Hybrid";
  String get mapSatellite => "Satellite";
  String get cancel => "Cancel";
  String get search => "Search";
  String get chooseOnMap => "Choose on map";
  String get currentPosition => "Current position";
  String get selectThisPosition => "Select this position";
}

class French extends English {
  String get mapNormal => "Normal";
  String get mapTerrain => "Terrain";
  String get mapHybrid => "Hybride";
  String get mapSatellite => "Satellite";
  String get cancel => "Annuler";
  String get search => "Recherche";
  String get chooseOnMap => "Choisir sur carte";
  String get currentPosition => "Position actuelle";
  String get selectThisPosition => "Choisir cette position";
}

class Arabic extends English {
  String get mapNormal => "عادي";
  String get mapTerrain => "تضاريس";
  String get mapHybrid => "هجين";
  String get mapSatellite => "الأقمار الصناعية";
  String get cancel => "إلغاء";
  String get search => "بحث";
  String get chooseOnMap => "اختر على الخريطة";
  String get currentPosition => "النقطة الحالية";
  String get selectThisPosition => "إختيار النقطة الحالية";
}
