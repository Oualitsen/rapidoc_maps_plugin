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
  @override
  String get mapNormal => "Normal";
  @override
  String get mapTerrain => "Terrain";
  @override
  String get mapHybrid => "Hybride";
  @override
  String get mapSatellite => "Satellite";
  @override
  String get cancel => "Annuler";
  @override
  String get search => "Recherche";
  @override
  String get chooseOnMap => "Choisir sur carte";
  @override
  String get currentPosition => "Position actuelle";
  @override
  String get selectThisPosition => "Choisir cette position";
}

class _Arabic extends Lang {
  @override
  String get mapNormal => "عادي";
  @override
  String get mapTerrain => "تضاريس";
  @override
  String get mapHybrid => "هجين";
  @override
  String get mapSatellite => "الأقمار الصناعية";
  @override
  String get cancel => "إلغاء";
  @override
  String get search => "بحث";
  @override
  String get chooseOnMap => "اختر على الخريطة";
  @override
  String get currentPosition => "النقطة الحالية";
  @override
  String get selectThisPosition => "إختيار النقطة الحالية";
}
