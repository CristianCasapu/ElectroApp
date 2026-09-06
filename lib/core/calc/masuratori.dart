import 'dart:math';

import 'echipamente.dart';
import 'verdict.dart';

/// Etapa în care se face măsurătoarea.
enum FazaMasuratoare {
  releveu('releveu', 'La releveu (instalația existentă)'),
  pif('pif', 'La punerea în funcțiune'),
  service('service', 'La service / revizie');

  const FazaMasuratoare(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static FazaMasuratoare dinCod(String? cod) =>
      values.firstWhere((f) => f.cod == cod, orElse: () => releveu);
}

enum VerdictMasuratoare {
  conform('conform', 'Conform'),
  neconform('neconform', 'Neconform'),
  informativ('informativ', 'Informativ');

  const VerdictMasuratoare(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static VerdictMasuratoare dinCod(String? cod) =>
      values.firstWhere((v) => v.cod == cod, orElse: () => informativ);
}

/// Tipurile de măsurători, cu unitatea, faza în care apar și referința
/// normativă. Limitele sunt evaluate de [EvaluatorMasuratori].
enum TipMasuratoare {
  // ── la releveu, pe instalația existentă ─────────────────────────────────
  tensiuneFazaNul('u_fn', 'Tensiune fază-nul', 'V', 'I7-2011'),
  tensiuneFazaFaza('u_ff', 'Tensiune între faze', 'V', 'I7-2011'),
  succesiuneFaze('succesiune', 'Succesiunea fazelor', '', 'I7-2011'),
  curentFaza('i_faza', 'Curent pe fază', 'A', 'I7-2011'),
  dezechilibruFaze(
    'dezechilibru',
    'Dezechilibru între faze',
    'A',
    'Ord. ANRE 228/2018 art. 12(3)',
  ),
  factorPutere('cos_phi', 'Factor de putere', '', 'I7-2011'),
  thdTensiune('thd_u', 'THD tensiune', '%', 'SR EN 50160'),
  rezistentaPriza('r_priza', 'Rezistența prizei de pământ', 'Ω', 'I7-2011'),
  impedantaBucla('zs', 'Impedanța buclei de defect', 'Ω', 'I7-2011'),
  curentScurtcircuit('ik', 'Curent de scurtcircuit prezumat', 'kA', 'I7-2011'),
  continuitatePe(
    'continuitate_pe',
    'Continuitate conductor PE',
    'Ω',
    'I7-2011',
  ),
  izolatieInstalatie('riso_ac', 'Rezistență de izolație (AC)', 'MΩ', 'I7-2011'),
  timpDeclansareDdr('t_ddr', 'Timp de declanșare DDR', 'ms', 'I7-2011'),
  curentDeclansareDdr('i_ddr', 'Curent de declanșare DDR', 'mA', 'I7-2011'),

  // ── la punerea în funcțiune, IEC 62446-1 categoria 1 ────────────────────
  continuitateEchipotential(
    'continuitate_rame',
    'Continuitate echipotențializare rame',
    'Ω',
    'IEC 62446-1',
  ),
  polaritate('polaritate', 'Verificare polaritate', '', 'IEC 62446-1'),
  vocString('voc', 'Voc string', 'V', 'IEC 62446-1'),
  iscString('isc', 'Isc string', 'A', 'IEC 62446-1'),
  curentFunctionareString(
    'i_string',
    'Curent de funcționare string',
    'A',
    'IEC 62446-1',
  ),
  izolatieDc('riso_dc', 'Rezistență de izolație DC', 'MΩ', 'IEC 62446-1'),
  pornireInvertor('pornire', 'Pornirea invertorului', '', 'IEC 62446-1'),
  antiInsularizare(
    'anti_islanding',
    'Test anti-islanding',
    '',
    'Ord. ANRE 228/2018',
  ),
  limitareExport(
    'limitare_export',
    'Limitarea puterii evacuate',
    '',
    'ATR · Ord. 19/2022',
  ),
  decuplarePompieri('decuplare', 'Decuplare pompieri', '', 'P118-1/2025');

