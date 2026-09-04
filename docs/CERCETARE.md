# ElectroApp — cercetare și plan de arhitectură (surse publice, 04.09.2026)

> Copie a planului aprobat din sesiunea de planificare Claude Code. Sursa de adevăr pentru
> deciziile ulterioare; se actualizează odată cu evoluția legislației (vezi „Lacune de verificat").


> Stare: **mod planificare**, fără cod scris (04.09.2026). Cercetarea din surse publice și explorarea
> proiectelor existente sunt complete. La aprobare, primul pas concret este **E0** din §4.4 și
> copierea acestui document în `ElectroApp/docs/CERCETARE.md` (cu secțiunile 3.x) ca referință a
> proiectului.
>
> **Întrebări deschise pentru proprietar (nu blochează E0):**
> 1. Aplicația e doar pentru prietenul electrician (single-user) sau va fi distribuită (Play Store,
>    licențiere ca ElectroCalc)? Influențează licența Open-Meteo, analytics, update mecanism.
> 2. Integrarea cu electroprep.ro: (a) doar sync de date în API, (b) sau serviciile PDF (DIU, PV
>    recepție) se generează server-side prin motorul Etapa V? Recomandare: (b) în v2, PDF local în MVP.
> 3. Nume/applicationId: `ro.ccii.electroapp`? Numele public al aplicației?

## 1. Context

- Aplicație Android nativă (Flutter/Dart) pentru un electrician care montează sisteme
  fotovoltaice de toate dimensiunile: monofazic, trifazic, stocare (hibrid/off-grid),
  injecție în rețea JT / MT / (probabil) IT.
- Scop: pe fiecare site (șantier/client) — **măsurători** (survey, date tablou, contor,
  teste PIF conform IEC 62446) și **dimensionări** (string-uri, invertor, cabluri,
  protecții, stocare, racordare), cu raport/ofertă PDF.
- Va fi probabil integrat ulterior în **electroprep.ro** (monorepo local
  `../electroprep-release`: FastAPI + Flutter + React).
- Directorul `ElectroApp/` este gol; nu este încă repo git.

## 2. Ce există deja (refolosibil)

### 2.1 Mediu de dezvoltare (verificat)
- Flutter 3.44.0 stable, Dart 3.12.0, Android SDK 36.1.0, JDK OK, 3 device-uri conectate.
- `gh` autentificat ca `CristianCasapu`.
- Repo electroprep.ro = **`CristianCasapu/ChestionareElectricianANRE`** (privat); worktree local
  `../electroprep-release`. Local mai există: `../ElectroCalc` (Flutter), `../necmat` (Kotlin/Compose).

### 2.2 ElectroCalc (`../ElectroCalc`, Flutter, ~69k linii Dart, repo privat `CristianCasapu/ElectroCalc`)
Aplicație pentru electricieni: calculatoare I7-2011, estimări, oferte PDF, clienți, facturare 2invoice,
backup Google Drive. Stack: sqflite (schema v28, migrări non-destructive), `setState` + singletoane
(fără Riverpod/Provider real), `pdf`+`printing`, `share_plus`, `google_sign_in`, hard-coded RO.

**Copiază aproape ca atare:**
- `lib/theme/app_theme.dart` + `lib/theme/app_colors.dart` (Material 3, tokeni semantici pe BuildContext).
- `lib/widgets/calc_widgets.dart` (`CalcSegmented`, `CalcNumberField`, `FormulaInfoTile`,
  `CalcSectionTitle`, `CalcButton`) + `lib/widgets/result_card.dart` — kit UI de calculator.
- `lib/core/data/localitati_romania.dart` (42 județe, localități ≥2000 loc., helpers autocomplete).
- `lib/core/services/osm_service.dart` (Nominatim geocode RO + OSRM distanță) — se extinde cu lat/lon
  pentru PVGIS.
- `lib/core/services/{update,drive_backup,auth,log,toast,analytics}_service.dart`, `pdf_security.dart`,
  `lib/core/utils/financial_utils.dart`, `client_picker_sheet.dart`, `contact_picker_button.dart`.
- `scripts/` (build_release.ps1, release.ps1, pre_release_check.ps1) + `.github/workflows/release.yml`
  (atenție: CI scrie `key.properties`, gradle citește `key_electrocalc.properties` — de corectat).
- `CLAUDE.md` ca șablon de convenții (versionare `MAJOR.MINOR.PATCH+BUILD` → tag `vMAJOR.MINOR.BUILD`,
  CHANGELOG obligatoriu, culori doar prin `app_colors.dart`, fără comentarii inutile).

**Portează cu adaptare:**
- Motorul pur `lib/core/calculations/cable_calculator.dart` (`calcCurentSarcina`, `calcSectiune`,
  `calcCadereTensiune`, `alegereSiguranta`; `I_dim = I_calc/(k1·k2)`; ΔU mono `2·I·(R cosφ + X·L sinφ)`,
  trifazat `√3·I·(…)`) + testele `test/calculations/cable_calculator_test.dart` (~40 teste).
- Tabelele `lib/core/data/i7_tables.dart`: `curentAdmisibilPvcCu/XlpeCu` per mod pozare A–F,
  `factoriCorrTemp`, `factoriCorrGrupare`, `rezistivitate {Cu:0.0225, Al:0.036}` (70 °C),
  `reactantaCircuit 0.00008 Ω/m`, `sectiuniStandard`, `curentNominalDisjunctor`,
  `cadereTensiuneMaxima`. Conține deja categoria de prețuri **`Fotovoltaice`** (PV01–PV06) și wallbox.
- Modele (`lib/core/models/models.dart`): `Client` (reutilizabil verbatim), `Numaratoare` (≈ fișă de
  șantier: `tipBransament mono/trifazic`, `putereInstalata`, `localitate/judet`, `status`, `pdfPath`,
  `alteCosturi`, `tva`, `discount`) → devine `Sit/Proiect` cu `List<Suprafata>` (acoperișuri) în loc de
  camere; `Oferta`/`OfertaLinie`/`PretManopera`, `SetariAplicatie` (date firmă, atestate ANRE, semnătură,
  ștampilă). Stil `toMap/fromMap` manual, fără codegen.
- `DatabaseHelper` (singleton + `_onUpgrade` versionat + setări KV cu prefix `set.`) — schema PV nouă de la v1.
- `lib/screens/estimare/estimare_pdf_service.dart` (MultiPage A4, header firmă, footer atestat ANRE,
  fonturi Noto pentru diacritice, salvare + share bottom sheet) ca schelet de raport.
- Calculatoare cu logica în ecran (fără teste) — de extras în `core/calculations/` dacă se preiau:
  impedanță/Ik (`impedanta_screen.dart`), conductor PE (tab. 54.2/54.3, `S_min = I·√t/k`),
  compensare cosφ, motor, tablou (module DIN + rezervă).

**Nu prelua:** dependențele moarte (`provider`, `fl_chart`, `dropdown_search`, `flutter_slidable`, `uuid`,
`permission_handler`), ecranele de 3000–4300 linii, formulele îngropate în `_calculeaza()`.

### 2.3 electroprep.ro (`../electroprep-release`, repo `ChestionareElectricianANRE`)
Monorepo: `api/` FastAPI (Python 3.12, SQLAlchemy 2 async, Postgres 16, Redis, Alembic — ultima
migrare `0061`), `app/` Flutter **3.24.3** (Riverpod 2 + go_router + Dio, exclusiv online), `web/`
React 19 + Vite + Tailwind 4, `content/normative/` (25 JSON: I7 = 1527 articole, NTE 001–013 etc.).
Auth: JWT access 15 min (EdDSA) + refresh 30 zile cu rotație și detecție reuse. CI = `./test-and-deploy.sh`
pe server; GitHub doar `release.yml` la tag `v*`. Convenții: docs/comentarii în română; **interzisă
reproducerea textului standardelor SR EN/SR HD (ASRO)** — doar citarea numărului; o singură cheie de
semnare (`app/android/release-cert.sha256`, rezervată ElectroPrep — aplicația PV are nevoie de
**applicationId și keystore proprii**).

**Active PV deja existente în electroprep (de refolosit, nu reconstruit):**
- **Motor de documente (Etapa V)**: servicii ca DATE (`service_definitions`/`service_versions`,
  `api/app/assets/services_seed.json`), layout JSON declarativ, PDF determinist (SHA-256 stabil), DejaVu
  pentru diacritice. Există `dosar-prosumator` și `notificare-prosumator-loc-existent` ancorate în
  **Ord. ANRE 19/2022** (procedura racordare prosumatori: cap. III loc nou → ATR → contract → dosar → PIF →
  certificat; cap. IV loc existent → notificare Anexa 2; plafon **400 kW/loc de consum**; art. 19(1)
  dosar: PV recepție, **buletin priză de pământ**, certificate conformitate + fișe tehnice invertor/stocare,
  **schemă monofilară obligatorie**; art. 24(2)(b) electricianul ca împuternicit) + **Ord. 228/2018**.
  ATR/certificat de racordare sunt *intrări* (poze citite prin extracție), nu ieșiri.
- **Extracție din poze (V3)**: clase de poze declarate, CI refuzate, re-encodare fără EXIF, quote verbatim,
  redactare CNP, cote 3/zi free – 30/zi premium. Tip upload `"atr"` există (`services_extract.py:49`).
- **Editor scheme (Z9)**: `api/app/services/schematics_check.py` — verificări I7 deterministe cu
  `Finding`/`Ref(doc, cod)` spre `i7.json`: `IZ_B1_CU` (Cu/PVC, B1, 30 °C), `MIN_SECTION`, `MAX_DROP_PCT`
  (3 %/5 %), `NEEDS_RCD`, `RHO_CU 0.0175`, `voltage_drop_pct()`. Extensibil cu reguli DC (string vs MPPT,
  Isc×1.25, ΔU DC ≤1 %). Librării permise (MIT): `@xyflow/react`, `konva`, `dagre`, `schemdraw`, `ezdxf`.
- **Șablon disciplină AI (Etapa P)**: LLM doar clasifică/extrage; verdictul e calculat în cod; orice
  constatare citează un articol existent + quote verbatim verificat.
- Flutter: `app/lib/core/api_client.dart` (Dio + refresh single-flight), `token_store.dart`, schelet
  Riverpod/go_router, `scripts/build-android.sh`, `verify-apk-signature.sh`.
- I7 acoperă explicit PV: art. 1.1 lit. i) „instalațiilor fotoelectrice aferente clădirilor", 5.6.3.1.1,
  7.11.1.

