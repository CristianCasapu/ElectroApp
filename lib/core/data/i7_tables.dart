// Tabele I7-2011 (Anexa 5.18/5.19 curenți admisibili, factori de corecție,
// rezistivități) — preluate din ElectroCalc (lib/core/data/i7_tables.dart).
// Tabele din Normativul I7-2011 — Curenți admisibili și calcule

// ── Curenți admisibili (A) pentru conductoare Cu cu izolație PVC
// Conform Anexa 5.10 din I7-2011
// Key: secțiune mm², Value: Map<modPozare, curentAdmisibil>
final Map<double, Map<String, double>> curentAdmisibilPvcCu = {
  1.5: {
    'A': 13.5,
    'B1': 15.5,
    'B2': 13.0,
    'C': 17.5,
    'D': 18.0,
    'E': 19.5,
    'F': 19.5,
  },
  2.5: {
    'A': 18.0,
    'B1': 21.0,
    'B2': 18.0,
    'C': 24.0,
    'D': 24.0,
    'E': 27.0,
    'F': 27.0,
  },
  4.0: {
    'A': 24.0,
    'B1': 28.0,
    'B2': 24.0,
    'C': 32.0,
    'D': 31.0,
    'E': 36.0,
    'F': 36.0,
  },
  6.0: {
    'A': 31.0,
    'B1': 36.0,
    'B2': 31.0,
    'C': 41.0,
    'D': 39.0,
    'E': 46.0,
    'F': 46.0,
  },
  10.0: {
    'A': 42.0,
    'B1': 50.0,
    'B2': 42.0,
    'C': 57.0,
    'D': 52.0,
    'E': 63.0,
    'F': 63.0,
  },
  16.0: {
    'A': 56.0,
    'B1': 68.0,
    'B2': 56.0,
    'C': 76.0,
    'D': 67.0,
    'E': 85.0,
    'F': 85.0,
  },
  25.0: {
    'A': 73.0,
    'B1': 89.0,
    'B2': 73.0,
    'C': 99.0,
    'D': 86.0,
    'E': 112.0,
    'F': 112.0,
  },
  35.0: {
    'A': 89.0,
    'B1': 110.0,
    'B2': 89.0,
    'C': 121.0,
    'D': 103.0,
    'E': 138.0,
    'F': 138.0,
  },
  50.0: {
    'A': 108.0,
    'B1': 134.0,
    'B2': 108.0,
    'C': 150.0,
    'D': 122.0,
    'E': 168.0,
    'F': 168.0,
  },
  70.0: {
    'A': 136.0,
    'B1': 171.0,
    'B2': 136.0,
    'C': 192.0,
    'D': 151.0,
    'E': 213.0,
    'F': 213.0,
  },
  95.0: {
    'A': 164.0,
    'B1': 207.0,
    'B2': 164.0,
    'C': 232.0,
    'D': 179.0,
    'E': 258.0,
    'F': 258.0,
  },
  120.0: {
    'A': 188.0,
    'B1': 239.0,
    'B2': 188.0,
    'C': 269.0,
    'D': 203.0,
    'E': 299.0,
    'F': 299.0,
  },
  150.0: {
    'A': 216.0,
    'B1': 272.0,
    'B2': 216.0,
    'C': 309.0,
    'D': 230.0,
    'E': 344.0,
    'F': 344.0,
  },
  185.0: {
    'A': 245.0,
    'B1': 310.0,
    'B2': 245.0,
    'C': 353.0,
    'D': 258.0,
    'E': 392.0,
    'F': 392.0,
  },
  240.0: {
    'A': 286.0,
    'B1': 365.0,
    'B2': 286.0,
    'C': 415.0,
    'D': 294.0,
    'E': 461.0,
    'F': 461.0,
  },
};

