# Changelog

## [v0.1.3] — 2026-09-04

### Added
- **E1 — Soluția tehnică**: estimarea sistemului fotovoltaic din consum, branșament,
  putere aprobată, județ, orientare/înclinare, suprafață și stocare: putere kWp, număr
  de module, configurația string-urilor (Voc la Tmin, Vmp la 70 °C, fereastra MPPT,
  Isc, raport DC/AC — IEC 62548), invertor și baterii din catalogul implicit,
  producție anuală și lunară pe județ, autoconsum, economie, regim prosumator,
  verdicte cu referință normativă (Ord. ANRE 228/2018 art. 12(3) și 14(3)).
- Necesar de materiale generat automat (module, invertor, baterii, cablu DC/AC
  dimensionat după I7-2011, protecții DC/AC, structură, legare la pământ, diverse)
  și manoperă, cu prețuri orientative editabile ulterior.
- Soluția se salvează pe revizii imutabile (R1, R2, …) în fișa de lucrare.
- Documente PDF emise din revizie, cu datele firmei, electricianului și
  beneficiarului: fișa sistemului fotovoltaic, ofertă materiale, ofertă manoperă,
  ofertă completă cu desfășurător și TVA; fonturi incluse (offline), versiune și
  SHA-256 per document; previzualizare/tipărire și trimitere.
- Calculatorul de cabluri I7-2011 (secțiune, cădere de tensiune, disjunctor) preluat
  din ElectroCalc, cu testele lui.
- Client: nume, telefon, e-mail și adresă din agenda telefonului (fără permisiunea
  READ_CONTACTS — selectorul sistemului); adresa din locația curentă prin
  OpenStreetMap Nominatim; completare automată din registrul ANAF pe baza CUI/CIF
  (denumire, adresă, Reg. Com., telefon, statut TVA) pentru PJ, asociații, instituții.
- Furnizor de energie: lista marilor furnizori din România, opțiunea off-grid și
  furnizori adăugați de utilizator; cod client și cod POD pe client.
- Fișa de lucrare: furnizor și cod client pe locul de consum (preluate din client),
  adresă din locație cu coordonate salvate pentru PVGIS.

### Fixed
- Selectorul de localitate: câmpul primește doar localitatea, județul rămâne valid;
  un text scris liber golește județul.
- Tag-uri Hero distincte pentru butoanele flotante (excepție la navigare în debug).
- Descărcarea actualizării: timeout, anulare, ștergerea fișierului parțial.
- Salvarea eșuată nu mai blochează butonul; fișă/client inexistent afișează mesaj.
- Filtrul „Arhivate" nu mai combină chip-uri de stare active.
- `version` crește la fiecare scriere (pregătire sincronizare).
- CI: tag-ul trebuie să corespundă cu MAJOR.MINOR din pubspec, nu doar cu BUILD.

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