**Ce NU există nicăieri (nou de construit):** cameră/`image_picker`, geolocație, stocare offline-first,
geometrie acoperiș (azimut/înclinare), date de iradiere (PVGIS), calculatoare de dimensionare PV
(string/invertor/stocare/racordare), teste PIF IEC 62446.

**Cale de integrare cu electroprep.ro (ulterior):** modul `pv` în API (`api/app/models/pv.py`,
`api/app/api/v1/pv.py`, migrare `0062`, doar endpoint-uri noi — fără câmpuri obligatorii noi pe
endpoint-uri publice) sau definiții de servicii noi fără cod; motorul de calcul Dart poate fi oglindit în
Python pentru verificări server-side.

## 3. Cercetare surse publice

### 3.1 Cadrul legislativ / normativ RO + UE (cercetat 04.09.2026)

> Toate valorile de mai jos se modelează în aplicație ca **parametri configurabili cu dată de
> valabilitate** (tabel `reguli`), nu ca constante — cadrul se schimbă frecvent (ANRE are termen
> ~24.09.2026 să modifice Ord. 15/2022). Marcaje: [verificat] / [incert].

**Regim prosumator (Legea 123/2012 art. 73¹, OUG 143/2021, Legea 160/2026 în vigoare 26.07.2026):**
| Prag putere instalată / loc de consum | Mecanism |
|---|---|
| ≤ 27 kW (PF) | compensare cantitativă **lunară** 1:1; surplus la preț contract fără tarife; poate acoperi și gaz la același furnizor; scutit de impozit |
| 27–200 kW (PF/PJ) | compensare cantitativă lunară (formula art. 3 pct. 23¹); furnizorul facturează în numele prosumatorului |
| 200–400 kW | **regularizare financiară** la preț mediu ponderat PZU al lunii; prosumatorul emite factură |
| > 400 kW | producător cu licență ANRE |
- Reportul de 24 luni eliminat → decontare lunară, plată în ≤60 zile. **Sunset 31.12.2030** pentru
  compensarea cantitativă ≤200 kW → toți ≤400 kW trec pe PZU.
- Prosumatorul poate stoca și vinde energia stocată (2026). Statistică ANRE 30.06.2026: 359.378
  prosumatori, 4.019 MW, ~127.000 cu stocare.
- Secundar: Ord. 15/2022 (reguli comerciale, mod. 95/2022), **Ord. 19/2022** (procedură racordare, mod.
  104/2022, 133/2022, 4/2023, 70/2023), **Ord. 228/2018** (normă tehnică), Ord. 59/2013 (regulament
  racordare, mod. 121/2022 … 53/2024 licitație capacitate, 60/2024).
- Câmpuri app: `tier` (≤27/≤200/≤400/>400), `tipClient` PF/PJ, `dataPIF`, `pretContractEnergie`,
  `pretMediuPZU_luna`.

