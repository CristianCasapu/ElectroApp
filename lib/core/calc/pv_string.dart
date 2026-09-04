import 'dart:math';

import 'echipamente.dart';
import 'verdict.dart';

/// Dimensionarea string-urilor (docs/CERCETARE.md §3.2, IEC 62548):
///
///   Voc_string(Tmin) = Ns · Voc · (1 + β/100 · (Tmin − 25))  ≤ V_DC,max
///   Vmp_string(Tmax) = Ns · Vmp · (1 + γ/100 · (Tcell_max − 25)) ≥ V_MPPT,min
///   I_string,max = 1,25 · Isc ; Np · Isc · 1,25 ≤ I_sc,max invertor
///   siguranțe de string necesare dacă (N − 1) · 1,25 · Isc > I_fuse,max modul
class ConfigString {
  final ModulPV modul;
  final InvertorPV invertor;

  /// Module în serie pe string și numărul total de string-uri (egale).
  final int ns;
  final int nrStringuri;
  final double tMinC;
  final double tCellMaxC;

  const ConfigString({
    required this.modul,
    required this.invertor,
    required this.ns,
    required this.nrStringuri,
    this.tMinC = -25,
    this.tCellMaxC = 70,
  });

  int get nrModule => ns * nrStringuri;
  double get kWp => nrModule * modul.pmaxW / 1000;
  double get raportDcAc => kWp / invertor.pAcNomKw;

  double get vocLaTmin =>
      ns * modul.vocV * (1 + modul.betaVocPctK / 100 * (tMinC - 25));
  double get vmpLaTmax =>
      ns * modul.vmpV * (1 + modul.gammaPmaxPctK / 100 * (tCellMaxC - 25));
  double get vmpStc => ns * modul.vmpV;
  double get iscMaxString => 1.25 * modul.iscA;

  /// String-uri pe fiecare MPPT (distribuție cât mai egală).
  int get stringuriPerMppt => (nrStringuri / invertor.nrMppt).ceil();

  bool get necesitaSigurante =>
      nrStringuri > 2 &&
      (stringuriPerMppt - 1) * iscMaxString > modul.sigurantaMaxA;

  /// Siguranța gPV: 1,4·Isc ≤ In ≤ min(2,4·Isc, I_fuse,max modul), valoare standard.
  double get sigurantaGpvA {
    const standard = [10.0, 12.0, 15.0, 16.0, 20.0, 25.0, 30.0, 32.0];
    final inf = 1.4 * modul.iscA;
    final sup = min(2.4 * modul.iscA, modul.sigurantaMaxA);
    return standard.firstWhere(
      (s) => s >= inf && s <= sup,
      orElse: () => standard.lastWhere((s) => s <= sup, orElse: () => inf),
    );
  }

  /// SPD DC: Uc ≥ 1,2 · Voc_string(Tmin), clase standard.
  double get spdUcMinV {
    final u = 1.2 * vocLaTmin;
    for (final c in [600.0, 1000.0, 1500.0]) {
      if (u <= c) return c;
    }
    return u;
  }