  const TipMasuratoare(this.cod, this.eticheta, this.unitate, this.referinta);
  final String cod;
  final String eticheta;
  final String unitate;
  final String referinta;

  static TipMasuratoare dinCod(String? cod) =>
      values.firstWhere((t) => t.cod == cod, orElse: () => tensiuneFazaNul);

  /// Măsurătorile fără valoare numerică: se bifează conform sau neconform.
  bool get esteBifa => unitate.isEmpty;

  /// Ținta este un string fotovoltaic, deci se cere numărul lui.
  bool get esteDeString =>
      this == vocString ||
      this == iscString ||
      this == curentFunctionareString ||
      this == izolatieDc ||
      this == polaritate;

  static List<TipMasuratoare> pentruFaza(FazaMasuratoare f) => switch (f) {
    FazaMasuratoare.releveu => const [
      tensiuneFazaNul,
      tensiuneFazaFaza,
      succesiuneFaze,
      curentFaza,
      dezechilibruFaze,
      factorPutere,
      thdTensiune,
      rezistentaPriza,
      impedantaBucla,
      curentScurtcircuit,
      continuitatePe,
      izolatieInstalatie,
      timpDeclansareDdr,
      curentDeclansareDdr,
    ],
    FazaMasuratoare.pif => const [
      continuitateEchipotential,
      polaritate,
      vocString,
      iscString,
      curentFunctionareString,
      izolatieDc,
      rezistentaPriza,
      impedantaBucla,
      timpDeclansareDdr,
      pornireInvertor,
      antiInsularizare,
      limitareExport,
      decuplarePompieri,
    ],
    FazaMasuratoare.service => values,
  };
}

/// O măsurătoare în forma în care o evaluăm (independent de baza de date).
class MasuratoareIntrare {
  final TipMasuratoare tip;
  final double? valoare;
  final double? iradiantaWM2;
  final double? temperaturaModulC;
  final double? tensiuneTestV;
  final String tinta;

  const MasuratoareIntrare({
    required this.tip,
    this.valoare,
    this.iradiantaWM2,
    this.temperaturaModulC,
    this.tensiuneTestV,
    this.tinta = '',
  });
}

/// Regulile de conformitate pentru măsurători (IEC 62446-1, I7-2011,
/// Ord. ANRE 228/2018). Fiecare verdict poartă limita și referința.
class EvaluatorMasuratori {
  EvaluatorMasuratori._();

  /// Tensiunea de test a rezistenței de izolație, după tensiunea sistemului
  /// (IEC 62446-1): 250 V sub 120 V, 500 V până la 500 V, 1000 V peste.
  static double tensiuneTestRiso(double usysV) {
    if (usysV < 120) return 250;
    if (usysV <= 500) return 500;
    return 1000;
  }

  /// Limita minimă a rezistenței de izolație: 0,5 MΩ sub 120 V, 1 MΩ în rest.
  static double limitaRisoMOhm(double usysV) => usysV < 120 ? 0.5 : 1.0;

  /// Corecția Voc de la condițiile de măsurare la STC:
  /// `Voc(STC) = Voc(măsurat) / (1 + β/100 · (Tcell − 25))`.
  static double vocLaStc({
    required double vocMasurat,
    required double temperaturaModulC,
    required double betaPctK,
  }) {
    final factor = 1 + betaPctK / 100 * (temperaturaModulC - 25);
    return factor.abs() < 1e-6 ? vocMasurat : vocMasurat / factor;
  }

  /// Corecția Isc la STC: `Isc(STC) = Isc(măsurat) · 1000 / G`, cu ajustarea
  /// de temperatură prin coeficientul α.
  static double iscLaStc({
    required double iscMasurat,
    required double iradiantaWM2,
    required double temperaturaModulC,
    required double alfaPctK,
  }) {
    if (iradiantaWM2 <= 0) return iscMasurat;
    final laG = iscMasurat * 1000 / iradiantaWM2;
    final factor = 1 + alfaPctK / 100 * (temperaturaModulC - 25);
    return factor.abs() < 1e-6 ? laG : laG / factor;
  }