**Proces racordare (Ord. 19/2022 + 59/2013):** cerere la OD + solicitare certificare prosumator →
fișă/studiu de soluție → **ATR** (verificare dosar ≤10 zile lucr., emitere ≤30 zile, valabil 12 luni,
penalitate 100 lei/zi casnici) → contract racordare → execuție → **DIU** + cerere punere sub tensiune →
PV recepție/PIF → **certificat de racordare** („prosumator" la Alte specificații) → contract
vânzare-cumpărare cu furnizorul (10 + 10 zile).
- Tarif ATR (Ord. 114/2014, fără TVA): ≤30 kVA 70 lei; 30–100 kVA 160; >100 kVA 215. Racordare
  orientativ 30 kW: 4.500–9.500 lei. Extras CF nu e necesar ≤400 kW SRE.
- **Fișă vs. studiu de soluție (Ord. 102/2015)** [verificat]: fișă — casnici orice putere, <30 kVA,
  producere JT evidentă, producere MT ≤1 MW evidentă; studiu — ≥110 kV, **>1 MW la MT**, variante multiple.
  Tabel nivel tensiune după putere: <0,03 MVA → 0,4 kV; 0,03–0,1 → 0,4/MT; 0,1–2,5 → 20/10/6/0,4 kV;
  2,5–7,5 → 110/20; 7,5–50 → 110 kV; >50 → 400/220/110. >1 MW: OD poate cere garanție financiară.
- **Monofazat vs trifazat**: regula normativă e **Ord. 228/2018 art. 12(3)** — pe branșament trifazat
  diferența între curenții de fază ≤ **16 A** (≈3,68 kVA) → invertor monofazat max ~3,68 kW pe trifazat;
  pe branșament monofazat OD-urile acceptă în practică ~**5 kW** [incert, fără prag în act] →
  parametru `limitaMonofazat_kW` per OD, implicit 5, cu avertisment. Ord. 228/2018 tratează simplificat
  **≤11 kVA**; detalii în §3.2.
- **DIU (dosar instalație de utilizare)**: CI/CUI, act proprietate, ATR, **schemă monofilară** cu protecții
  și reglaje, fișe tehnice + certificate conformitate invertor (**EN 50549-1**) și module, factură invertor
  (serie), **export setări invertor** (dovada limitării la Sevac), **buletin PRAM** (priză pământ,
  continuitate, izolație), PV PIF semnat de electrician autorizat, atestat ANRE firmă, declarație de
  conformitate execuție. → toate generabile din app (o parte deja în electroprep Etapa V).

**Norme tehnice:**
- **RfG (UE 2016/631 → Ord. ANRE 79/2016)** [verificat]: A 0,8 kW–1 MW; B 1–5 MW; C 5–20 MW; D ≥20 MW
  sau ≥110 kV.
- **Ord. 208/2018** (module generatoare) [verificat]: 47,5–48,5 Hz ≥30 min; 48,5–49 ≥30 min; **49–51 Hz
  nelimitat**; 51–51,5 ≥30 min. RoCoF 2 Hz/s @500 ms, 1,5 @1000 ms, 1,25 @2000 ms. LFSM-O prag
  **50,2 Hz** statism 2–12 % (tipic 5 %); LFSM-U 49,8 Hz (B/C). U 0,9–1,1 Un; reconectare 0,85–1,1 Un;
  rampă 10–30 % Pmax/min. Tip B: DMS-SCADA (P,Q,U,f), LVRT; C/D: EMS-SCADA Transelectrica.
- **Ord. 228/2018** (prosumatori cu injecție, PIF după 27.04.2019) [parțial]: ref. EN 50438/**EN 50549**/
  IEC 61727; reconectare automată doar 47,5–51 Hz și 0,9–1,1 Un după așteptare (normă: max 15 min;
  EN 50549-1: min 60 s) [incert]; contor inteligent; **contor separat pentru stocare**; **≤11 kVA** doar
  cerințe de bază. Valori tipice interfață EN 50549-1 (de confirmat „RO" cu OD): U> 1,10 Un (10 min) /
  1,15 Un ~0,2 s; U< 0,85 Un ~1,5–3 s; f> 51,5; f< 47,5; anti-islanding IEC 62116 → în app „implicit,
  de verificat".
- **I7-2011** (mod. Ord. MDLPA 959/2023: AFDD la originea circuitului; execuție doar după ATR), NTE 007,
  PE 116, NTE 011; **SR HD 60364-7-712**, **IEC 62548** (Voc la Tmin, Isc×1,25, siguranțe string),
  IEC 60364-5-52 (ΔU practică ≤1 % DC, ≤3 % AC), 60364-4-43, **EN 61643-31/32** (SPD PV), IEC 62109,
  IEC 61215/61730. **ASRO: nu reproducem textul standardelor, doar numărul.**
- **IEC 62446-1 (teste PIF)**: Cat. 1 — continuitate PE/echipotențializare, polaritate, **Voc/Isc per
  string** vs STC corectat, funcționalitate, **Riso**: Utest 500 V DC (Usys 120–500 V) / **1000 V DC**
  (500–1000 V), limită **≥1 MΩ**; Cat. 2 — I-V, termografie. Documentație: monofilară, fișe, setări
  protecții, rapoarte.

**Incendiu și urbanism:**
- **Legea 50/1991 art. 11 (mod. Legea 166/2023)**: PV pe acoperiș și la sol pentru autoconsum **fără
  autorizație de construire** dacă nu modifică structura și nu sunt în zone protejate; prag 45 kW
  rezidențial [incert]. Parcuri la sol comerciale/agricol/fundații → CU + AC.
- **P118-1/2025** (aplicabil din mai 2025) [sursă secundară]: locuințe 1–2 niveluri — **1 m** de coamă/
  pereți portanți, **0,5 m** la lucarne/luminatoare, două căi acces ≥1 m/pantă; ≥3 niveluri — 1 m
  perimetru, **2,5 m** la luminatoare/trape fum, **4 m** de pereți antifoc, câmpuri max **40×40 m** cu
  **5 m** între; **decuplare pompieri** identificată; **detecție arc DC**; marcaje; spații tehnice
  invertoare/baterii **REI 180/90**, materiale A1, ventilație forțată; termoizolație necombustibilă sub PV.
  → checklist de survey + verificări automate ale layout-ului.
- Aviz ISU după categoria construcției (HG 571/2016 mod. HG 1181/2022), nu după prezența PV.

**Stocare:**
- **Ord. ANRE 3/2023**: categorii A–D ca RfG; DTIS cu 2 luni (A) / 3 luni (B–D) înainte de PIF;
  **prosumatorii cu invertor hibrid certificat sunt exceptați** de la DTIS completă; stocare adăugată
  fără schimbarea Sevac → limitare automată; LFSM 50,2/49,8 Hz; LVRT B/C; SCADA B+. Proiect de
  modificare feb. 2025.
- **Ord. 56/2025**: scutire tarife rețea pentru energia stocată și reintrodusă (consum propriu/pierderi
  rămân tarifate).
- **Casa Verde Fotovoltaice**: PV min 3 kWp, max 30.000 lei, contribuție min 3.000 lei, instalator validat
  AFM cu atestat ANRE (C1A/C2A sau B), proprietar în CF fără datorii; program panouri suspendat iul. 2026.
- **Casa Verde Baterii 2026** (ghid în consultare 18.08.2026): 400 mil. lei; **75 %**, max **15.000 lei**
  TVA inclus; **min 12 kWh**; cost eligibil max **1.250 lei/kWh**; punctaj 100 p (contribuție 40,
  capacitate 40, putere PV 20).
- Fondul pentru Modernizare: stocare stand-alone 150 mil. EUR, max 15 mil./întreprindere, MySMIS
  1.09–30.10.2026.

**Contorizare și tarife:** contor bidirecțional smart montat de OD în ≤30 zile, gratuit, 15 min;
`P_instalata_DC`, `P_invertor_AC`, **`S_evac_aprobata`** (ATR) + opțiune **zero export** — invertorul
limitat software la Sevac (export setări în DIU). Tarife distribuție JT 2026 (Ord. 77/2025): PPC ~317,
DEER ~355, Delgaz ~388, Oltenia ~333 lei/MWh. PZU mediu 2025–26 ≈ 350–500 lei/MWh; retail ≈ 700–900.

**MT/ÎT (>1 MW):** studiu de soluție; ≥110 kV Transelectrica (hărți capacitate web.transelectrica.ro);
licitație capacitate (Ord. 53/2024). Tip B: PT/PTA 20/0,4 kV propriu, relee U/f/RoCoF/LVRT la punctul de
delimitare, DMS-SCADA, măsură MT; Distribuție Oltenia publică „teme de proiectare cadru" (SS ≤0,8 MW,
categoria B).

**Calificări (de înregistrat în app):**
- Atestate firmă (Ord. 134/2021 art. 9): A1/A2/A (încercări), **A3** (certificare conformitate centrale),
  **Bp/Be/Bi/B** (JT), **C1A/C2A** (0,4–20 kV, PT), C1B/C2B (–110 kV), D1/D2 (LEA), E1/E2/E2PA (stații,
  protecții). Uzual PV: B/Bi rezidențial; C1A+C2A comercial cu PT; A3+E1+E2 MT/ÎT.
- Electricieni (Ord. 66/2023 mod. 65/2024): Grad I ≤10 kW <1 kV; II A/B JT nelimitat; III A/B ≤20 kV;
  IV A/B orice tensiune; A = proiectare, B = executare; 5 ani; IIIA/IVA + 5 ani → verificator.
- Câmpuri: atestat firmă (tip, nr., valabilitate), electrician semnatar (grad, A/B, legitimație,
  expirare), validare AFM (sesiune), verificator proiect (>20 kV), instrumente PRAM (serie, etalonare).

**Lacune de verificat în texte oficiale înainte de a le coda hard:** pragul monofazat per OD; valorile
„RO" ale protecțiilor EN 50549-1 cerute de fiecare OD; pragul 45 kW din Legea 50/1991; noua metodologie
ANRE (mod. Ord. 15/2022, ~24.09.2026) pentru vânzare directă „la invertor" și echilibrare.

_Surse principale:_ anre.ro (cum devin prosumator), legislatie.just.ro (Ord. 79/2016, 208/2018,
228/2018, 3/2023, 959/2023, Regulament atestare 2021), lege5.ro (Ord. 19/2022), legeaz.net (Ord.
102/2015), ppcenergy.ro/legislatie, delgaz.ro, distributie-energie.ro, reteleelectrice.ro (procedura
prosumatori 2022), pramrapid.ro (dosar prosumator), economisi.ro (ATR, tarife), instalatori-fotovoltaice.ro
(Legea 160/2026, atestate, Casa Verde), greenlead.ro, asociatiaprosumatorilor.ro, agerpres.ro,
finantare.ro (Casa Verde Baterii), energie.gov.ro, hytenergy.ro + speedfire.ro (P118-1/2025),
energiata.org (Legea 50/1991), megger.com + iteh.ai (IEC 62446-1, EN 50549-1), verificatori.ro.

### 3.2 Motorul de calcul (formule, tabele) — cercetat 04.09.2026

**Câmp PV / string-uri (IEC 62548):**
- Fișă modul de stocat: Pmax, Voc, Isc, Vmp, Imp, α (Isc %/K), β (Voc %/K), γ (Pmax %/K), NOCT/NMOT,
  siguranță serie max, tensiune sistem max (1000/1500 V), bifacialitate, L×l×h, greutate, nr. celule.
  Valori TOPCon 2025–26: 108 celule ≈ 430–460 Wp, 1762×1134 mm (≈2,0 m²), Voc ≈ 39 V, Isc ≈ 14 A,
  γ ≈ −0,30, β ≈ −0,26, α ≈ +0,045 %/K; 144 celule ≈ 575–600 Wp, 2278×1134 (≈2,58 m²) / 2382×1134.
- `Tcell = Tamb + (NOCT − 20)/800 · G`; caz de proiectare Tcell_max ≈ 70 °C (Faiman alternativ:
  `Tcell = Tamb + G/(U0 + U1·v)`, U0 = 25, U1 = 6,84).
- `Voc_string(Tmin) = Ns · Voc · (1 + β/100 · (Tmin − 25))` ≤ V_DC,max invertor și ≤ Usys modul.
- `Vmp_string(Tmax) = Ns · Vmp · (1 + γ/100 · (Tcell_max − 25))` ≥ V_MPPT,min (și ≥ V_start).
- `Ns_max = floor(V_DCmax / Voc(Tmin))`, `Ns_min = ceil(V_MPPT,min / Vmp(Tmax))`.
- **Tmin România**: implicit **−25 °C**; **−30 °C** depresiuni Transilvania (Harghita, Covasna, Brașov) și
  munte; −20 °C litoral/Dobrogea (record −38,5 °C Bod 1942) → câmp editabil per proiect.
- Curent: `I_string,max = 1,25 · Isc`; Σ I_string ≤ I_MPPT,max; `Np · Isc · 1,25` ≤ I_sc,max invertor.
- **DC:AC** 1,1–1,3 rezidențial, 1,25–1,35 comercial, 1,30–1,40 utilitar; limită dură = P_DC,max invertor.
- **Siguranțe string**: necesare dacă `(N_strings − 1) · 1,25 · Isc > I_fuse,max modul` (practic ≥3
  string-uri paralel); `1,4·Isc ≤ In ≤ min(2,4·Isc, I_fuse,max)`, tip gPV (IEC 60269-6), U ≥ Voc(Tmin).
- Mismatch implicit 2 %; MLPE (optimizatoare/microinvertoare) recuperează 5–25 % la umbrire parțială;
  constrângeri micro: Voc ≤ ~60 V, `n·I_ac ≤ 0,8·I_MCB` pe ramură; optimizatoare: tensiune string fixă
  (380/750 V), min/max per string.

**Randament energetic:**
- **PVGIS 5.3** (`https://re.jrc.ec.europa.eu/api/v5_3/{PVcalc|seriescalc|tmy|MRcalc|printhorizon}`,
  `outputformat=json`, GET, 30 req/s/IP). Parametri comuni: `lat, lon, usehorizon, userhorizon,
  raddatabase=PVGIS-SARAH3|PVGIS-ERA5, angle, aspect (0 = S, −90 = E, +90 = V), optimalinclination,
  optimalangles`. `PVcalc`: `peakpower, loss, pvtechchoice (crystSi|crystSi2025|CIS|CdTe),
  mountingplace (free|building)` → `outputs.monthly.fixed[12]{month, E_d, E_m, H(i)_d, H(i)_m, SD_m}`,
  `outputs.totals.fixed{E_y, H(i)_y, l_aoi, l_spec, l_tg, l_total}`. `seriescalc`: `startyear/endyear`
  (SARAH3 2005–2023), `pvcalculation, components` → `outputs.hourly[]{time "YYYYMMDD:HHMM" UTC, P, G(i),
  H_sun, T2m, WS10m}`. `tmy` → `outputs.tmy_hourly[]{T2m, RH, G(h), Gb(n), Gd(h), WS10m…}`.
  `printhorizon` → `outputs.horizon_profile[]{A, H_hor}`. **Cache TMY + orizont per site** pentru offline.
- Alternative: Open-Meteo (`global_tilted_irradiance` cu `tilt`/`azimuth`; gratuit necomercial ≤10k/zi —
  **licență comercială dacă app-ul se vinde**), NASA POWER (0,5°, mai grosier).
- **România, sud, 30–35°, ~14 % pierderi**: ≈1180–1250 kWh/kWp (Suceava, Maramureș, Cluj) → 1280–1320
  (București/câmpia de sud) → 1315–1380 (Dobrogea/Constanța); Banat 1250–1300; Iași 1220–1260.
  Înclinare optimă 30–36°; E-V 10° pe terasă ≈ 0,90–0,94 din optim. Casa Verde: 1200–1300 kWh/kWp.
- **Pierderi (PVWatts v5)**: murdărie 2 %, umbrire 3 %, zăpadă 1–3 % (RO), mismatch 2, cablaj 2,
  conexiuni 0,5, LID 1,5, nameplate 1, disponibilitate 3 → `L = 1 − Π(1 − l_i) ≈ 14 %`; + temperatură
  5–8 % și invertor 2–4 % explicit. **PR** (IEC 61724-1) `= Yf/Yr`, tipic 0,78–0,85.
- **Model lunar offline** (port PVWatts): poziție soare (SPA — pachet Dart `nrel_spa`, sau Meeus) →
  descompunere GHI → DHI/DNI (Erbs sau `Kd` din PVGIS) → transpunere (Liu-Jordan izotrop
  `H_T = H_b·R_b + H_d·(1+cos β)/2 + ρ·H·(1−cos β)/2`, ρ = 0,2 / 0,6 zăpadă; mai bine Hay-Davies/Perez
  din pvlib) → Tcell → `P_dc = G/1000 · P_dc0 · (1 + γ·(Tcell − 25))` → invertor
  `η = (η_nom/η_ref)·(−0,0162·ζ − 0,0059/ζ + 0,9858)`, ζ = P_dc/P_dc0, η_nom 0,96, η_ref 0,9637, clip la
  P_ac0 → lanț pierderi → umbrire orizont/rânduri din survey.
- **Autoconsum** euristic: casă fără baterie 25–35 %, cu 5–10 kWh 60–75 %; firmă cu consum diurn
  60–80 %; ideal din profil de sarcină (casnic seară, birou 8–18, industrial 2 schimburi, frig plat) ×
  profil PV orar.

**Partea AC / proiectare electrică (RO):**
- **Ord. 228/2018 (citit direct din PDF)**: art. 12(3) pe branșament trifazat **diferența între curenții
  de fază ≤ 16 A** (≈3,68 kVA) → invertor monofazat ≤ ~3,68 kW pe trifazat, altfel trifazat sau
  monofazate comunicante (art. 12(4)); OD-urile acceptă uzual ≤5 kW pe branșament monofazat. Tabel 2P
  protecții interfață: U> tr. I 1,15 Un / 0,5 s; U< tr. II 0,85 Un / 3,2 s; f> 52 Hz / 0,5 s; f< 47,5 Hz /
  0,5 s; U> medie 10 min 1,1 Un. **Art. 14(3): ≤30 kVA la JT → protecțiile interne ale invertorului sunt
  suficiente; >30 kVA sau MT → releu de interfață extern + întrerupător de interfață.** Art. 10(2):
  reconectare la **15 min** după revenirea tensiunii, fereastră 47,5–51 Hz / 0,9–1,1 Un observată 300 s,
  rampă 10 % Pmax/min. Art. 5: LFSM-O de la 50,2 Hz, statism 2–12 % (5 %), întârziere <500 ms. Art. 8:
  interfață logică oprire injecție în 5 s (obligatorie la MT). ROCOF 1 Hz/s (500 ms); anti-islanding
  obligatoriu <1 MW.
- Curent AC invertor: mono `I = P/(U·cosφ)`, tri `I = P/(√3·U·cosφ)` (proiectare la S_max din fișă);
  `I_B ≤ I_n ≤ I_z`, `I_n ≈ 1,25·I_inv` rotunjit (16/20/25/32/40/63 A), curbă B pe alimentarea
  invertorului (C la cablu lung/transformator), MCCB >100 A. Icu ≥ Ik (6/10 kA).
- **Ampacitate (IEC 60364-5-52 tab. B.52.2, Cu PVC, 2 cond., 30 °C)** — A1/B1/C/E/F: 1,5 → 14,5/17,5/
  19,5/22/24 A; 2,5 → 19,5/24/27/30/33; 4 → 26/32/36/40/45; 6 → 34/41/46/51/57; 10 → 46/57/63/70/76;
  16 → 61/76/85/94/101; 25 → 80/101/112/119/131; 35 → 99/125/138/148/162; 50 → 119/151/168/180/196;
  70 → 151/192/213/232/251; 95 → 182/232/258/282/304; 120 → 210/269/299/328/352. XLPE ≈ +18–28 %;
  3 conductoare ≈ ×0,87–0,9. `I_z = I_tab · k_temp · k_grup`; k_temp PVC 40 °C 0,87 / 50 °C 0,71 /
  60 °C 0,50; XLPE 40 °C 0,91 / 50 °C 0,82 / 60 °C 0,71; grupare 2 → 0,80, 3 → 0,70, 4 → 0,65, 6 → 0,57,
  9 → 0,50. **Cazul critic PV: cabluri în pod/pe acoperiș la 50–70 °C.** (Tabelele există deja în
  `i7_tables.dart` — de verificat concordanța.)
- **Cădere de tensiune**: mono/DC `ΔU = 2·L·I·(R'·cosφ + X'·sinφ)`, tri `√3·L·I·(…)`, `R' = ρ/S`,
  ρ_Cu 0,0225 (70 °C) / 0,0175 (20 °C), ρ_Al 0,036 / 0,028 Ω·mm²/m, X' ≈ 0,08 Ω/km. Limite: **DC ≤ 1 %**
  (la Imp, Vmp_string), AC ≤ 1 % invertor→contor (≤3 % total) — ΔU mare pe AC → declanșări la 1,1 Un.
  Cablu DC H1Z2Z2-K (EN 50618) 4/6/10 mm², 1,5 kV, 90 °C: `S = 2·L·Imp·ρ/ΔU`.
- **Scurtcircuit**: la bornele JT transformator `Ik'' = Sn/(√3·Un·uk)` (uk 4 % ≤630 kVA, 6 % ≥1000 kVA);
  aval `Ik = c·Un/(√3·Z_total)`; aport invertor doar ≈1,1–1,5·In; PCC rezidențial 1–6 kA.
- **RCD**: IEC 62109-2 — invertoarele fără transformator au RCMU intern (tip B 300 mA brusc / 30 mA);
  extern **tip A** acceptabil dacă producătorul declară că nu poate apărea curent DC neted (Solis, SMA,
  Fronius, Huawei…), altfel **tip B** (sau F); 300 mA S pe alimentarea invertorului, 30 mA pe prize; RCD-ul
  PV nu se partajează.
- **SPD**: DC tip 2 (IEC 61643-31) `Uc ≥ 1,2·Voc_string(Tmin)` (600/1000/1500 V), Up ≤ 0,8·Uw invertor,
  la intrarea DC și la câmp dacă cablul >10 m; AC tip 2 la invertor/tablou general, tip 1(+2) când există
  IPT (IEC 62305 clasa III/IV), 10 m decuplare T1–T2 sau combinat. Echipotențializare rame/șine ≥6 mm² Cu
  (16 mm² dacă face parte din IPT). Separator DC ≥ Voc(Tmin), ≥1,25·Isc.

**Stocare:**
- Parametri: kWh nominal, utilizabil = nominal·DoD (LFP 80–100 %, plumb 50 %), C-rate (LFP încărcare
  ≤0,5 C, descărcare 0,5–1 C), η dus-întors (LFP 90–95 %, plumb 75–85 %), cicluri (LFP 6000+ @80 %),
  clasă tensiune (LV 48 V: 40–58 V, 100–200 A BMS; HV 200–600 V, +3–5 % η).
- Autoconsum: `E_bat,util ≈ (0,5…0,6)·E_zi,casă`; `C_nom = E_bat,util/(DoD·η_dis)`; regulă 1–1,5 kWh/kWp.
- Backup: `C_nom = (E_zi,critic · zile)/(DoD·η_rt)`, 1–2 zile litiu, 3 plumb. `P_bat,desc ≥ P_vârf/η_inv`;
  verifică P_încărcare/descărcare max hibrid (tipic 0,5 C), fereastra de tensiune, curent max, EPS
  (ex. 150 %/10 s).
- Off-grid: `P_pv = E_zi/(H_luna_cea_mai_slabă · PR)` cu decembrie RO H ≈ 1,0–1,5 kWh/m²/zi (înclinare
  50–60°); invertor ≥ vârf ×1,1–1,25; generator `P_gen ≥ max(P_vârf, P_charger)/0,8`;
  `I_înc = P_pv,max/U_bat ≤ 0,5·C_Ah`.

**MT/ÎT și parcuri:**
- Transformator `S_tr = P_ac,total/(cosφ · k_load)` (cosφ 0,9–0,95, k 0,9–1) → 1 MWac ≈ 1250 kVA;
  uk 6 % (≥1 MVA) / 4 % (≤630 kVA); pierderi 1–1,5 %/an; EU 548/2014 Tier 2.
- Cablu MT 20 kV (N2XSY / A2XS(F)2Y Al): `I = S/(√3·20 kV)` → 1 MVA ≈ 29 A; 3×1×95/150 Al tipic;
  verificare termică `S ≥ Ik·√t/k` (k = 94 Al XLPE, 143 Cu).
- Reactiv tip B+: cosφ 0,9 ind – 0,9 cap → invertoare ≈10 % supradimensionate (`S = P/0,9`) sau STATCOM;
  Q(U)/cosφ(P) de la OD.
- Protecții la interfața MT (SR EN 50549-2): 27/59, 81U/81O, 81R (ROCOF), 50/51, 51N/67N (direcțional
  homopolar — rețele 20 kV cu bobină Petersen/izolate), 47, 25.
- Topologii: string 100–350 kW (1500 V, ~20 string-uri), cutii de combinare 16–32 string-uri, centrale
  2,5–5 MW; DC:AC 1,25–1,4; teren 1,5–2,0 ha/MWp fix (2,2–2,8 tracker), 2,5–4 ha/MWp cu acces; stație
  20/0,8 sau 0,4 kV per bloc 1–5 MW, colector MT radial/inel, 110/20 kV peste ~30–50 MW.

**Mecanic / survey:**
- Amprentă: 2,0 m² (108 cel.) → ≈5,0 m²/kWp pe acoperiș înclinat; 2,6–2,7 m² (144) → 4,5–5 m²/kWp;
  terasă E-V 10° ≈ 6 m²/kWp; sol 15–20 m²/kWp.
- Distanță rânduri `d = L·cos β + L·sin β/tan(α_s)`, `α_s = 90° − φ − 23,45°` la solstițiul de iarnă
  (București φ = 44,4° → 22,1°; la 9:00/15:00 ≈ 12–15°); GCR = L/d (0,35–0,45).
- Zăpadă **CR 1-1-3/2012**: s_k 1,0/1,5/2,0/2,5 kN/m² (Timișoara, Cluj, Constanța 1,5; București 2,0;
  Iași 2,5; corecție >1000 m); `s = μ_i·C_e·C_t·s_k` (μ 0,8 la 0–30°, liniar la 0 la 60°). Vânt
  **CR 1-1-4/2012**: q_b 0,4–0,7 kPa (București ≈0,5; Banat/SV și Moldova NE până la 0,7);
  `q_p = c_e(z)·q_b`; `F = c_p·q_p·A` (c_p până la −2 la margini) → balast pe terasă / smulgere șuruburi.
  Tabel 337 localități Anexa A CR 1-1-4 [de verificat înainte de includere].

**Economie:**
- CAPEX 2025–26: rezidențial 1000–1700 €/kWp (5 kW on-grid 18–22 kRON, hibrid 26–32 kRON); comercial
  <50 kWp ≈4500 RON/kWp, 50–200 ≈3800, >200 ≈3500; utilitar 580–700 €/kWp; baterie 300–500 €/kWh;
  OPEX 0,5–1 % CAPEX/an. Prețuri: casnic 1,20–1,40 RON/kWh, firme 0,85–1,15; PZU ≈0,40 RON/kWh.
- `Economii_y = E_y·(1−d)^y · [SC·p_cumpără,y + (1−SC)·p_vinde,y]`, `p_y = p_0·(1+e)^y` (e 3–5 %);
  degradare d 0,4–0,55 %/an (0,3 % TOPCon); payback simplu = CAPEX/Economii_1; NPV r 5–8 %;
  `LCOE = (CAPEX + Σ OPEX_y/(1+r)^y)/Σ E_y/(1+r)^y` (25–30 ani).

**Referințe OSS de portat în Dart** (pvlib BSD-3): `solarposition.spa`, `irradiance.erbs/dirint`,
`haydavies`, `perez` (tabel 8×6), `isotropic`, `aoi`, `iam.ashrae/physical`,
`temperature.faiman/noct_sam/pvsyst_cell`, `pvsystem.pvwatts_dc`, `inverter.pvwatts`,
`calcparams_desoto` + `singlediode`, `bifacial.infinite_sheds`, `shading.masking_angle`. Faiman/PVWatts/
Hay-Davies <50 linii fiecare. NREL PVWatts v5 (TP-6A20-62641), Sandia PVPMC, IEC 61724-1. Dart: `nrel_spa`,
`solar_calculator`, `dart_suncalc` — **nu există pachet Dart de performanță PV**.

_Surse principale:_ PVGIS API docs (JRC), pvlib iotools/pvgis, open-meteo.com/docs, NASA POWER docs,
NREL PVWatts v5 (osti.gov/1158421), pvpmc.sandia.gov (PR), SolarEdge string fusing note (IEC 62548),
ecalpro.com (tab. B.52), reteleelectrice.ro/ordinul-anre-228-2018.pdf, distributie-energie.ro (Condiții
tehnice generatoare v8), Solis app note RCD, lsp.global (SPD DC), greenlead.ro (hartă solară județe),
instalatori-fotovoltaice.ro (comercial 2026), vreaupanourisolare.ro, novasol.ro, cleanenergyreviews.info
(off-grid), growatt.com (baterii), encipedia.org (CR 1-1-3), ugir.ro (CR 1-1-4), pub.dev (nrel_spa).

### 3.3 Peisaj competitiv + stack Flutter (cercetat 04.09.2026)

**Unelte de proiectare (ce fac bine → ce preluăm):**
- PV*SOL / PVsyst — lanț de pierderi detaliat, rapoarte bancabile (P50/P90) → **referință de validare** pentru
  motorul nostru și pentru conținutul raportului.
- HelioScope / Aurora (+ app de survey **SiteCapture**) — bucla survey → design → propunere; Aurora are
  poze obligatorii, GPS + timestamp, offline.
- **OpenSolar** (gratuit, web + mobil) — CRM + design + propuneri PDF + e-sign; cel mai apropiat analog
  gratuit pentru fluxul de ofertare.
- SolarEdge Designer, SMA Sunny Design, Fronius Solar.creator, Huawei SmartDesign — gratuite dar
  **vendor-locked**, fără offline, fără API → nișa noastră: **multi-brand + offline + normativ RO**.
  Sunny Design = referință pentru regulile de string (Voc rece / Vmpp cald / Isc).
- OSS: pvlib (PVWatts, SAPM, PVsyst, PVGIS), NREL SAM, PVGIS.

**Aplicații de teren (Scanifly, SiteCapture, Scoop) → modelul de date al survey-ului:**
- Proprietate: adresă geocodată (lat/lon), acces, contact, tip, restricții.
- Plane de acoperiș (1..n): tip/material, înclinare °, azimut ° (față de sud), L×l utilizabil, stare/vârstă,
  obstacole (coș, aerisiri, luminatoare) cu poziții, căpriori (secțiune/distanță), expunere zăpadă/vânt,
  poze per plan.
- Umbrire: profil orizont (PVGIS `printhorizon` sau busolă + inclinometru), listă obstacole (h, d, azimut).
- Serviciu electric: mono/tri, putere contractată (kVA/A), disjunctor general, contor (serie, tip, smart,
  bidirecțional), poze tablou (interior cu etichete), poziții libere, sistem de legare la pământ (TN/TT),
  RCD existent, lungimi trasee acoperiș→invertor→tablou.
- Amplasări echipamente (invertor, baterie: distanțe, ventilație, reguli incendiu), separatoare AC/DC, SPD.
- Poze obligatorii per pas + „show-stoppers" (acoperiș degradat, tablou de înlocuit).

**Aplicații de PIF ale OEM-urilor (Fronius Solar.start, Huawei FusionSolar, SolarEdge SetApp, SMA 360°):**
toate scanează QR/serie și au pasul cod de rețea + contor + limită export → aplicația noastră **captează
rezultatele** (cod rețea setat, limită export, firmware, ID plantă/portal monitorizare, predare cont),
nu le înlocuiește.

**Rapoarte de test (Metrel MI 3114/3115, Fluke SMFT-1000 + TruTest, HT PV-ISOTEST/TopView) → formular
IEC 62446-1 Cat. 1:** continuitate PE/echipotențializare (Ω); polaritate; per string: **Voc, Isc** +
iradiere W/m² + temp. modul → corecție STC vs fișă; **Riso** (MΩ, 250/500/1000 V, metodă, limită ≥1 MΩ
la >120 V); funcționale (pornire invertor, anti-islanding, limitare export, curent string cu clește);
AC: Zs, RCD (timp/curent), rezistență priză de pământ (buletin PRAM); Cat. 2 opțional: curbă I-V,
termografie; checklist inspecție; pachet documentație. 62446-1 exclude bateriile → secțiune separată
după procedura producătorului.

**Specific RO:** ANRE flux prosumator (cerere → ATR ≤30 zile legal → contract → instalare → dosar + cerere
PIF → PV recepție → certificat de racordare → contract vânzare cu furnizorul), 400 kW/loc de consum;
DSO-uri: Rețele Electrice/E-Distribuție, DEER/Electrica, Delgaz Grid, Distribuție Oltenia — se stochează per
proiect: DSO, **cod POD**, nr./data ATR, nr. contract, nr. certificat. Casa Verde 2024: max 30.000 RON,
~10 % coplată, min 3 kW, baterie obligatorie, instalator validat AFM + atestat ANRE; iulie 2026: program
panouri suspendat, **Casa Verde Baterii** (~400 M RON) în pregătire → regulile de program trebuie să fie
**tabel editabil**, nu hard-coded. Prețuri publice 2026: buget 2.200–3.000 RON/kW, mediu 2.800–3.800,
premium 3.500–5.000+; 5 kWp la cheie ≈ 5.500–9.000 € cu TVA; fără liste B2B publice → **catalog întreținut
de utilizator** (brand, model, Pmax/Voc/Isc/Vmpp/Impp/γ, preț, furnizor, dată) cu import CSV.

**API-uri gratuite:** PVGIS 5.3 (`re.jrc.ec.europa.eu/api/v5_3/{PVcalc,seriescalc,tmy,printhorizon,MRcalc}`,
fără cheie, 30 req/s/IP, fără CORS — OK din app nativ); Open-Meteo radiation (GTI cu tilt+azimut,
necomercial gratuit); NASA POWER; Nominatim (1 req/s, User-Agent); tile-uri OSM (politică de uz →
MapTiler free tier / caching `flutter_map` ≥8.2); Google Solar API (10k apeluri/lună gratuit,
**acoperire RO neconfirmată**); poziția soarelui: formule NOAA/SPA vendorizate (~200 linii Dart).

**Stack Flutter recomandat (versiuni pub.dev, sept. 2026):**
| Rol | Pachet | Notă |
|---|---|---|
| Framework | Flutter 3.47 stable (local avem **3.44.0**; ElectroCalc cere ≥3.44) | minSdk 24, **targetSdk 36** (Play cere API 36 din 31.08.2026), 16 KB page size |
| State | `flutter_riverpod` 3.4 (+ generator) | Riverpod 3 stabil din sept. 2025 |
| Rute | `go_router` 18 | StatefulShellRoute pentru tab-uri |
| DB local | **`drift`** 2.34 (+ `drift_flutter`) | isar abandonat; objectbox doar cu sync-ul lor comercial |
| Sync | `powersync` 2.4 (Postgres) sau REST propriu `/sync/pull?since=` + `/sync/push` cu outbox | electroprep e Postgres → PowerSync fezabil |
| Formulare | `reactive_forms` 18 | array-uri dinamice (string-uri, plane) |
| PDF | `pdf` 3.13 + `printing` 5.15 | deja folosite în ElectroCalc |
| Grafice | `fl_chart` 1.2 | MIT |
| Hartă | `flutter_map` 8.3 + `latlong2` | opțional cache tile-uri |
| Locație/senzori | `geolocator` 14, `sensors_plus` 7.1 (inclinometru/heading), `flutter_compass` 0.8 (dormant) | declinație magnetică RO ≈ +6° (2026); azimut față de sud pentru PVGIS |
| Cameră | `image_picker`, `camera`, `pro_image_editor` 13 | adnotări (săgeți, text, cote) |
| QR/serie | `mobile_scanner` 7.4 | serii module + QR invertor |
| AR măsurare | `ar_flutter_plugin_updated` / `_engine` | fragil → faza 3; MVP: cote manuale + telemetru laser |
| i18n | `slang` 4.19 + `intl` | RO implicit |
| Bani | `decimal` 3.2 | totaluri ofertă |
| Sync fundal | `workmanager` 0.10 | ≥15 min |
| Test | `flutter_test`, `mocktail`, drift in-memory, `alchemist` goldens | cazuri de referință PVGIS/PVsyst |

**Arhitectură:** feature-first clean (`app/`, `core/` {solar, units, money, db, sync}, `features/`
{projects, survey, sizing, commissioning, catalog, reports, sync, auth}, `i18n/`). Toate rândurile:
`id` UUIDv7, `created_at`, `updated_at`, `deleted_at`, `version`. **Offline-first**: SQLite sursă de
adevăr, outbox de mutații, LWW per rând (utilizator unic), rezultate de măsurători **append-only**
(imutabile → fără conflicte), poze urcate separat cu hash, soft delete. Auth: JWT electroprep (access
15 min + refresh 30 zile în secure storage), aplicația funcționează complet offline logat.

**Backlog sugerat:** MVP = proiecte/clienți, survey (plane, tablou, contor) cu poze obligatorii +
adnotare, busolă/inclinometru, dimensionare string/randament (PVGIS + fallback cache), catalog, ofertă
PDF RO, formular IEC 62446-1 + certificat PDF, PV recepție + dosar prosumator, backup ZIP. v2 = sync
electroprep.ro, hartă, QR serii în layout, tracker ATR/Casa Verde per DSO, simulare orară + baterie,
orizont umbrire. v3 = AR, telemetre Bluetooth, Google Solar API, multi-user, e-semnătură.

## 4. Arhitectura propusă (recomandare)

### 4.1 Decizii
1. **Aplicație Flutter separată** în `ElectroApp/` (repo nou privat `CristianCasapu/ElectroApp`),
   `applicationId` propriu (ex. `ro.ccii.electroapp`), keystore propriu (nu cel ElectroPrep/ElectroCalc).
   Flutter 3.44 local (compatibil cu ElectroCalc); minSdk 24, targetSdk 36.
2. **Offline-first**: `drift` ca sursă de adevăr locală; sync cu electroprep.ro amânat în v2 printr-un
   modul `pv` în API-ul FastAPI (outbox + `/sync/pull?since=` / `/sync/push`, JWT electroprep).
3. **Motor de calcul pur Dart, cu teste, în `lib/core/calc/`** — nicio formulă în ecrane (lecția
   ElectroCalc). Fiecare rezultat poartă ipotezele și referința normativă (numărul standardului),
   ca `Finding`/`Ref` din `schematics_check.py`.
4. **Reguli și praguri ca date** (`assets/rules/*.json` + tabel `reguli` editabil): praguri prosumator,
   limite OD, Casa Verde, tarife, valori protecții interfață — cu `valabil_de_la`/`sursa`.
5. **Riverpod 3 + go_router** (aliniat cu electroprep `app/`), `reactive_forms` pentru survey.
6. UI română hard-coded ca în cele două aplicații existente (fără ARB) — `slang` doar dacă apare nevoia.
7. PDF cu `pdf` + `printing`, șabloane pornite din `estimare_pdf_service.dart`.

### 4.2 Structura
```
lib/
  app/            router, theme (copiat din ElectroCalc), bootstrap, providers
  core/
    calc/         pv_string.dart, pv_yield.dart, pv_ac.dart (din cable_calculator), pv_protection.dart,
                  storage.dart, mv.dart, economics.dart, solar_position.dart (NOAA/SPA vendorizat)
    data/         i7_tables.dart (portat), localitati_romania.dart (copiat), rules/ (JSON)
    db/           drift: schema + DAO-uri, migrări
    services/     pvgis_api.dart, osm_service.dart (copiat), pdf/, backup/, update_service.dart
    models/       entități (freezed opțional)
  features/
    clienti/  proiecte/  survey/ (plane acoperiș, tablou, contor, poze, busolă/inclinometru)
    dimensionare/ (string, invertor, cabluri, protecții, stocare, racordare)
    pif/ (formulare IEC 62446-1, buletin PRAM)  catalog/ (module, invertoare, baterii, prețuri)
    rapoarte/ (ofertă, PV recepție, raport teste, DIU)  setari/
  widgets/        calc_widgets.dart, result_card.dart (copiate)
test/             calc/ (cazuri de referință PVGIS/PVsyst), db/, models/
```

### 4.3 Model de date (nucleu)
`Client` → `Proiect` (adresă, lat/lon, județ/localitate, OD, POD, mono/tri, putere contractată,
S_evac, status pipeline: lead → survey → ofertă → ATR → montaj → PIF → certificat) → `Survey` →
`PlanAcoperis[]` (tip, înclinare, azimut, L×l, obstacole, poze) → `TablouElectric` / `Contor` →
`Design` → `Sir[]` (module în serie, MPPT) → `Echipament[]` (ref catalog + serie) → `TestPIF[]`
(append-only) → `Poza[]` (cale, tag, adnotări JSON) → `Document[]` (tip PDF, versiune, hash) →
`Oferta`/`OfertaLinie` (decimal). Toate rândurile: `id` UUID, `created_at`, `updated_at`, `deleted_at`.

### 4.4 Etape de implementare (după aprobare)
- **E0** schelet: repo, CLAUDE.md, temă, drift, router, setări firmă, clienți/proiecte, CI release.
- **E1** motor de calcul + teste: string/invertor, AC (port `cable_calculator`), protecții, stocare,
  randament PVGIS + fallback offline.
- **E2** survey: formulare, poze + adnotare, busolă/inclinometru, geocodare.
- **E3** rapoarte PDF: ofertă, PV recepție, raport IEC 62446-1, buletin PRAM, listă DIU.
- **E4** catalog echipamente + import CSV, tracker ATR/Casa Verde, backup.
- **E5** (v2) sync electroprep.ro, hartă, QR serii, MT (transformator, protecții).

## 5. Verificare
- `flutter analyze` + `flutter test` verzi; motorul de calcul testat contra cazurilor de referință
  (PVGIS PVcalc pentru 3 județe, exemple string sizing din fișe tehnice reale, `cable_calculator_test`
  portat).
- Rulare pe device fizic: flux complet client → proiect → survey cu 3 poze → dimensionare 5 kWp mono +
  10 kWp tri + 30 kWp cu stocare → PDF ofertă + raport PIF, totul **în mod avion**.
- Validare cu electricianul: un site real, comparație cu ATR/DIU acceptat de OD.

## 6. Istoricul lucrărilor — „Registrul de lucrări" (specificație funcțională)

> Cerință (04.09.2026): aplicația păstrează un istoric în care fiecare înregistrare conține clientul,
> adresa, măsurătorile, sistemul ales etc. Mai jos, cerința este elaborată ca model de domeniu cu
> terminologie de specialitate. Este parte din etapa **E0** (schema DB) și **E4** (căutare/filtre/export).

### 6.1 Concept
Unitatea de bază este **Fișa de lucrare** (dosarul tehnic al unei intervenții la un **loc de consum**).
Registrul de lucrări este colecția cronologică a fișelor, cu **trasabilitate completă**: orice
modificare a soluției tehnice produce o **revizie** (R0, R1, …) imutabilă, iar măsurătorile și
documentele emise nu se editează niciodată retroactiv (append-only). O fișă parcurge un **flux de stări**:

`Lead → Releveu → Dimensionare → Ofertă → ATR → Execuție → PIF/Recepție → Certificat de racordare → Exploatare (service/revizii) → Arhivat`

### 6.2 Structura unei fișe de lucrare (secțiuni și câmpuri)

**A. Identificare**
- Număr de înregistrare (serie/an, ex. `FL-2026-0042`), data deschiderii, data ultimei modificări.
- Tip lucrare: instalare nouă / extindere (putere suplimentară) / adăugare stocare / service /
  revizie periodică / expertiză (audit instalație existentă).
- Responsabil (electrician semnatar: grad ANRE, tip A/B, nr. legitimație), firmă executantă (atestat
  ANRE tip, nr., valabilitate).
- Stare curentă + istoricul tranzițiilor (cine, când, observație).

**B. Beneficiar (client)**
- Calitate: persoană fizică / persoană juridică / asociație / instituție publică; rol: proprietar /
  chiriaș / împuternicit (procură pentru depunerea dosarului la OD, cf. Ord. 19/2022 art. 24).
- Date de identificare și contact (telefon, e-mail, adresă de corespondență). **CNP nu se stochează
  persistent** (GDPR, aliniat cu practica electroprep): se cere doar la generarea documentului și se
  redactează după emitere. Pentru PJ: denumire, CUI, nr. Reg. Com., reprezentant legal.
- Furnizor de energie curent, cod client furnizor (pentru contractul de vânzare-cumpărare al surplusului).

**C. Loc de consum și amplasament**
- Adresă poștală + geocodare (lat/lon, altitudine), județ/localitate (autocomplete), tip zonă (urban/rural).
- **Operator de distribuție (OD)**: PPC Rețele Electrice / DEER (Electrica) / Delgaz Grid / Distribuție
  Oltenia; **cod POD** (punct de măsură), nr. loc de consum, **nivel de tensiune** al racordului
  (JT 0,4 kV / MT 6–20 kV / ÎT 110 kV).
- **Branșament existent**: monofazat / trifazat, tip (aerian/subteran), secțiune coloană, **putere
  aprobată (kVA)** și **putere contractată**, disjunctor la punctul de delimitare (In, curbă), **schema de
  legare la pământ** (TN-C / TN-C-S / TN-S / TT), prezența prizei de pământ proprii.
- **Grup de măsură**: tip contor (electromecanic / electronic / smart), serie, bidirecțional da/nu,
  index la data releveului (energie activă import/export, reactivă), interval de integrare (15 min).
- Clădire: destinație (rezidențial/comercial/industrial/agricol), regim de înălțime, an construcție,
  categorie de importanță, clasă de risc la incendiu (relevant P118-1/2025), regim juridic teren
  (relevant Legea 50/1991: autorizație de construire da/nu).

**D. Releveu tehnic de șantier (site survey)**
- **Plane de montaj** (1..n): tip (acoperiș înclinat / terasă / fațadă / sol / carport), material
  învelitoare (țiglă ceramică/beton, tablă fălțuită/cutată, membrană bituminoasă/PVC, panou sandwich),
  **înclinare (°)**, **azimut (° față de sud)**, suprafață utilă (L×l), stare structură (căpriori:
  secțiune, distanță interax), obstacole (coșuri, aerisiri, luminatoare, antene) cu cote, zone de
  retragere P118 (coamă, margini, căi de acces pompieri).
- **Analiză de umbrire**: profil orizont (azimut → elevație, 8–36 puncte, din busolă/inclinometru sau
  PVGIS `printhorizon`), obstacole apropiate (înălțime, distanță, azimut), coeficient de umbrire estimat.
- **Tablou electric general (TEG)**: poziții DIN libere, disjunctor general (In, curbă, Icu), DDR
  existente (tip AC/A/F/B, IΔn), bară PE/N, SPD existent, secțiune coloană TEG, distanță TEG ↔ contor.
- **Trasee**: lungimi acoperiș → invertor (DC), invertor → TEG (AC), TEG → contor; mod de pozare
  (aparent/îngropat/tub/jgheab), temperatura ambiantă maximă estimată (pod: 50–70 °C).
- **Amplasare echipamente**: încăpere invertor/baterie (temperatură, ventilație, distanțe P118, REI),
  distanță până la punctul de decuplare pompieri.
- **Încărcări climatice**: zona de zăpadă (CR 1-1-3, s_k), zona de vânt (CR 1-1-4, q_b), altitudine.
- **Fotografii obligatorii** per pas (fiecare plan, TEG deschis/închis, contor, traseu, amplasări) cu
  adnotări, GPS și timestamp; listă „show-stoppers" (structură degradată, TEG neconform, branșament
  subdimensionat).

