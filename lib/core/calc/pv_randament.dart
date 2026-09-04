import 'dart:math';

/// Randamentul energetic estimat offline (docs/CERCETARE.md §3.2): producție
/// specifică pe județ (sud, ~30–35°, ~14 % pierderi, sursă hărți PVGIS/greenlead)
/// × factor de orientare/înclinare × distribuție lunară tipică pentru România.
/// Pentru valori exacte per amplasament se folosește PVGIS (E2, cu coordonate).
class RandamentPV {
  RandamentPV._();

  /// kWh/kWp/an la orientare optimă, pe județ. Implicit (județ necunoscut): 1250.
  static const productieSpecificaJudet = <String, double>{
    'Constanța': 1360,
    'Tulcea': 1340,
    'Călărași': 1310,
    'Ialomița': 1310,
    'Giurgiu': 1310,
    'Teleorman': 1310,
    'București': 1300,
    'Ilfov': 1300,
    'Olt': 1300,
    'Dolj': 1300,
    'Brăila': 1300,
    'Galați': 1290,
    'Mehedinți': 1290,
    'Buzău': 1280,
    'Timiș': 1280,
    'Arad': 1270,
    'Caraș-Severin': 1260,
    'Gorj': 1260,
    'Vâlcea': 1260,
    'Argeș': 1250,
    'Dâmbovița': 1250,
    'Prahova': 1250,
    'Vrancea': 1240,
    'Vaslui': 1240,
    'Bacău': 1230,
    'Iași': 1230,
    'Botoșani': 1220,
    'Neamț': 1220,
    'Bihor': 1230,
    'Hunedoara': 1220,
    'Alba': 1220,
    'Sibiu': 1220,
    'Mureș': 1210,
    'Cluj': 1210,
    'Sălaj': 1210,
    'Satu Mare': 1210,
    'Brașov': 1200,
    'Covasna': 1200,
    'Harghita': 1190,
    'Bistrița-Năsăud': 1190,
    'Maramureș': 1190,
    'Suceava': 1180,
  };

  static const productieSpecificaImplicita = 1250.0;

  static double productieSpecifica(String judet) =>
      productieSpecificaJudet[judet] ?? productieSpecificaImplicita;

  /// Factor de orientare (fracție din optim), grilă azimut × înclinare pentru
  /// ~45° N. Azimut: 0 = sud, 90 = est/vest, 180 = nord. Interpolare biliniară.
  static const _azimuturi = [0.0, 45.0, 90.0, 135.0, 180.0];
  static const _inclinari = [0.0, 15.0, 30.0, 45.0, 60.0, 90.0];
  static const _factori = [
    // înclinare 0 (orizontal) — azimutul nu contează
    [0.88, 0.88, 0.88, 0.88, 0.88],
    [0.96, 0.95, 0.90, 0.84, 0.80], // 15°
    [1.00, 0.97, 0.88, 0.78, 0.70], // 30°
    [0.99, 0.95, 0.85, 0.72, 0.62], // 45°
    [0.94, 0.90, 0.79, 0.65, 0.53], // 60°
    [0.72, 0.69, 0.58, 0.45, 0.35], // 90° (fațadă)
  ];

  static double factorOrientare({
    required double azimutGrade,
    required double inclinareGrade,
  }) {
    final az = azimutGrade.abs().clamp(0.0, 180.0);
    final inc = inclinareGrade.clamp(0.0, 90.0);
    int idx(List<double> grid, double v) {
      for (var i = 0; i < grid.length - 1; i++) {
        if (v <= grid[i + 1]) return i;
      }
      return grid.length - 2;
    }

    final i = idx(_inclinari, inc);
    final j = idx(_azimuturi, az);
    final ti = (inc - _inclinari[i]) / (_inclinari[i + 1] - _inclinari[i]);
    final tj = (az - _azimuturi[j]) / (_azimuturi[j + 1] - _azimuturi[j]);
    final a = _factori[i][j] * (1 - tj) + _factori[i][j + 1] * tj;
    final b = _factori[i + 1][j] * (1 - tj) + _factori[i + 1][j + 1] * tj;
    return a * (1 - ti) + b * ti;
  }

  /// Distribuția lunară a producției anuale (fracții, sud 30°, România).
  static const distributieLunara = [
    0.035,
    0.050,
    0.080,
    0.100,
    0.115,
    0.120,
    0.130,
    0.120,
    0.095,
    0.075,
    0.045,
    0.035,
  ];

  /// Producția anuală estimată (kWh) pentru [kWp] instalați.
  static double productieAnuala({
    required double kWp,
    required String judet,
    required double azimutGrade,
    required double inclinareGrade,
    double factorUmbrire = 1.0,
  }) =>
      kWp *
      productieSpecifica(judet) *
      factorOrientare(
        azimutGrade: azimutGrade,
        inclinareGrade: inclinareGrade,
      ) *
      factorUmbrire;

  static List<double> productieLunara(double productieAnualaKwh) =>
      distributieLunara.map((f) => productieAnualaKwh * f).toList();

  /// Fracția de autoconsum estimată din raportul producție/consum, profilul de
  /// consum și stocare (euristici, docs/CERCETARE.md §3.2 „Autoconsum").
  ///
  /// [raport] = E_pv / E_consum; [stocareKwh] utilizabilă; [consumZilnicKwh].
  static double autoconsum({
    required double raport,
    required bool profilDiurn,
    double stocareKwh = 0,
    double consumZilnicKwh = 10,
  }) {
    if (raport <= 0) return 0;
    final baza = profilDiurn
        ? 0.65 * pow(raport, -0.4)
        : 0.35 * pow(raport, -0.5);
    var sc = baza.toDouble().clamp(0.15, profilDiurn ? 0.95 : 0.6);
    if (stocareKwh > 0 && consumZilnicKwh > 0) {
      sc += min(0.40, 0.5 * stocareKwh / consumZilnicKwh);
    }
    return min(sc, 0.95);
  }
}
