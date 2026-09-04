# ElectroApp — instrucțiuni pentru Claude Code

## Ce este
Aplicație Android (Flutter/Dart) pentru un electrician care montează sisteme fotovoltaice:
**registru de lucrări** cu fișe de lucrare (beneficiar, loc de consum, releveu, măsurători,
soluție tehnică, racordare, documente), calcule de dimensionare și rapoarte PDF. Offline-first.
Va fi integrată ulterior cu electroprep.ro (repo `CristianCasapu/ChestionareElectricianANRE`).

- `docs/CERCETARE.md` — cercetarea de legislație, formule și arhitectură (§6 = specificația
  registrului și modelul de date). **Sursa de adevăr** pentru decizii; nu modifica concluziile
  fără surse noi. Valorile legislative se codează ca date configurabile, nu constante.
- Repo public: `CristianCasapu/ElectroApp`. **Fără chei API, token-uri sau keystore în cod.**
- Limbă: UI, documentație, comentarii și mesaje de commit în **română**. Identificatorii Dart
  urmează vocabularul din `docs/CERCETARE.md §6` (fișă de lucrare, loc de consum, releveu…).
- **Nu se reproduce textul standardelor SR EN / SR HD (ASRO)** — doar numărul și, la nevoie,
  parafrazarea regulii. Textele ANRE/I7 pot fi citate cu articol.

## Stack
Flutter 3.44 / Dart 3.12, Material 3 (temă preluată din ElectroCalc), Riverpod 3, go_router 18,
**drift** (SQLite, cod generat comis în repo), `pdf` + `printing` (din E3). Android: minSdk 24,
targetSdk/compileSdk 36, `applicationId ro.ccii.electroapp`.

## Etape (docs/CERCETARE.md §4.4)
E0 schelet + registru ✅ · E1 motor de calcul + estimare + oferte PDF ✅ · E2 releveu +
măsurători · E3 restul rapoartelor PDF · E4 catalog editabil, racordare, export · E5 sync
electroprep.ro, hartă, MT.

## Structura
```
lib/
  main.dart                 ProviderScope + MaterialApp.router
  app/                      router.dart (shell cu 4 tab-uri), providers.dart, app_theme/app_colors
  core/
    models/enums.dart       vocabularul de domeniu — `cod` persistat, `eticheta` afișată
    models/profil_firma.dart
    db/tables.dart          schema drift (mixin EntitateComuna: id UUID, created/updated/deleted_at, version)
    db/database.dart(.g)    AppDatabase — `dart run build_runner build -d` după orice modificare de schemă
    db/repositories.dart    ClientiRepository, LucrariRepository (nr. FL-<an>-<secv>, tranziții de stare
                            jurnalizate), SetariRepository
    data/                   localitati_romania.dart (copiat din ElectroCalc), ulterior rules/ JSON
    calc/                   motor de calcul pur Dart, cu teste — NICIO formulă în ecrane:
                            echipamente (catalog implicit), pv_string (IEC 62548), pv_randament
                            (județ × orientare), pv_estimare (sistem din consum), materiale (BOM +
                            prețuri), cablu_ac (I7-2011, din ElectroCalc), verdict
    models/solutie.dart     snapshot serializabil al estimării (revizii + documente)
    services/raport_pdf_service.dart  fișa sistemului + oferte (pdf, fonturi Roboto din assets)
    utils/format.dart       formatData/formatNumar/parseNumar (virgulă zecimală)
  features/<domeniu>/       ecrane; registru/, clienti/, calcule/, setari/
  widgets/                  calc_widgets.dart, result_card.dart (din ElectroCalc), common_widgets.dart
test/                       core/ (enums, format, repositories cu NativeDatabase.memory()), widget_test.dart
```

## Reguli de cod
- Formule și reguli de dimensionare doar în `core/calc/`, cu teste și cu referința normativă în
  rezultat (numărul standardului / articolul), niciodată în `build()`.
- Măsurătorile și documentele emise sunt **append-only**; soluția tehnică se salvează pe revizii.
  Ștergerile sunt logice (`deleted_at`); numerele de înregistrare nu se refolosesc.
- Culorile doar prin `app_colors.dart` (`context.accentBlue`, `context.infoSurface`…); nu
  `Colors.grey` direct. `resizeToAvoidBottomInset: true` pe ecranele cu câmpuri text.
- Fără comentarii pentru cod evident; fără feature flags sau shim-uri de compatibilitate.
- Orice modificare de schemă: crește `schemaVersion`, adaugă migrarea în `MigrationStrategy`,
  regenerează, adaugă test. Datele existente nu se pierd.

## Comenzi
```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # după modificări în tables.dart
flutter analyze
flutter test
flutter build apk --debug                                    # verificare rapidă
.\scripts\build_release.ps1                                  # APK release semnat (cere android/key.properties)
```

## Versionare și release
- `pubspec.yaml`: `version: MAJOR.MINOR.PATCH+BUILD`; tag GitHub `vMAJOR.MINOR.BUILD`
  (ex. `0.1.0+3` → `v0.1.3`). BUILD crește la fiecare release — Android refuză instalarea peste
  un versionCode egal sau mai mic.
- La fiecare release: secțiune nouă în `CHANGELOG.md` și versiunea din `README.md`.
- CI: `.github/workflows/release.yml` la tag `v*` → APK semnat + GitHub Release. Secretele
  necesare: `KEYSTORE_BASE64`, `KEYSTORE_PASSWORD`, `KEY_PASSWORD`, `KEY_ALIAS`.

## Semnare
- Keystore: `android/app/electroapp-release.jks` + `android/key.properties` — **gitignorate**,
  păstrate pe mașina proprietarului și în GitHub Secrets. **Nu se generează niciodată alt keystore**
  și nu se semnează cu cheia de debug: build-ul de release eșuează explicit fără `key.properties`.

## Definition of Done
`flutter analyze` fără probleme, `flutter test` verde, build de debug reușit; pentru schimbări
de UI, verificare pe device fizic. CHANGELOG și README actualizate la release.