**E. Măsurători instrumentale** (fiecare cu: instrument, serie, dată etalonare, operator, condiții de mediu)
- *La releveu (instalația existentă)*: tensiuni fază-nul / fază-fază (V), succesiunea fazelor
  (directă/inversă), curenți per fază (A) și **dezechilibru**, factor de putere, **THD-U / THD-I** (%),
  frecvență, **rezistența prizei de pământ** (Ω, metoda 3 poli / clește), **impedanța buclei de defect Zs**
  (Ω) și **curentul de scurtcircuit prezumat Ik** (kA) la TEG, **rezistența de izolație** a instalației
  existente (MΩ, U_test), continuitatea conductorului PE (Ω), timp/curent de declanșare DDR (ms/mA),
  busolă (azimut magnetic + declinație), inclinometru (°), iradianță de referință (W/m²) și temperatură
  modul (°C).
- *La PIF (IEC 62446-1, per string și per câmp)*: continuitate echipotențializare rame/șine (Ω),
  polaritate, **Voc** (V) și **Isc** (A) măsurate + iradianță + temperatură → **valori corectate la STC**
  vs fișa tehnică (abatere %), **Riso** (MΩ la 500/1000 V DC, metodă: +/− la pământ / câmp
  scurtcircuitat), curent de funcționare per string (A, clește DC), teste funcționale (pornire,
  anti-islanding, limitare export, decuplare pompieri), curbă I-V și termografie (Cat. 2, opțional,
  ca atașament).
