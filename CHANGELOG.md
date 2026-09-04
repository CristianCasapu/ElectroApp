# Changelog

## [v0.1.2] — 2026-09-04

### Added
- Actualizare din aplicație: verificare silențioasă la pornire și „Caută actualizări" în
  Setări; descărcare din GitHub Releases cu progres și instalare directă (FileProvider).
- Logo și iconiță adaptivă Android (panou fotovoltaic, invertor, fișă cu bife, soare),
  generate din `scripts/logo.py`; variantă SVG în `assets/logo/logo.svg`.

## [v0.1.1] — 2026-09-04

### Added
- Schelet aplicație (etapa E0): Flutter 3.44, Riverpod 3, go_router 18, drift.
- Registru de lucrări cu fișe numerotate `FL-<an>-<nr>`, flux de stări jurnalizat,
  căutare și filtre după stare.
- Fișa de lucrare: beneficiar, tip lucrare, loc de consum (OD, POD, nivel tensiune,
  branșament, putere aprobată/contractată, schemă de legare la pământ, grup de măsură).
- Gestiune clienți (PF/PJ) cu selector din fișă și creare rapidă.
- Profil firmă: date firmă, atestat ANRE, electrician semnatar.
- Temă luminoasă/întunecată (preluată din ElectroCalc), localități RO cu autocomplete.
- Teste: enumerări și flux de stări, repository-uri pe SQLite în memorie, test de widget.
- CI: release automat la tag `v*` (APK semnat).
- `docs/CERCETARE.md`: cercetare legislație, formule, stack, specificația registrului.
