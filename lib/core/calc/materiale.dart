import 'dart:math';

import 'cablu_ac.dart';
import 'pv_estimare.dart';

/// Necesarul de materiale și manoperă derivat dintr-o estimare (E1). Cantitățile
/// urmează reguli de montaj obișnuite; prețurile sunt orientative (RON, fără
/// TVA) și devin editabile în catalogul din E4.
enum CategorieMaterial {
  generator('Generator fotovoltaic'),
  invertor('Invertor și stocare'),
  dc('Circuit DC'),
  ac('Circuit AC'),
  structura('Structură de montaj'),
  legarePamant('Legare la pământ și protecții'),
  diverse('Diverse');

  const CategorieMaterial(this.eticheta);
  final String eticheta;
}

class LinieMaterial {
  final CategorieMaterial categorie;
  final String denumire;
  final double cantitate;
  final String um;
  final double pretUnitarRon;
  final String? nota;

  const LinieMaterial({
    required this.categorie,
    required this.denumire,
    required this.cantitate,
    required this.um,
    required this.pretUnitarRon,
    this.nota,
  });

  double get valoareRon => cantitate * pretUnitarRon;
}

class LinieManopera {
  final String denumire;
  final double cantitate;
  final String um;
  final double pretUnitarRon;

  const LinieManopera({
    required this.denumire,
    required this.cantitate,
    required this.um,
    required this.pretUnitarRon,
  });

  double get valoareRon => cantitate * pretUnitarRon;
}

/// Prețuri implicite (RON fără TVA, 2026, orientative — §3.2 Economie).
class PreturiImplicite {
  const PreturiImplicite();

  final double cabluSolar6Ml = 6.5;
  final double cabluSolar4Ml = 4.8;
  final double mc4Pereche = 12;
  final double separatorDc = 180;
  final double sigurantaGpvCuSoclu = 45;
  final double spdDc = 320;
  final double tablouDc = 220;
  final double spdAcTip2 = 380;
  final double disjunctorPerPol = 55;
  final double ddrTipA = 260;
  final double ddrTipB = 900;
  final double tablouAc = 180;
  final double cabluAcPerMm2Ml = 1.35; // ≈ RON/ml per mm² pe conductor (Cu)
  final double sinaAlMl = 24;
  final double carligAcoperis = 28;
  final double suportTabla = 12;
  final double clemaMijloc = 6;
  final double clemaCapat = 7;
  final double balastBeton = 18;
  final double conductorPe6Ml = 5.2;
  final double platbandaOlZnMl = 14;
  final double electrodPamant = 95;
  final double piesaSeparatie = 45;
  final double tubProtectieMl = 4.5;
  final double smartMeter = 650;
  final double etichete = 120;
  final double consumabile = 250;

  // manoperă
  final double montajStructuraPerKwp = 200;
  final double montajModulePerKwp = 350;
  final double cablareDcAcPerKwp = 250;
  final double instalareInvertor = 650;
  final double instalareBaterie = 400;
  final double tablouri = 500;
  final double masuratoriPif = 600;
  final double dosarProsumator = 700;
  final double deplasarePerKm = 3.0;
}

class NecesarMateriale {
  final List<LinieMaterial> materiale;
  final List<LinieManopera> manopera;
  final double sectiuneAcMm2;
  final int disjunctorAcA;
  final String tipDdr;

  const NecesarMateriale({
    required this.materiale,
    required this.manopera,
    required this.sectiuneAcMm2,
    required this.disjunctorAcA,
    required this.tipDdr,
  });

  double get totalMaterialeRon => materiale.fold(0, (s, l) => s + l.valoareRon);
  double get totalManoperaRon => manopera.fold(0, (s, l) => s + l.valoareRon);
  double get totalRon => totalMaterialeRon + totalManoperaRon;