// ── Curenți admisibili (A) pentru conductoare Cu cu izolație XLPE
// Conform Anexa 5.13 din I7-2011
final Map<double, Map<String, double>> curentAdmisibilXlpeCu = {
  1.5: {
    'A': 17.5,
    'B1': 19.5,
    'B2': 17.5,
    'C': 22.0,
    'D': 22.0,
    'E': 24.0,
    'F': 24.0,
  },
  2.5: {
    'A': 23.0,
    'B1': 26.0,
    'B2': 23.0,
    'C': 30.0,
    'D': 29.0,
    'E': 33.0,
    'F': 33.0,
  },
  4.0: {
    'A': 31.0,
    'B1': 35.0,
    'B2': 31.0,
    'C': 40.0,
    'D': 38.0,
    'E': 45.0,
    'F': 45.0,
  },
  6.0: {
    'A': 40.0,
    'B1': 45.0,
    'B2': 40.0,
    'C': 51.0,
    'D': 47.0,
    'E': 58.0,
    'F': 58.0,
  },
  10.0: {
    'A': 54.0,
    'B1': 61.0,
    'B2': 54.0,
    'C': 70.0,
    'D': 63.0,
    'E': 80.0,
    'F': 80.0,
  },
  16.0: {
    'A': 73.0,
    'B1': 81.0,
    'B2': 73.0,
    'C': 94.0,
    'D': 81.0,
    'E': 107.0,
    'F': 107.0,
  },
  25.0: {
    'A': 95.0,
    'B1': 106.0,
    'B2': 95.0,
    'C': 119.0,
    'D': 103.0,
    'E': 138.0,
    'F': 138.0,
  },
  35.0: {
    'A': 117.0,
    'B1': 131.0,
    'B2': 117.0,
    'C': 148.0,
    'D': 125.0,
    'E': 171.0,
    'F': 171.0,
  },
  50.0: {
    'A': 141.0,
    'B1': 158.0,
    'B2': 141.0,
    'C': 180.0,
    'D': 148.0,
    'E': 209.0,
    'F': 209.0,
  },
  70.0: {
    'A': 179.0,
    'B1': 200.0,
    'B2': 179.0,
    'C': 232.0,
    'D': 183.0,
    'E': 269.0,
    'F': 269.0,
  },
  95.0: {
    'A': 216.0,
    'B1': 241.0,
    'B2': 216.0,
    'C': 282.0,
    'D': 216.0,
    'E': 328.0,
    'F': 328.0,
  },
  120.0: {
    'A': 249.0,
    'B1': 278.0,
    'B2': 249.0,
    'C': 328.0,
    'D': 246.0,
    'E': 382.0,
    'F': 382.0,
  },
  150.0: {
    'A': 285.0,
    'B1': 318.0,
    'B2': 285.0,
    'C': 379.0,
    'D': 278.0,
    'E': 441.0,
    'F': 441.0,
  },
};

// ── Factori de corecție temperatură ambiantă (K1) — Anexa 5.18
// Key: temperatura °C
const Map<int, Map<String, double>> factoriCorrTemp = {
  10: {'PVC': 1.22, 'XLPE': 1.15},
  15: {'PVC': 1.17, 'XLPE': 1.12},
  20: {'PVC': 1.12, 'XLPE': 1.08},
  25: {'PVC': 1.06, 'XLPE': 1.04},
  30: {'PVC': 1.00, 'XLPE': 1.00},
  35: {'PVC': 0.94, 'XLPE': 0.96},
  40: {'PVC': 0.87, 'XLPE': 0.91},
  45: {'PVC': 0.79, 'XLPE': 0.87},
  50: {'PVC': 0.71, 'XLPE': 0.82},
  55: {'PVC': 0.61, 'XLPE': 0.76},
  60: {'PVC': 0.50, 'XLPE': 0.71},
  65: {'PVC': 0.00, 'XLPE': 0.65},
  70: {'PVC': 0.00, 'XLPE': 0.58},
  75: {'PVC': 0.00, 'XLPE': 0.50},
  80: {'PVC': 0.00, 'XLPE': 0.41},
};

