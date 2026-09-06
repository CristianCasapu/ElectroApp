import 'dart:math';

import '../models/enums.dart';
import 'echipamente.dart';
import 'verdict.dart';

/// Geometria montajului pe un plan (docs/CERCETARE.md §3.1 P118-1/2025 și
/// §3.2 „Mecanic / survey"): retrageri de siguranță, suprafață utilă, numărul
/// de module care încap și distanța între rânduri pe suprafețele orizontale.
class Retrageri {
  /// Retragerea față de coamă și de pereții portanți, la locuințe cu 1–2
  /// niveluri (P118-1/2025). La clădiri cu 3+ niveluri, perimetrul rămâne 1 m,
  /// dar apar 2,5 m la luminatoare și trape de fum și 4 m la pereți antifoc.
  final double perimetruM;

  /// Retragerea în jurul lucarnelor și luminatoarelor.
  final double lucarnaM;

  /// Latura maximă a unui câmp neîntrerupt de module și culoarul dintre câmpuri.
  final double campMaxM;
  final double culoarIntreCampuriM;

  const Retrageri({
    this.perimetruM = 1.0,
    this.lucarnaM = 0.5,
    this.campMaxM = 40,
    this.culoarIntreCampuriM = 5,
  });

  /// Valorile pentru clădiri cu cel puțin trei niveluri.
  static const cladireInalta = Retrageri(perimetruM: 1.0, lucarnaM: 2.5);
}

/// Rezultatul analizei unui plan de montaj.
class CapacitatePlan {
  final double suprafataBrutaM2;
  final double suprafataUtilaM2;
  final int moduleOrizontal;
  final int moduleVertical;
  final int nrModule;
  final double kWp;
  final double distantaRanduriM;
  final double factorUmbrire;
  final List<Verdict> verdicte;

  const CapacitatePlan({
    required this.suprafataBrutaM2,
    required this.suprafataUtilaM2,
    required this.moduleOrizontal,
    required this.moduleVertical,
    required this.nrModule,
    required this.kWp,
    required this.distantaRanduriM,
    required this.factorUmbrire,
    required this.verdicte,
  });
}

class CalculReleveu {
  CalculReleveu._();

  /// Rostul dintre module pe același rând și între rânduri, pe acoperiș.
  static const rostM = 0.02;

  /// Unghiul soarelui la amiază, la solstițiul de iarnă, pentru latitudinea
  /// [latitudine]: `α = 90° − φ − 23,45°`. Pentru distanța între rânduri se
  /// folosește un unghi mai mic (soarele la 9:00/15:00), de aceea `factorOre`.
  static double unghiSolarIarna(double latitudine, {double factorOre = 0.62}) {
    final amiaza = 90 - latitudine - 23.45;
    return max(6, amiaza * factorOre);
  }

  /// Distanța între rânduri ca soarele să nu fie blocat de rândul din față:
  /// `d = L·cos β + L·sin β / tan α`.
  static double distantaRanduri({
    required double lungimeModulM,
    required double inclinareGrade,
    required double latitudine,
  }) {
    if (inclinareGrade <= 0.5) return lungimeModulM;
    final beta = inclinareGrade * pi / 180;
    final alfa = unghiSolarIarna(latitudine) * pi / 180;
    return lungimeModulM * cos(beta) + lungimeModulM * sin(beta) / tan(alfa);
  }

  /// Factorul de umbrire estimat din obstacolele apropiate: un obstacol care
  /// se ridică peste planul modulelor umbrește o fâșie proporțională cu
  /// unghiul lui de mascare. Rezultatul este 0,5..1 (1 = fără umbrire).
  static double factorUmbrire({
    required List<({double inaltimeM, double distantaM})> obstacole,
    required double suprafataM2,
    required double latitudine,
  }) {
    if (obstacole.isEmpty || suprafataM2 <= 0) return 1;
    final alfa = unghiSolarIarna(latitudine) * pi / 180;
    var umbritM2 = 0.0;
    for (final o in obstacole) {
      if (o.inaltimeM <= 0) continue;
      // lungimea umbrei la unghiul de iarnă, limitată la 25 m
      final umbra = min(25.0, o.inaltimeM / tan(alfa));
      // fâșia umbrită începe abia dincolo de distanța până la obstacol
      final adancime = max(0.0, umbra - o.distantaM);
      umbritM2 += adancime * max(1.0, o.inaltimeM);
    }
    final fractie = (umbritM2 / suprafataM2).clamp(0.0, 0.5);
    return 1 - fractie;
  }