  List<Verdict> verifica() {
    final v = <Verdict>[];
    final vocMax = vocLaTmin;
    final limitaVoc = min(invertor.vDcMaxV, modul.tensiuneSistemMaxV);
    v.add(
      Verdict(
        cod: 'voc_tmin',
        titlu: 'Tensiune maximă la Tmin ($tMinC °C)',
        nivel: vocMax <= limitaVoc
            ? (vocMax > 0.95 * limitaVoc
                  ? NivelVerdict.atentie
                  : NivelVerdict.conform)
            : NivelVerdict.neconform,
        detaliu:
            'Voc string = ${vocMax.toStringAsFixed(0)} V, limită ${limitaVoc.toStringAsFixed(0)} V',
        referinta: 'IEC 62548 · fișa invertorului (V DC max)',
      ),
    );
    final vmp = vmpLaTmax;
    v.add(
      Verdict(
        cod: 'vmp_tmax',
        titlu: 'Tensiune MPP la Tcell $tCellMaxC °C',
        nivel: vmp >= invertor.vMpptMinV
            ? NivelVerdict.conform
            : NivelVerdict.neconform,
        detaliu:
            'Vmp string = ${vmp.toStringAsFixed(0)} V, MPPT min ${invertor.vMpptMinV.toStringAsFixed(0)} V',
        referinta: 'IEC 62548 · fereastra MPPT',
      ),
    );
    v.add(
      Verdict(
        cod: 'vmp_max',
        titlu: 'Tensiune MPP la STC în fereastra MPPT',
        nivel: vmpStc <= invertor.vMpptMaxV
            ? NivelVerdict.conform
            : NivelVerdict.atentie,
        detaliu:
            'Vmp string STC = ${vmpStc.toStringAsFixed(0)} V, MPPT max ${invertor.vMpptMaxV.toStringAsFixed(0)} V',
        referinta: 'fișa invertorului',
      ),
    );
    // Limita invertorului se compară cu Isc STC; factorul 1,25 (iradiere peste
    // STC) e criteriu de dimensionare pentru cabluri/protecții și devine doar
    // avertisment aici (practica Sunny Design / fișele producătorilor).
    final iScStc = stringuriPerMppt * modul.iscA;
    final iString = stringuriPerMppt * iscMaxString;
    v.add(
      Verdict(
        cod: 'isc_mppt',
        titlu: 'Curent de scurtcircuit pe MPPT',
        nivel: iScStc <= invertor.iScMaxA
            ? (iString <= invertor.iScMaxA
                  ? NivelVerdict.conform
                  : NivelVerdict.atentie)
            : NivelVerdict.neconform,
        detaliu:
            '$stringuriPerMppt string × ${modul.iscA} A = ${iScStc.toStringAsFixed(1)} A (× 1,25 = ${iString.toStringAsFixed(1)} A), limită ${invertor.iScMaxA} A',
        referinta: 'IEC 62548 (Isc × 1,25) · fișa invertorului',
      ),
    );
    final iMpp = stringuriPerMppt * modul.impA;
    v.add(
      Verdict(
        cod: 'imp_mppt',
        titlu: 'Curent MPP pe intrare',
        nivel: iMpp <= invertor.iMpptMaxA
            ? NivelVerdict.conform
            : NivelVerdict.atentie,
        detaliu:
            '${iMpp.toStringAsFixed(1)} A din ${invertor.iMpptMaxA} A admiși (peste limită se pierde putere, nu siguranță)',
        referinta: 'fișa invertorului',
      ),
    );
    v.add(
      Verdict(
        cod: 'stringuri',
        titlu: 'Număr de string-uri',
        nivel: nrStringuri <= invertor.stringuriMax
            ? NivelVerdict.conform
            : NivelVerdict.neconform,
        detaliu:
            '$nrStringuri string-uri, invertorul acceptă ${invertor.stringuriMax} (${invertor.nrMppt} MPPT × ${invertor.stringuriPerMppt})',
        referinta: 'fișa invertorului',
      ),
    );
    final r = raportDcAc;
    v.add(
      Verdict(
        cod: 'dc_ac',
        titlu: 'Raport DC/AC',
        nivel: r <= 1.0
            ? NivelVerdict.informativ
            : (r <= 1.35 ? NivelVerdict.conform : NivelVerdict.atentie),
        detaliu:
            '${kWp.toStringAsFixed(2)} kWp / ${invertor.pAcNomKw} kW = ${r.toStringAsFixed(2)} (tipic 1,1–1,3; P DC max ${invertor.pDcMaxKw} kW)',
        referinta: 'docs/CERCETARE.md §3.2',
      ),
    );
    if (kWp > invertor.pDcMaxKw) {
      v.add(
        Verdict(
          cod: 'p_dc_max',
          titlu: 'Putere DC peste maximul invertorului',
          nivel: NivelVerdict.neconform,
          detaliu:
              '${kWp.toStringAsFixed(2)} kWp > ${invertor.pDcMaxKw} kW admiși',
          referinta: 'fișa invertorului',
        ),
      );
    }
    v.add(
      Verdict(
        cod: 'sigurante',
        titlu: 'Siguranțe de string',
        nivel: NivelVerdict.informativ,
        detaliu: necesitaSigurante
            ? 'Necesare: gPV ${sigurantaGpvA.toStringAsFixed(0)} A, ≥ ${vocLaTmin.toStringAsFixed(0)} V DC, pe fiecare string'
            : 'Nu sunt necesare (≤ 2 string-uri paralel per MPPT)',
        referinta: 'IEC 62548 cl. 7.5 · IEC 60269-6',
      ),
    );
    return v;
  }

  bool get esteConforma =>
      verifica().every((x) => x.nivel != NivelVerdict.neconform);

  /// Numărul maxim de module în serie pentru ca Voc(Tmin) ≤ V DC max.
  static int nsMax(ModulPV m, InvertorPV inv, {double tMinC = -25}) {
    final vocRece = m.vocV * (1 + m.betaVocPctK / 100 * (tMinC - 25));
    final limita = min(inv.vDcMaxV, m.tensiuneSistemMaxV);
    return (limita / vocRece).floor();
  }

  /// Numărul minim de module în serie pentru ca Vmp(Tcell max) ≥ V MPPT min.
  static int nsMin(ModulPV m, InvertorPV inv, {double tCellMaxC = 70}) {
    final vmpCald = m.vmpV * (1 + m.gammaPmaxPctK / 100 * (tCellMaxC - 25));
    return (inv.vMpptMinV / vmpCald).ceil();
  }

  /// Caută configurația cu [nrModuleDorit] module (± câteva) care respectă
  /// limitele: cât mai puține string-uri, cât mai lungi. `null` dacă nu
  /// există una conformă.
  static ConfigString? propune({
    required ModulPV modul,
    required InvertorPV invertor,
    required int nrModuleDorit,
    double tMinC = -25,
    double tCellMaxC = 70,
  }) {
    final nsMx = nsMax(modul, invertor, tMinC: tMinC);
    final nsMn = nsMin(modul, invertor, tCellMaxC: tCellMaxC);
    if (nsMx < nsMn || nrModuleDorit <= 0) return null;
    ConfigString? ceaMaiBuna;
    var abatere = 1 << 30;
    for (var k = 1; k <= invertor.stringuriMax; k++) {
      for (final ns in [
        (nrModuleDorit / k).round(),
        (nrModuleDorit / k).ceil(),
      ]) {
        if (ns < nsMn || ns > nsMx) continue;
        final c = ConfigString(
          modul: modul,
          invertor: invertor,
          ns: ns,
          nrStringuri: k,
          tMinC: tMinC,
          tCellMaxC: tCellMaxC,
        );
        if (!c.esteConforma) continue;
        final d = (c.nrModule - nrModuleDorit).abs() * 10 + k;
        if (d < abatere) {
          abatere = d;
          ceaMaiBuna = c;
        }
      }
    }
    return ceaMaiBuna;
  }
}