// ── Factori de corecție grupare circuite — Anexa 5.19
// Key: număr circuite
const Map<int, Map<String, double>> factoriCorrGrupare = {
  1: {'A_B': 1.00, 'C': 1.00, 'D': 1.00},
  2: {'A_B': 0.80, 'C': 0.85, 'D': 0.80},
  3: {'A_B': 0.70, 'C': 0.79, 'D': 0.70},
  4: {'A_B': 0.65, 'C': 0.75, 'D': 0.65},
  5: {'A_B': 0.60, 'C': 0.73, 'D': 0.60},
  6: {'A_B': 0.57, 'C': 0.72, 'D': 0.57},
  7: {'A_B': 0.54, 'C': 0.72, 'D': 0.54},
  8: {'A_B': 0.52, 'C': 0.71, 'D': 0.52},
  9: {'A_B': 0.50, 'C': 0.70, 'D': 0.50},
  10: {'A_B': 0.48, 'C': 0.70, 'D': 0.48},
  12: {'A_B': 0.45, 'C': 0.69, 'D': 0.45},
  14: {'A_B': 0.43, 'C': 0.68, 'D': 0.43},
  16: {'A_B': 0.41, 'C': 0.68, 'D': 0.41},
  20: {'A_B': 0.38, 'C': 0.68, 'D': 0.38},
};

// ── Rezistivitatea conductoarelor (Ω·mm²/m la 70°C)
const Map<String, double> rezistivitate = {
  'Cu': 0.0225, // cupru la 70°C
  'Al': 0.036, // aluminiu la 70°C
};

// ── Reactanța circuitelor tipice (Ω/m)
const double reactantaCircuit = 0.00008; // 0.08 mΩ/m pentru cabluri obișnuite

// ── Secțiuni standard disponibile (mm²)
final List<double> sectiuniStandard = [
  1.5,
  2.5,
  4.0,
  6.0,
  10.0,
  16.0,
  25.0,
  35.0,
  50.0,
  70.0,
  95.0,
  120.0,
  150.0,
  185.0,
  240.0,
];

// ── Curenți nominali disjunctoare standard (A)
const List<int> curentNominalDisjunctor = [
  6,
  10,
  13,
  16,
  20,
  25,
  32,
  40,
  50,
  63,
  80,
  100,
  125,
  160,
  200,
  250,
];

// ── Moduri de pozare (conform I7 Anexa 5.5)
const Map<String, String> modPozareDescriptii = {
  'A': 'Conductoare în tub izolant îngropat în perete termoizolant',
  'B1': 'Conductoare în tub pe perete sau conductoare multiconductoare',
  'B2': 'Cabluri multiconductoare în tub pe perete',
  'C': 'Cabluri multiconductoare pe perete sau pardoseală',
  'D': 'Cabluri multiconductoare în pământ',
  'E': 'Cabluri multiconductoare în aer liber (pe paturi de cabluri)',
  'F': 'Cabluri monoconductoare în aer liber (pe paturi de cabluri)',
  'G': 'Cabluri monoconductoare libere în aer',
};

// ── Cadere de tensiune maximă admisă (%) conform I7 art. 5.2.5
const Map<String, double> cadereTensiuneMaxima = {
  'iluminat': 3.0, // 3% pentru iluminat
  'forta': 5.0, // 5% pentru prize/forță
  'iluminat_special': 6.0, // 6% pentru iluminat industrial special
};

// ── Coeficienti simultaneitate conform I7 cap. 3.2
const Map<String, double> coeficientiSimultaneitate = {
  'locuinta_1cam': 1.0,
  'locuinta_2cam': 0.75,
  'locuinta_3cam': 0.65,
  'locuinta_4cam': 0.60,
  'locuinta_5cam+': 0.55,
  'birouri_mici': 0.70,
  'birouri_mari': 0.60,
  'comercial': 0.80,
  'industrial': 0.75,
};
