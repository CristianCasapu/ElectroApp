# ElectroApp ☀️⚡

Aplicație Android pentru electricieni care proiectează și montează sisteme fotovoltaice
(monofazat, trifazat, cu stocare, injecție în rețea JT / MT). Ține un **registru de lucrări**
în care fiecare fișă adună beneficiarul, locul de consum, releveul de șantier, măsurătorile,
soluția tehnică adoptată, pașii de racordare și documentele emise. Funcționează complet offline.

## Stare: etapa E0 (schelet)

Disponibil acum:

- **Registru de lucrări** — fișe cu număr de înregistrare `FL-<an>-<nr>`, flux de stări
  (Lead → Releveu → Dimensionare → Ofertă → ATR → Execuție → PIF → Certificat → Exploatare),
  istoric jurnalizat al tranzițiilor, căutare și filtre.
- **Fișa de lucrare** — beneficiar (PF/PJ, calitate), tip lucrare, loc de consum (adresă,
  localitate cu autocomplete, operator de distribuție, cod POD, nivel de tensiune, branșament
  mono/trifazat, putere aprobată/contractată, disjunctor, schemă de legare la pământ, grup de
  măsură, destinația clădirii).
- **Clienți** — persoane fizice/juridice cu date de contact, juridice și furnizor de energie.
- **Profil firmă** — date firmă, atestat ANRE, electrician semnatar (grad, legitimație).
- Temă luminoasă / întunecată.

Urmează (vezi [docs/CERCETARE.md](docs/CERCETARE.md) §4.4):

| Etapă | Conținut |
|---|---|
| E1 | Motor de calcul: string-uri (Voc/Vmp/MPPT, IEC 62548), circuit AC (I7-2011), cablu DC și protecții, stocare, randament PVGIS + model offline |
| E2 | Releveu tehnic (plane de acoperiș, umbrire, tablou, trasee, poze), măsurători instrumentale și teste PIF IEC 62446-1 |
| E3 | Rapoarte PDF: ofertă, PV recepție, raport verificări, buletin PRAM, listă DIU |
| E4 | Catalog echipamente, urmărire racordare/avize (ATR, DIU, certificat), export/backup |
| E5 | Sincronizare cu electroprep.ro, hartă, QR serii, MT |

## Instalare

Descarcă cel mai recent `ElectroApp-vX.Y.Z.apk` din
[Releases](https://github.com/CristianCasapu/ElectroApp/releases) și instalează-l pe telefon
(Android 7.0+; acceptă „Instalare din surse necunoscute").

## Compilare

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze && flutter test
flutter build apk --debug
```

Build-ul de release cere `android/key.properties` cu keystore-ul propriu (nu este în repo).

## Documentație

- [docs/CERCETARE.md](docs/CERCETARE.md) — cadrul legislativ RO/UE (ANRE, prosumatori, RfG,
  P118-1, stocare), formulele de dimensionare, peisajul competitiv, stack-ul și specificația
  registrului de lucrări cu modelul de date.
- [CLAUDE.md](CLAUDE.md) — convenții de dezvoltare.

## Licență

Cod sursă publicat pentru transparență. Toate drepturile rezervate — Cristian Casapu.

---
v0.1.0