- Fiecare măsurătoare are **verdict** (conform / neconform / informativ) și **referința normativă**
  (număr standard/articol) și nu se poate modifica după semnarea buletinului — corecțiile se fac prin
  măsurătoare nouă.

**F. Soluția tehnică adoptată (configurația sistemului)**
- Clasificare: **on-grid / hibrid / off-grid**; **monofazat / trifazat**; categorie RfG (A/B/C/D);
  regim: prosumator (≤27 / ≤200 / ≤400 kW) / producător; nivel de racordare (JT/MT/ÎT).
- **Generator PV**: modul (producător, model, Pmax, Voc, Isc, Vmp, Imp, α/β/γ, NOCT, dimensiuni),
  număr module, **putere instalată DC (kWp)**, tehnologie (TOPCon/HJT/PERC, bifacial), orientare per câmp.
- **Configurație string-uri**: per MPPT — Ns (module în serie), Np (string-uri în paralel), Voc(Tmin),
  Vmp(Tcell_max), Isc×1,25, raportul **DC/AC**, verificări față de fereastra MPPT și V_DC,max (verdicte).
- **Invertor(oare)**: tip (string / hibrid / microinvertor / optimizatoare + invertor / central),
  producător, model, serie, **P_AC nominal (kW)** și **S_max (kVA)**, nr. MPPT, cod de rețea setat
  (RO / EN 50549-1), **putere evacuată setată (S_evac ≤ ATR)**, zero-export da/nu, firmware,
  certificat EN 50549-1.