  static NecesarMateriale din(
    EstimareSistem e, {
    double lungimeDcM = 25,
    double lungimeAcM = 15,
    double lungimeTeg2ContorM = 5,
    bool prizaPamantNoua = false,
    bool acoperisTabla = false,
    bool terasa = false,
    double distantaKm = 0,
    PreturiImplicite p = const PreturiImplicite(),
  }) {
    final m = <LinieMaterial>[];
    final c = e.config;
    final modul = e.intrari.modul;
    final inv = e.invertor;
    final kWp = e.kWp;

    // ── Generator ─────────────────────────────────────────────────────────
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.generator,
        denumire: 'Modul fotovoltaic ${modul.denumire}',
        cantitate: e.nrModule.toDouble(),
        um: 'buc',
        pretUnitarRon: modul.pretRon,
        nota: '${c.nrStringuri} string × ${c.ns} module',
      ),
    );

    // ── Invertor + stocare ────────────────────────────────────────────────
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.invertor,
        denumire: 'Invertor ${inv.denumire}',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: inv.pretRon,
        nota:
            '${inv.pAcNomKw} kW, ${inv.faze == 1 ? 'monofazat' : 'trifazat'}, ${inv.tip.eticheta}',
      ),
    );
    if (e.baterie != null && e.nrBaterii > 0) {
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.invertor,
          denumire: 'Baterie ${e.baterie!.denumire}',
          cantitate: e.nrBaterii.toDouble(),
          um: 'buc',
          pretUnitarRon: e.baterie!.pretRon,
          nota: '${e.stocareKwh.toStringAsFixed(1)} kWh total',
        ),
      );
    }
    if (inv.esteHibrid || e.intrari.putereAprobataKva != null) {
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.invertor,
          denumire: 'Contor inteligent invertor (smart meter) cu CT',
          cantitate: 1,
          um: 'buc',
          pretUnitarRon: p.smartMeter,
          nota: 'limitare export / autoconsum',
        ),
      );
    }

    // ── DC ────────────────────────────────────────────────────────────────
    final mlDc = 2 * lungimeDcM * c.nrStringuri * 1.1;
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.dc,
        denumire: 'Cablu solar H1Z2Z2-K 6 mm² (roșu + negru)',
        cantitate: (mlDc / 5).ceil() * 5,
        um: 'ml',
        pretUnitarRon: p.cabluSolar6Ml,
        nota:
            '${c.nrStringuri} string × 2 × ${lungimeDcM.toStringAsFixed(0)} m + 10 %',
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.dc,
        denumire: 'Conectori MC4 (pereche)',
        cantitate: (c.nrStringuri * 2 + 2).toDouble(),
        um: 'per',
        pretUnitarRon: p.mc4Pereche,
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.dc,
        denumire:
            'Tablou DC cu separator ${c.spdUcMinV.toStringAsFixed(0)} V / 32 A',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.tablouDc + p.separatorDc,
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.dc,
        denumire: 'SPD DC tip 2, Uc ${c.spdUcMinV.toStringAsFixed(0)} V',
        cantitate: max(1, (c.nrStringuri / 2).ceil()).toDouble(),
        um: 'buc',
        pretUnitarRon: p.spdDc,
        nota: 'EN 61643-31; Uc ≥ 1,2 × Voc(Tmin)',
      ),
    );
    if (c.necesitaSigurante) {
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.dc,
          denumire:
              'Siguranță gPV ${c.sigurantaGpvA.toStringAsFixed(0)} A cu soclu',
          cantitate: (c.nrStringuri * 2).toDouble(),
          um: 'buc',
          pretUnitarRon: p.sigurantaGpvCuSoclu,
          nota: 'IEC 62548 cl. 7.5 — + și − pe fiecare string',
        ),
      );
    }

    // ── AC ────────────────────────────────────────────────────────────────
    final trifazat = inv.faze == 3;
    final tensiune = trifazat ? 400.0 : 230.0;
    final cablu = CableCalculator.calcSectiune(
      putereW: inv.pAcNomKw * 1000,
      tensiuneV: tensiune,
      trifazat: trifazat,
      lungimeM: lungimeAcM,
      modPozare: 'B1',
      izolatie: 'PVC',
      material: 'Cu',
      cosPhi: 1.0,
      tempAmbiantaC: 40,
      nrCircuite: 1,
      tipCircuit: 'forta',
    );
    final iInv = inv.pAcNomKw * 1000 / (trifazat ? sqrt(3) * 400 : 230);
    final disj = curentDisjunctor(iInv * 1.25);
    final conductoare = trifazat ? 5 : 3;
    final mlAc = (lungimeAcM + lungimeTeg2ContorM) * 1.1;
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.ac,
        denumire:
            'Cablu AC CYY-F $conductoare×${_fmt(cablu.sectiuneRecomandata)} mm²',
        cantitate: (mlAc / 5).ceil() * 5,
        um: 'ml',
        pretUnitarRon:
            p.cabluAcPerMm2Ml * cablu.sectiuneRecomandata * conductoare / 3,
        nota:
            'ΔU ${cablu.cadereTensiunePct.toStringAsFixed(2)} % la ${lungimeAcM.toStringAsFixed(0)} m',
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.ac,
        denumire: 'Disjunctor ${trifazat ? '4P' : '2P'} $disj A curba B',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.disjunctorPerPol * (trifazat ? 4 : 2),
        nota: 'In ≥ 1,25 × ${iInv.toStringAsFixed(1)} A',
      ),
    );
    final ddrTipB = inv.esteHibrid;
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.ac,
        denumire:
            'DDR ${trifazat ? '4P' : '2P'} ${max(disj, 25)} A / 30 mA tip ${ddrTipB ? 'B' : 'A'}',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: ddrTipB ? p.ddrTipB : p.ddrTipA,
        nota: 'IEC 62109-2 — tip A dacă producătorul declară RCMU intern',
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.ac,
        denumire: 'SPD AC tip 2 ${trifazat ? '3P+N' : '1P+N'}',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.spdAcTip2,
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.ac,
        denumire: 'Tablou AC invertor (${trifazat ? 12 : 8} module)',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.tablouAc,
      ),
    );

    // ── Structură ─────────────────────────────────────────────────────────
    final modulePeRand = 10;
    final nrRanduri = (e.nrModule / modulePeRand).ceil();
    final latimeM = modul.latimeMm / 1000;
    final mlSina = 2 * e.nrModule * latimeM * 1.05;
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.structura,
        denumire: 'Șină aluminiu montaj',
        cantitate: (mlSina / 2.1).ceil() * 2.1,
        um: 'ml',
        pretUnitarRon: p.sinaAlMl,
        nota: '2 șine / rând, $nrRanduri rânduri',
      ),
    );
    if (terasa) {
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.structura,
          denumire: 'Structură terasă (triunghi + balast)',
          cantitate: e.nrModule.toDouble(),
          um: 'set',
          pretUnitarRon: p.balastBeton * 4 + 60,
          nota: 'lestare după CR 1-1-4 (vânt)',
        ),
      );
    } else if (acoperisTabla) {
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.structura,
          denumire: 'Suport tablă / trapez cu șurub autoforant',
          cantitate: (mlSina / 0.9).ceil().toDouble(),
          um: 'buc',
          pretUnitarRon: p.suportTabla,
        ),
      );
    } else {
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.structura,
          denumire: 'Cârlig acoperiș țiglă',
          cantitate: (mlSina / 1.1).ceil().toDouble(),
          um: 'buc',
          pretUnitarRon: p.carligAcoperis,
          nota: 'la ~1,1 m pe șină, pe căpriori',
        ),
      );
    }
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.structura,
        denumire: 'Clemă de mijloc',
        cantitate: (2 * (e.nrModule - nrRanduri)).toDouble(),
        um: 'buc',
        pretUnitarRon: p.clemaMijloc,
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.structura,
        denumire: 'Clemă de capăt',
        cantitate: (4 * nrRanduri).toDouble(),
        um: 'buc',
        pretUnitarRon: p.clemaCapat,
      ),
    );

    // ── Legare la pământ ──────────────────────────────────────────────────
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.legarePamant,
        denumire:
            'Conductor PE 6 mm² Cu (galben-verde) echipotențializare rame',
        cantitate: ((lungimeDcM + 2 * mlSina / 2) / 5).ceil() * 5,
        um: 'ml',
        pretUnitarRon: p.conductorPe6Ml,
        nota: '≥ 6 mm² Cu (16 mm² dacă face parte din IPT)',
      ),
    );
    if (prizaPamantNoua) {
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.legarePamant,
          denumire: 'Electrod priză de pământ 1,5 m OL-Zn',
          cantitate: 3,
          um: 'buc',
          pretUnitarRon: p.electrodPamant,
        ),
      );
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.legarePamant,
          denumire: 'Platbandă OL-Zn 40×4',
          cantitate: 12,
          um: 'ml',
          pretUnitarRon: p.platbandaOlZnMl,
        ),
      );
      m.add(
        LinieMaterial(
          categorie: CategorieMaterial.legarePamant,
          denumire: 'Piesă de separație',
          cantitate: 1,
          um: 'buc',
          pretUnitarRon: p.piesaSeparatie,
        ),
      );
    }

    // ── Diverse ───────────────────────────────────────────────────────────
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.diverse,
        denumire: 'Tub / jgheab protecție cabluri',
        cantitate: ((lungimeDcM + lungimeAcM) / 5).ceil() * 5,
        um: 'ml',
        pretUnitarRon: p.tubProtectieMl,
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.diverse,
        denumire: 'Etichete și marcaje (DC sub tensiune, decuplare pompieri)',
        cantitate: 1,
        um: 'set',
        pretUnitarRon: p.etichete,
        nota: 'P118-1/2025',
      ),
    );
    m.add(
      LinieMaterial(
        categorie: CategorieMaterial.diverse,
        denumire: 'Consumabile (șuruburi, papuci, coliere, dibluri)',
        cantitate: 1,
        um: 'set',
        pretUnitarRon: p.consumabile,
      ),
    );

    // ── Manoperă ──────────────────────────────────────────────────────────
    final man = <LinieManopera>[
      LinieManopera(
        denumire: 'Montaj structură',
        cantitate: kWp,
        um: 'kWp',
        pretUnitarRon: p.montajStructuraPerKwp,
      ),
      LinieManopera(
        denumire: 'Montaj module și conectare string-uri',
        cantitate: kWp,
        um: 'kWp',
        pretUnitarRon: p.montajModulePerKwp,
      ),
      LinieManopera(
        denumire: 'Cablare DC/AC, tablouri, legare la pământ',
        cantitate: kWp,
        um: 'kWp',
        pretUnitarRon: p.cablareDcAcPerKwp,
      ),
      LinieManopera(
        denumire:
            'Instalare și configurare invertor (cod rețea, limitare export, monitorizare)',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.instalareInvertor,
      ),
      if (e.nrBaterii > 0)
        LinieManopera(
          denumire: 'Instalare și configurare baterii',
          cantitate: e.nrBaterii.toDouble(),
          um: 'buc',
          pretUnitarRon: p.instalareBaterie,
        ),
      LinieManopera(
        denumire: 'Echipare tablouri DC și AC',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.tablouri,
      ),
      LinieManopera(
        denumire: 'Măsurători PIF (IEC 62446-1) și buletin PRAM',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.masuratoriPif,
      ),
      LinieManopera(
        denumire: 'Dosar prosumator (DIU, schemă monofilară, PV recepție)',
        cantitate: 1,
        um: 'buc',
        pretUnitarRon: p.dosarProsumator,
      ),
      if (distantaKm > 0)
        LinieManopera(
          denumire: 'Deplasare (dus-întors, 3 zile)',
          cantitate: distantaKm * 2 * 3,
          um: 'km',
          pretUnitarRon: p.deplasarePerKm,
        ),
    ];

    return NecesarMateriale(
      materiale: m,
      manopera: man,
      sectiuneAcMm2: cablu.sectiuneRecomandata,
      disjunctorAcA: disj,
      tipDdr: ddrTipB ? 'B' : 'A',
    );
  }

  /// Valoarea standard de disjunctor ≥ [curent].
  static int curentDisjunctor(double curent) {
    const standard = [10, 13, 16, 20, 25, 32, 40, 50, 63, 80, 100, 125];
    return standard.firstWhere((s) => s >= curent, orElse: () => 125);
  }

  static String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}
