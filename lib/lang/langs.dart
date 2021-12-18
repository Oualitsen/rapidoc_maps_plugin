final Map<String, Lang> _langMap = {};

Lang findLangByName(String name) {
  switch (name) {
    case "fr":
      _langMap.putIfAbsent("fr", () => _French());
      return _langMap["fr"]!;
    case "ar":
      _langMap.putIfAbsent("ar", () => _Arabic());
      return _langMap["ar"]!;
  }
  _langMap.putIfAbsent("en", () => Lang());
  return _langMap["en"]!;
}

class Lang {
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

class _French extends Lang {
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

class _Arabic extends Lang {
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