- **Sistem de stocare** (dacă există): chimie (LFP/NMC/plumb), producător/model, **capacitate
  nominală / utilizabilă (kWh)**, DoD, putere încărcare/descărcare (kW), clasă tensiune (LV 48 V / HV),
  nr. module, funcție backup (EPS) da/nu, contor separat pentru stocare (Ord. 228/2018), notificare
  Ord. 3/2023.
- **Protecții și aparataj DC**: separator DC (Un, In), siguranțe gPV (In, Un) per string, SPD DC tip 2
  (Uc, Up), cutie de joncțiune / combiner, secțiuni și lungimi cablu H1Z2Z2-K, ΔU DC (%).
- **Protecții și aparataj AC**: disjunctor invertor (In, curbă, Icu), DDR (tip A/B/F, IΔn), SPD AC
  (tip 1/2, Uc, Up), releu de interfață extern (dacă >30 kVA sau MT), întrerupător de interfață,
  decuplare pompieri, secțiune/lungime cablu AC, ΔU AC (%), verificare I_B ≤ I_n ≤ I_z.
- **Legare la pământ și echipotențializare**: priză de pământ (nouă/existentă, R_p măsurată),
  conductor echipotențial rame (mm²), IPT existent da/nu, distanță de separare.
- **Structură de montaj**: sistem (șine + cârlige / suporți trapezoidali / balast / structură sol),
  producător, verificare încărcări zăpadă/vânt, distanță rânduri (pentru terasă/sol), GCR.
