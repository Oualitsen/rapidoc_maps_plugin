import 'package:flutter/material.dart';
import 'package:rapidoc_utils/utils/app_localizations.dart';

final AppLocalizationsWrapper appLocalizationsWrapper = AppLocalizationsWrapper({
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
}

class French extends English {
  String get mapNormal => "Normal";
  String get mapTerrain => "Terrain";
  String get mapHybrid => "Hybride";
  String get mapSatellite => "Satellite";
  String get cancel => "Annuler";
}

class Arabic extends English {
  String get mapNormal => "عادي";
  String get mapTerrain => "تضاريس";
  String get mapHybrid => "هجين";
  String get mapSatellite => "الأقمار الصناعية";
  String get cancel => "إلغاء";
}