  /// Evaluează o măsurătoare față de valorile așteptate ale sistemului.
  ///
  /// [vocAsteptatV] și [iscAsteptatA] sunt valorile de fișă ale string-ului
  /// (Ns × Voc, respectiv Isc), iar [tensiuneSistemV] tensiunea maximă DC.
  static Verdict evalueaza(
    MasuratoareIntrare m, {
    double? vocAsteptatV,
    double? iscAsteptatA,
    double tensiuneSistemV = 600,
    ModulPV? modul,
    double toleranta = 0.05,
    double dezechilibruMaxA = 16,
  }) {
    final v = m.valoare;
    final t = m.tip;
    Verdict rezultat(NivelVerdict nivel, String detaliu) => Verdict(
      cod: t.cod,
      titlu: [t.eticheta, if (m.tinta.isNotEmpty) m.tinta].join(' — '),
      nivel: nivel,
      detaliu: detaliu,
      referinta: t.referinta,
    );

    if (t.esteBifa) {
      return rezultat(
        v == null || v > 0 ? NivelVerdict.conform : NivelVerdict.neconform,
        v == null || v > 0 ? 'verificat, funcționează' : 'nu funcționează',
      );
    }
    if (v == null) {
      return rezultat(NivelVerdict.informativ, 'fără valoare');
    }

    switch (t) {
      case TipMasuratoare.izolatieDc:
        final usys = m.tensiuneTestV ?? tensiuneSistemV;
        final limita = limitaRisoMOhm(usys);
        final utest = tensiuneTestRiso(usys);
        return rezultat(
          v >= limita ? NivelVerdict.conform : NivelVerdict.neconform,
          '${v.toStringAsFixed(2)} MΩ, limită ≥ ${limita.toStringAsFixed(1)} MΩ '
          'la ${utest.toStringAsFixed(0)} V DC',
        );
      case TipMasuratoare.izolatieInstalatie:
        return rezultat(
          v >= 1.0 ? NivelVerdict.conform : NivelVerdict.neconform,
          '${v.toStringAsFixed(2)} MΩ, limită ≥ 1 MΩ la 500 V',
        );
      case TipMasuratoare.rezistentaPriza:
        return rezultat(
          v <= 4
              ? NivelVerdict.conform
              : (v <= 10 ? NivelVerdict.atentie : NivelVerdict.neconform),
          '${v.toStringAsFixed(2)} Ω — uzual ≤ 4 Ω; peste 10 Ω se completează priza',
        );
      case TipMasuratoare.continuitatePe:
      case TipMasuratoare.continuitateEchipotential:
        return rezultat(
          v <= 1 ? NivelVerdict.conform : NivelVerdict.neconform,
          '${v.toStringAsFixed(2)} Ω, limită ≤ 1 Ω',
        );
      case TipMasuratoare.vocString:
        if (vocAsteptatV == null || vocAsteptatV <= 0) {
          return rezultat(NivelVerdict.informativ, '${v.toStringAsFixed(1)} V');
        }
        final corectat = (m.temperaturaModulC != null && modul != null)
            ? vocLaStc(
                vocMasurat: v,
                temperaturaModulC: m.temperaturaModulC!,
                betaPctK: modul.betaVocPctK,
              )
            : v;
        final abatere = (corectat - vocAsteptatV) / vocAsteptatV;
        return rezultat(
          abatere.abs() <= toleranta
              ? NivelVerdict.conform
              : (abatere.abs() <= 2 * toleranta
                    ? NivelVerdict.atentie
                    : NivelVerdict.neconform),
          '${v.toStringAsFixed(1)} V măsurat'
          '${corectat == v ? '' : ', corectat ${corectat.toStringAsFixed(1)} V la STC'}, '
          'așteptat ${vocAsteptatV.toStringAsFixed(1)} V '
          '(abatere ${(abatere * 100).toStringAsFixed(1)} %)',
        );
      case TipMasuratoare.iscString:
        if (iscAsteptatA == null || iscAsteptatA <= 0) {
          return rezultat(NivelVerdict.informativ, '${v.toStringAsFixed(2)} A');
        }
        final corectat = (m.iradiantaWM2 != null && modul != null)
            ? iscLaStc(
                iscMasurat: v,
                iradiantaWM2: m.iradiantaWM2!,
                temperaturaModulC: m.temperaturaModulC ?? 25,
                alfaPctK: modul.alfaIscPctK,
              )
            : v;
        final abatere = (corectat - iscAsteptatA) / iscAsteptatA;
        return rezultat(
          abatere.abs() <= 0.10
              ? NivelVerdict.conform
              : (abatere.abs() <= 0.20
                    ? NivelVerdict.atentie
                    : NivelVerdict.neconform),
          '${v.toStringAsFixed(2)} A măsurat'
          '${corectat == v ? '' : ', corectat ${corectat.toStringAsFixed(2)} A la STC'}, '
          'așteptat ${iscAsteptatA.toStringAsFixed(2)} A '
          '(abatere ${(abatere * 100).toStringAsFixed(1)} %)',
        );
      case TipMasuratoare.dezechilibruFaze:
        return rezultat(
          v <= dezechilibruMaxA ? NivelVerdict.conform : NivelVerdict.neconform,
          '${v.toStringAsFixed(1)} A, limită ≤ ${dezechilibruMaxA.toStringAsFixed(0)} A '
          'între faze la injecție',
        );
      case TipMasuratoare.tensiuneFazaNul:
        final abatere = (v - 230) / 230;
        return rezultat(
          abatere.abs() <= 0.10 ? NivelVerdict.conform : NivelVerdict.atentie,
          '${v.toStringAsFixed(0)} V, admis 230 V ± 10 % (207–253 V)',
        );
      case TipMasuratoare.tensiuneFazaFaza:
        final abatere = (v - 400) / 400;
        return rezultat(
          abatere.abs() <= 0.10 ? NivelVerdict.conform : NivelVerdict.atentie,
          '${v.toStringAsFixed(0)} V, admis 400 V ± 10 % (360–440 V)',
        );
      case TipMasuratoare.thdTensiune:
        return rezultat(
          v <= 8 ? NivelVerdict.conform : NivelVerdict.atentie,
          '${v.toStringAsFixed(1)} %, uzual ≤ 8 %',
        );
      case TipMasuratoare.timpDeclansareDdr:
        return rezultat(
          v <= 300 ? NivelVerdict.conform : NivelVerdict.neconform,
          '${v.toStringAsFixed(0)} ms, limită ≤ 300 ms la IΔn',
        );
      case TipMasuratoare.curentDeclansareDdr:
        return rezultat(
          v <= 30 ? NivelVerdict.conform : NivelVerdict.atentie,
          '${v.toStringAsFixed(0)} mA — un DDR de 30 mA declanșează între 15 și 30 mA',
        );
      case TipMasuratoare.impedantaBucla:
        return rezultat(
          NivelVerdict.informativ,
          '${v.toStringAsFixed(2)} Ω, Ik ≈ ${(230 / max(v, 0.01) / 1000).toStringAsFixed(2)} kA',
        );
      default:
        return rezultat(
          NivelVerdict.informativ,
          '${v.toStringAsFixed(2)} ${t.unitate}'.trim(),
        );
    }
  }

  /// Măsurătorile din categoria 1 IEC 62446-1 care trebuie să existe într-un
  /// dosar complet de punere în funcțiune.
  static const obligatoriiPif = [
    TipMasuratoare.continuitateEchipotential,
    TipMasuratoare.polaritate,
    TipMasuratoare.vocString,
    TipMasuratoare.iscString,
    TipMasuratoare.izolatieDc,
    TipMasuratoare.pornireInvertor,
  ];

  /// Ce lipsește din setul obligatoriu, pe baza tipurilor deja măsurate.
  static List<TipMasuratoare> lipsuriPif(Iterable<TipMasuratoare> existente) {
    final set = existente.toSet();
    return obligatoriiPif.where((t) => !set.contains(t)).toList();
  }
}