- **Monitorizare și comunicații**: portal (FusionSolar / Solar.web / SEMS / etc.), ID plantă, contor
  inteligent al invertorului (smart meter, model, poziție), acces predat clientului.
- **Rezultate de dimensionare (snapshot la revizie)**: producție estimată (kWh/an, lunar), PR, factor de
  autoconsum, energie injectată estimată, economii anuale, payback, sursă date (PVGIS SARAH3, dată apel).

**G. Racordare și avize (urmărire administrativă)**
- Cerere de racordare (nr., dată), **fișă/studiu de soluție**, **ATR** (nr., dată, putere aprobată kVA,
  valabilitate 12 luni, taxă), contract de racordare, **DIU** (dată depunere, listă documente cu bife),
  cerere punere sub tensiune, **PV de recepție / PIF** (nr., dată), **certificat de racordare** (nr.,
  dată, mențiune prosumator), contract vânzare-cumpărare cu furnizorul, notificare stocare (DTIS),
  autorizație de construire / aviz ISU (dacă e cazul), dosar Casa Verde (sesiune, nr. dosar, sumă aprobată).
- Fiecare pas: stare (de depus / depus / aprobat / respins), termen legal, alertă la depășire.

**H. Documente emise** (imutabile, cu versiune, dată, hash SHA-256, cale fișier)
- Ofertă tehnico-comercială, deviz / listă de materiale, schemă monofilară, **buletin PRAM** (priză de
  pământ, izolație, continuitate), **raport de verificări PIF IEC 62446-1**, proces-verbal de recepție,
  declarație de conformitate a execuției, fișă de predare (instrucțiuni exploatare, garanții), listă DIU.

