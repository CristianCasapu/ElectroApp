# Changelog

## [Nelansat]

## [v0.1.6] — 2026-09-06

### Added
- **E2 — Măsurători instrumentale**, deschise din fișa de lucrare, pe trei faze:
  la releveu, la punerea în funcțiune și la service.
  - **Verificările de categoria 1 din IEC 62446-1**: continuitatea
    echipotențializării, polaritatea, Voc și Isc pe fiecare string, curentul de
    funcționare, rezistența de izolație DC, pornirea invertorului, testul
    anti-islanding, limitarea puterii evacuate și decuplarea pentru pompieri.
  - **Verdict automat pentru fiecare valoare**, cu limita și referința
    normativă: izolația se compară cu 1 MΩ (0,5 MΩ sub 120 V) la tensiunea de
    test corespunzătoare tensiunii sistemului, continuitatea cu 1 Ω, priza de
    pământ cu 4 Ω, timpul de declanșare al DDR cu 300 ms, iar dezechilibrul
    între faze cu 16 A conform Ord. ANRE 228/2018 art. 12(3).
  - **Corecția la condiții standard**: Voc măsurat pe module calde și Isc
    măsurat pe cer acoperit sunt raportate la STC din iradianță, temperatura
    modulului și coeficienții de temperatură, apoi comparate cu valorile
    soluției tehnice salvate.
  - **Măsurători append-only**: o corectură nu suprascrie nimic, ci înlocuiește
    valoarea veche și o păstrează vizibilă în istoric.
  - **Aparatura de măsură** cu serie și termen de etalonare; instrumentele cu
    etalonarea expirată sunt semnalate.
  - Ecranul arată permanent ce verificări obligatorii lipsesc din dosarul de
    punere în funcțiune.
- **Buletin de verificări la punerea în funcțiune (PDF)**, emis din ecranul de
  măsurători: instalația verificată, valorile pe partea de curent continuu, pe
  cea de curent alternativ și cele funcționale, aparatura folosită, concluzia
  cu neconformitățile și verificările nemăsurate, rubricile de semnătură.
- **Fotografii de șantier** organizate pe secțiuni (plan, obstacol, tablou,
  contor, traseu, amplasare, punere în funcțiune), făcute cu camera sau alese
  din galerie, cu descriere și coordonate; rămân în directorul aplicației și se
  pot trimite sau șterge. Lipsa fotografiilor de plan, tablou și contor este
  semnalată.

### Changed
- Documentele emise din soluția tehnică rămân fișa sistemului și cele trei
  oferte; buletinul de verificări se emite separat, din măsurători.
- Textele care ajung în PDF nu mai folosesc săgeata „→", pentru care fontul
  inclus în aplicație nu are glifă.

### Changed
- APK-ul publicat se numește `ElectroApp.apk`, fără versiune în nume, ca adresa
  `releases/latest/download/ElectroApp.apk` să rămână stabilă; aplicația preferă
  acest fișier la actualizare, dar acceptă și release-urile vechi.

## [v0.1.5] — 2026-09-06

### Added
- **E2 — Releveu tehnic de șantier**, deschis din fișa de lucrare:
  - **Plane de montaj** (acoperiș înclinat, terasă, sol, fațadă, carport) cu
    învelitoare, dimensiuni utile, secțiunea căpriorilor și interaxul, starea
    structurii; un plan marcat neconform este semnalat ca oprire în ofertă.
  - **Azimut și înclinare din senzorii telefonului**: inclinometru din
    accelerometru și busolă compensată de înclinare, cu declinația magnetică
    a României; valorile se preiau cu un tap, iar telefoanele fără magnetometru
    păstrează inclinometrul.
  - **Capacitatea fiecărui plan**: retrageri de siguranță după P118-1/2025
    (1 m perimetral, 0,5 m la lucarne, câmpuri de maximum 40×40 m), numărul de
    module care încap, kWp și distanța între rânduri pe suprafețele orizontale,
    calculată din unghiul solar de iarnă al latitudinii județului.
  - **Obstacole și umbrire** (coșuri, aerisiri, luminatoare, copaci, clădiri):
    factor de umbrire estimat din înălțime și distanță.
  - **Tabloul electric existent**: poziții libere, disjunctor general, Icu, DDR
    și IΔn, SPD, bară PE separată, secțiunea coloanei.
  - **Traseele de cablu** măsurate pe segmente (DC, AC, contor, baterie, pământ).
  - **Încărcări climatice**: zăpadă CR 1-1-3 și vânt CR 1-1-4, cu valorile uzuale.
- **Estimarea preia automat releveul**: suprafața pe care încap module, orientarea
  planului principal, umbrirea ponderată, tipul de acoperiș și lungimile traseelor.
- 20 de teste noi (geometrie, umbrire, capacitate, încărcări, senzori, repository).

## [v0.1.4] — 2026-09-04

### Added
- **Jurnal de depanare** (Setări → Depanare): fiecare operație importantă se
  înregistrează pe telefon cu oră, zonă și detalii — pornirea aplicației, migrările
  bazei de date, clienți creați/modificați/șterși, fișe și tranziții de stare (inclusiv
  cele refuzate, cu motivul), furnizori adăugați, interogări ANAF, geocodare și poziție
  (OpenStreetMap), selectarea contactelor, calculul sistemului fotovoltaic (intrări și
  rezultat), reviziile soluției, documentele PDF emise, verificarea și descărcarea
  actualizărilor, navigarea între ecrane.
- **Crash-urile se scriu automat** cu stack trace (erori Flutter și de platformă).
- Niveluri configurabile Debug / Info / Warn / Error, comutator pornit/oprit,
  căutare și filtrare în jurnal.
- **„Trimite logurile"** — fișier cu antet de diagnostic (versiunea aplicației, marca,
  modelul telefonului, versiunea Android) pe care îl poți atașa la un raport; plus
  copiere în clipboard și ștergere. Jurnalul nu părăsește telefonul fără această acțiune.
- Jurnal rotativ (max ~512 KB, se păstrează coada), scriere grupată ca să nu
  încetinească interfața.

### Fixed
- Sumele de control scurte nu mai provoacă eroare la afișare și în jurnal.
- Ștergerea jurnalului nu mai eșuează când fișierul e blocat de sistem.

### Changed
- CI: tag-ul mobil `latest` se mută automat pe ultimul release publicat.

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