  /// Câte module încap pe un plan și ce putere rezultă.
  ///
  /// Pe planurile înclinate modulele urmează panta, deci contează suprafața
  /// utilă după retrageri. Pe terasă și la sol se adaugă distanța între rânduri
  /// pentru unghiul de montaj ales.
  static CapacitatePlan capacitate({
    required TipPlanMontaj tip,
    required double lungimeM,
    required double latimeM,
    required double inclinareGrade,
    required ModulPV modul,
    required double latitudine,
    List<({double inaltimeM, double distantaM})> obstacole = const [],
    Retrageri retrageri = const Retrageri(),
    bool aplicaRetrageri = true,
    StarePlan stare = StarePlan.buna,
  }) {
    final verdicte = <Verdict>[];
    final brut = lungimeM * latimeM;
    final marja = aplicaRetrageri && !tip.esteOrizontal
        ? retrageri.perimetruM
        : (aplicaRetrageri ? retrageri.perimetruM / 2 : 0);
    final lUtil = max(0.0, lungimeM - 2 * marja);
    final latUtil = max(0.0, latimeM - 2 * marja);
    final util = lUtil * latUtil;

    if (aplicaRetrageri && !tip.esteOrizontal) {
      verdicte.add(
        Verdict(
          cod: 'retrageri',
          titlu: 'Retrageri de siguranță',
          nivel: NivelVerdict.informativ,
          detaliu:
              '${retrageri.perimetruM.toStringAsFixed(1)} m față de coamă și margini, '
              '${retrageri.lucarnaM.toStringAsFixed(1)} m în jurul lucarnelor; '
              'câmpuri de maximum ${retrageri.campMaxM.toStringAsFixed(0)}×${retrageri.campMaxM.toStringAsFixed(0)} m',
          referinta: 'P118-1/2025',
        ),
      );
    }

    final latModul = modul.latimeMm / 1000;
    final lungModul = modul.lungimeMm / 1000;

    int coloane, randuri;
    double distanta;
    if (tip.esteOrizontal) {
      // module în șiruri, cu distanță între rânduri pentru unghiul ales
      distanta = distantaRanduri(
        lungimeModulM: lungModul,
        inclinareGrade: inclinareGrade,
        latitudine: latitudine,
      );
      coloane = ((lUtil + rostM) / (latModul + rostM)).floor();
      randuri = distanta <= 0 ? 0 : ((latUtil + rostM) / distanta).floor();
      if (randuri == 0 && latUtil >= lungModul) randuri = 1;
      verdicte.add(
        Verdict(
          cod: 'distanta_randuri',
          titlu: 'Distanța între rânduri',
          nivel: NivelVerdict.informativ,
          detaliu:
              '${distanta.toStringAsFixed(2)} m la înclinare ${inclinareGrade.toStringAsFixed(0)}° '
              '(soare de iarnă la ${unghiSolarIarna(latitudine).toStringAsFixed(0)}°)',
          referinta: 'docs/CERCETARE.md §3.2',
        ),
      );
    } else {
      // pe pantă: modulele stau lipite, în portret
      distanta = lungModul;
      coloane = ((lUtil + rostM) / (latModul + rostM)).floor();
      randuri = ((latUtil + rostM) / (lungModul + rostM)).floor();
    }
    coloane = max(0, coloane);
    randuri = max(0, randuri);
    final nr = coloane * randuri;
    final kWp = nr * modul.pmaxW / 1000;

    final umbrire = factorUmbrire(
      obstacole: obstacole,
      suprafataM2: util,
      latitudine: latitudine,
    );
    if (umbrire < 0.97) {
      verdicte.add(
        Verdict(
          cod: 'umbrire',
          titlu: 'Umbrire estimată',
          nivel: umbrire < 0.85
              ? NivelVerdict.atentie
              : NivelVerdict.informativ,
          detaliu:
              'pierdere ${((1 - umbrire) * 100).toStringAsFixed(0)} % din ${obstacole.length} obstacole; '
              'la umbrire parțială, optimizatoarele recuperează 5–25 %',
          referinta: 'docs/CERCETARE.md §3.2',
        ),
      );
    }
    if (stare.blocheazaMontajul) {
      verdicte.add(
        const Verdict(
          cod: 'stare_plan',
          titlu: 'Structura nu permite montajul',
          nivel: NivelVerdict.neconform,
          detaliu:
              'Planul e marcat ca neconform la releveu — se repară învelitoarea sau '
              'se alege alt plan înainte de ofertă',
          referinta: 'releveu de șantier',
        ),
      );
    } else if (stare == StarePlan.necesitaReparatii) {
      verdicte.add(
        const Verdict(
          cod: 'stare_plan',
          titlu: 'Reparații înainte de montaj',
          nivel: NivelVerdict.atentie,
          detaliu:
              'Planul necesită reparații; costul lor nu e inclus în ofertă',
          referinta: 'releveu de șantier',
        ),
      );
    }
    if (nr == 0) {
      verdicte.add(
        Verdict(
          cod: 'capacitate',
          titlu: 'Niciun modul nu încape',
          nivel: NivelVerdict.atentie,
          detaliu:
              'suprafață utilă ${util.toStringAsFixed(1)} m² după retrageri, '
              'modul ${latModul.toStringAsFixed(2)}×${lungModul.toStringAsFixed(2)} m',
          referinta: 'releveu de șantier',
        ),
      );
    }

    return CapacitatePlan(
      suprafataBrutaM2: brut,
      suprafataUtilaM2: util,
      moduleOrizontal: coloane,
      moduleVertical: randuri,
      nrModule: nr,
      kWp: kWp,
      distantaRanduriM: distanta,
      factorUmbrire: umbrire,
      verdicte: verdicte,
    );
  }