**I. Comercial și garanții**
- Ofertă (nr., versiune, valoare, TVA, stare: draft / trimisă / acceptată / refuzată), avans, facturi
  (integrare ulterioară), listă echipamente cu **serii** (scanate QR) și **garanții** (produs /
  performanță: module 12–15 / 25–30 ani, invertor 5–10, baterie 10 ani sau cicluri).

**J. Exploatare (după PIF)**
- **Jurnal de intervenții**: service, defecte (cod eroare invertor), înlocuiri (serie veche → nouă),
  **revizii periodice** (verificare PRAM anuală, curățare, strângere conexiuni, termografie), citiri de
  producție reală vs estimată (kWh/an) pentru calibrarea modelului.
- Alerte: expirare garanții, expirare ATR, revizie scadentă, expirare atestat/etalonare instrument.

### 6.3 Funcții ale registrului
- **Listă cronologică** cu card per fișă: client, localitate, kWp / kWh stocare, mono/tri, stare, dată.
- **Căutare** full-text (client, adresă, POD, serie invertor) și **filtre**: stare, OD, județ, interval
  de putere, tip sistem, an, responsabil.
- **Revizii**: compararea a două revizii ale soluției tehnice (diff câmpuri), restaurare ca revizie nouă.
- **Clonare** fișă ca șablon (client nou, aceeași configurație), **arhivare** (nu ștergere; ștergere
  definitivă doar pentru fișe fără documente emise, cu confirmare).
- **Export**: PDF „dosar complet" (toate secțiunile + documente), ZIP (documente + poze + JSON), CSV al
  registrului; **import** JSON (restaurare / transfer între dispozitive).
- **Statistici**: kWp instalat / lună, nr. lucrări per stare, timp mediu ATR → PIF, distribuție pe OD.
- **Backup** automat (Google Drive AppData, ca în ElectroCalc) + sync electroprep.ro în v2.

### 6.4 Model de date (entități drift)
```
clienti            (id, tip PF/PJ, denumire, contact*, furnizor, cod_client, ...)
lucrari            (id, nr_inregistrare, client_id, tip_lucrare, stare, responsabil_id, firma_id, ...)
lucrari_stari      (id, lucrare_id, stare_din, stare_in, la, de_catre, observatie)          -- audit
locuri_consum      (id, lucrare_id, adresa, lat, lon, judet, localitate, od, pod, nivel_tensiune,
                    bransament, putere_aprobata_kva, schema_lp, contor_*, cladire_*)
relevee            (id, lucrare_id, data, operator, tamb, observatii)
plane_montaj       (id, releveu_id, tip, material, inclinare, azimut, lungime, latime, stare, ...)
obstacole          (id, plan_id, tip, h, d, azimut, x, y)
orizont            (id, releveu_id, azimut, elevatie)
tablou_existent    (id, releveu_id, pozitii_libere, disj_general_in, curba, icu, ddr_tip, ...)
trasee             (id, releveu_id, segment DC/AC/contor, lungime, mod_pozare, tamb_max)
masuratori         (id, lucrare_id, faza releveu|pif|service, tip, valoare, unitate, u_test,
                    iradianta, temp_modul, instrument_id, string_id?, verdict, referinta, la)  -- append-only
instrumente        (id, denumire, serie, etalonare_la, expira_la)
solutii            (id, lucrare_id, revizie, creata_la, tip_sistem, faze, categorie_rfg, regim, ...)
solutii_module     (solutie_id, modul_catalog_id, nr, plan_id, orientare)
solutii_stringuri  (id, solutie_id, invertor_id, mppt, ns, np, voc_tmin, vmp_tmax, verdict)
solutii_invertoare (id, solutie_id, catalog_id, serie, p_ac, s_max, s_evac, cod_retea, zero_export, fw)
solutii_stocare    (id, solutie_id, catalog_id, kwh_nom, kwh_util, dod, p_inc, p_desc, clasa_u, eps)
solutii_protectii  (id, solutie_id, circuit DC/AC, tip_aparat, in, un, curba, icu, idn, uc, up, ...)
solutii_cabluri    (id, solutie_id, segment, tip, sectiune, lungime, iz, delta_u_pct, verdict)
solutii_rezultate  (solutie_id, e_an, e_lunar json, pr, autoconsum, economii, payback, sursa, la)
catalog_*          (module, invertoare, baterii, aparataj — cu prețuri și fișe tehnice)
racordare_pasi     (id, lucrare_id, pas, nr, data, stare, termen, putere_aprobata, atasament_id)
documente          (id, lucrare_id, tip, versiune, emis_la, sha256, cale, solutie_revizie)  -- imutabile
poze               (id, lucrare_id, sectiune, cale, lat, lon, la, adnotari json)
echipamente_serii  (id, lucrare_id, tip, catalog_id, serie, garantie_pana, inlocuit_de_id)
interventii        (id, lucrare_id, tip, data, descriere, cod_eroare, masuratori_ref, urmatoarea_la)
```
Toate tabelele: `id` UUID, `created_at`, `updated_at`, `deleted_at` (soft delete), `version` (pentru sync).