  /// Încărcarea din zăpadă pe planul înclinat: `s = μ · Ce · Ct · sk`, cu
  /// μ = 0,8 până la 30° și liniar spre 0 la 60° (CR 1-1-3/2012).
  static double incarcareZapada({
    required double skKnM2,
    required double inclinareGrade,
    double ce = 1.0,
    double ct = 1.0,
  }) {
    final mu = inclinareGrade <= 30
        ? 0.8
        : (inclinareGrade >= 60 ? 0.0 : 0.8 * (60 - inclinareGrade) / 30);
    return mu * ce * ct * skKnM2;
  }

  /// Forța de smulgere pe un modul, orientativ: `F = cp · qp · A`.
  static double fortaVant({
    required double qbKpa,
    required double suprafataModulM2,
    double ce = 1.6,
    double cp = -1.4,
  }) => (cp.abs() * ce * qbKpa) * suprafataModulM2;

  /// Latitudinea aproximativă a județului, pentru unghiul solar de iarnă.
  static double latitudineJudet(String judet) =>
      _latitudini[judet] ?? 45.9; // centrul țării

  static const _latitudini = <String, double>{
    'Constanța': 44.2,
    'Tulcea': 45.2,
    'Călărași': 44.2,
    'Ialomița': 44.6,
    'Giurgiu': 43.9,
    'Teleorman': 44.0,
    'București': 44.4,
    'Ilfov': 44.5,
    'Olt': 44.4,
    'Dolj': 44.3,
    'Brăila': 45.3,
    'Galați': 45.4,
    'Mehedinți': 44.6,
    'Buzău': 45.2,
    'Timiș': 45.8,
    'Arad': 46.2,
    'Caraș-Severin': 45.3,
    'Gorj': 45.0,
    'Vâlcea': 45.1,
    'Argeș': 45.0,
    'Dâmbovița': 44.9,
    'Prahova': 45.1,
    'Vrancea': 45.7,
    'Vaslui': 46.6,
    'Bacău': 46.6,
    'Iași': 47.2,
    'Botoșani': 47.7,
    'Neamț': 46.9,
    'Bihor': 47.0,
    'Hunedoara': 45.8,
    'Alba': 46.1,
    'Sibiu': 45.8,
    'Mureș': 46.5,
    'Cluj': 46.8,
    'Sălaj': 47.2,
    'Satu Mare': 47.8,
    'Brașov': 45.7,
    'Covasna': 45.9,
    'Harghita': 46.4,
    'Bistrița-Năsăud': 47.1,
    'Maramureș': 47.7,
    'Suceava': 47.6,
  };
}
