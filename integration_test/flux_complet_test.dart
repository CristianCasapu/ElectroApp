import 'package:drift/native.dart';
import 'package:electroapp/app/providers.dart';
import 'package:electroapp/core/db/database.dart';
import 'package:electroapp/core/services/update_service.dart';
import 'package:electroapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Fluxul complet pe device/emulator, cu baza de date reală (drift în memorie):
/// profil firmă → client → fișă de lucrare → detaliu → stare → editare →
/// registru (căutare/filtre) → client cu fișe nu se șterge → ștergere fișă.
///
///   flutter test integration_test/flux_complet_test.dart -d emulator-5554
class _FaraActualizari extends UpdateService {
  @override
  Future<UpdateInfo?> verifica() async => null;
}

Future<void> _settle(WidgetTester t) async {
  await t.pumpAndSettle(const Duration(milliseconds: 100));
}

/// Așteaptă widget-ul (stream-urile drift emit prin I/O real), apoi derulează
/// lista — listele sunt leneșe, iar un câmp de sub marginea ecranului nu e
/// construit încă. `scrollUntilVisible` nu e fiabil aici (mai multe Scrollable
/// pe ecran), deci derulăm explicit lista principală.
Future<void> _vizibil(WidgetTester t, Finder f) async {
  for (var i = 0; i < 20 && f.evaluate().isEmpty; i++) {
    await t.pump(const Duration(milliseconds: 100));
  }
  final lista = find.byType(ListView);
  if (lista.evaluate().isNotEmpty) {
    for (final directie in [-280.0, 280.0]) {
      for (var i = 0; i < 10 && f.evaluate().isEmpty; i++) {
        await t.drag(lista.first, Offset(0, directie));
        await t.pump(const Duration(milliseconds: 120));
      }
    }
  }
  if (f.evaluate().length != 1) {
    final texte = find
        .byType(Text)
        .evaluate()
        .map((e) => (e.widget as Text).data)
        .whereType<String>()
        .where((s) => s.trim().isNotEmpty)
        .toList();
    debugPrint('>> negăsit: $f — texte pe ecran: $texte');
  }
  expect(f, findsOneWidget);
  await t.ensureVisible(f);
  await t.pump();
}

Future<void> _scrie(WidgetTester t, String label, String text) async {
  final f = find.widgetWithText(TextFormField, label);
  await _vizibil(t, f);
  await t.enterText(f, text);
  await t.pump();
}

Future<void> _apasa(WidgetTester t, Finder f) async {
  await _vizibil(t, f);
  await t.tap(f);
  await _settle(t);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('flux complet pe device', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase.inMemory(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          databaseProvider.overrideWithValue(db),
          updateServiceProvider.overrideWithValue(_FaraActualizari()),
        ],
        child: const ElectroApp(),
      ),
    );
    await _settle(tester);
    expect(find.text('Registrul este gol'), findsOneWidget);

    // ── Profil firmă ──────────────────────────────────────────────────────
    await _apasa(tester, find.byIcon(Icons.settings_outlined));
    await _apasa(tester, find.text('Profil firmă și electrician'));
    await _scrie(tester, 'Denumire firmă', 'Electro Test SRL');
    await _scrie(tester, 'Nume și prenume', 'Ion Electricianu');
    await _scrie(tester, 'Grad autorizare (ex. IIB, IIIA)', 'IIB');
    await _apasa(tester, find.text('Salvează profilul'));
    expect(find.text('Electro Test SRL'), findsOneWidget);

    // Tema
    await _apasa(tester, find.text('Întunecată'));
    expect(prefs.getString('theme_mode'), 'dark');
    await _apasa(tester, find.text('Luminoasă'));

    // ── Client ────────────────────────────────────────────────────────────
    await _apasa(tester, find.byIcon(Icons.people_outline));
    expect(find.text('Niciun client'), findsOneWidget);
    await _apasa(tester, find.text('Client nou'));
    await _apasa(tester, find.text('Pers. juridică'));
    await _scrie(tester, 'Denumire', 'Ferma Solar SRL');
    await _scrie(tester, 'Telefon', '0722000000');
    await _scrie(tester, 'CUI / CIF', 'ro12345');
    // furnizorul din lista predefinită + cod client și POD
    await _apasa(tester, find.text('— neprecizat —'));
    await _apasa(tester, find.text('Hidroelectrica').last);
    await _scrie(tester, 'Cod client', '123456');
    await _scrie(tester, 'Cod POD', 'ro002e12345');
    await _apasa(tester, find.text('Adaugă clientul'));
    expect(find.text('Ferma Solar SRL'), findsOneWidget);
    expect(find.textContaining('CUI RO12345'), findsOneWidget);

    // ── Fișă de lucrare nouă ──────────────────────────────────────────────
    await _apasa(tester, find.byIcon(Icons.folder_open_outlined));
    await _apasa(tester, find.text('Fișă nouă'));
    // Salvarea fără beneficiar e refuzată
    await _apasa(tester, find.text('Deschide fișa'));
    expect(find.text('Alege beneficiarul fișei'), findsOneWidget);

    await _apasa(tester, find.text('Alege beneficiarul'));
    await _apasa(tester, find.text('Ferma Solar SRL').last);
    expect(find.text('Ferma Solar SRL'), findsOneWidget);
    // datele de energie ale clientului au fost preluate în locul de consum
    expect(find.text('Hidroelectrica'), findsOneWidget);
    expect(
      find.widgetWithText(TextFormField, 'Cod POD (punct de măsură)'),
      findsOneWidget,
    );

    await _scrie(tester, 'Titlu (opțional)', 'Hibrid 10 kWp cu stocare');
    await _scrie(tester, 'Adresă (stradă, număr)', 'Str. Soarelui 7');
    await _scrie(tester, 'Localitate', 'Craio');
    await _settle(tester);
    await _apasa(tester, find.text('Craiova, Dolj'));
    expect(find.text('Județ: Dolj'), findsOneWidget);

    await _apasa(tester, find.text('Trifazat'));
    await _scrie(tester, 'Putere aprobată', '10,5');
    await _scrie(tester, 'Disjunctor la punctul de delimitare', '32');
    await _apasa(tester, find.text('Deschide fișa'));

    // ── Detaliu ───────────────────────────────────────────────────────────
    expect(find.textContaining('FL-'), findsWidgets);
    expect(find.text('Hibrid 10 kWp cu stocare'), findsOneWidget);
    expect(find.text('RO002E12345'), findsWidgets);
    expect(find.text('Hidroelectrica'), findsWidgets);
    expect(find.text('123456'), findsWidgets);
    expect(find.text('10,5 kVA'), findsOneWidget);
    expect(find.text('Craiova, Dolj'), findsOneWidget);
    expect(find.text('Lead'), findsWidgets);

    // Tranziție de stare, cu observație
    await _apasa(tester, find.text('Schimbă starea'));
    await _apasa(tester, find.text('Releveu'));
    await _scrie(tester, 'Observație (opțional)', 'Vizită programată luni');
    await _apasa(tester, find.text('Confirmă'));
    expect(find.text('Lead → Releveu'), findsOneWidget);
    expect(find.textContaining('Ion Electricianu'), findsOneWidget);
    expect(find.textContaining('Vizită programată luni'), findsOneWidget);

    // ── Editare ───────────────────────────────────────────────────────────
    await _apasa(tester, find.byIcon(Icons.edit_outlined));
    expect(find.text('Editare fișă'), findsOneWidget);
    expect(find.text('Județ: Dolj'), findsOneWidget);
    await _scrie(tester, 'Titlu (opțional)', 'Hibrid 12 kWp');
    await _apasa(tester, find.text('Salvează modificările'));
    expect(find.text('Hibrid 12 kWp'), findsOneWidget);
    expect(find.text('Releveu'), findsWidgets);

    // ── E1: estimare → revizie → PDF ──────────────────────────────────────
    await _apasa(tester, find.text('Estimare'));
    expect(find.textContaining('Estimare ·'), findsOneWidget);
    await _scrie(tester, 'Consum anual', '6000');
    await _apasa(tester, find.text('Calculează sistemul'));
    expect(find.text('Sistemul propus'), findsOneWidget);
    expect(find.text('Verificări de dimensionare'), findsOneWidget);
    await _apasa(tester, find.text('Salvează ca revizie a soluției tehnice'));
    expect(find.textContaining('Revizia R1'), findsOneWidget);
    await _apasa(tester, find.text('Fișa sistemului fotovoltaic'));
    // foaia de acțiuni a documentului emis
    expect(find.text('Previzualizează / tipărește'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await _settle(tester);
    await tester.pageBack();
    await _settle(tester);
    expect(find.text('Fișa sistemului fotovoltaic v1'), findsOneWidget);
    expect(find.textContaining('kWp ·'), findsWidgets);

    // ── Registru: căutare și filtre ───────────────────────────────────────
    await tester.pageBack();
    await _settle(tester);
    expect(find.text('Ferma Solar SRL'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(
        TextField,
        'Caută după client, adresă, POD, nr. fișă',
      ),
      'inexistent',
    );
    await _settle(tester);
    expect(find.text('Nicio fișă nu corespunde'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(
        TextField,
        'Caută după client, adresă, POD, nr. fișă',
      ),
      'RO002E',
    );
    await _settle(tester);
    expect(find.text('Ferma Solar SRL'), findsOneWidget);
    await _apasa(tester, find.byIcon(Icons.clear));
    await _apasa(tester, find.text('Arhivate'));
    expect(find.text('Nicio fișă nu corespunde'), findsOneWidget);
    await _apasa(tester, find.text('Active'));

    // ── Clientul cu fișe nu se șterge ─────────────────────────────────────
    await _apasa(tester, find.byIcon(Icons.people_outline));
    await _apasa(tester, find.text('Ferma Solar SRL'));
    expect(find.text('1 fișe de lucrare asociate'), findsOneWidget);
    await _apasa(tester, find.byIcon(Icons.delete_outline));
    expect(find.textContaining('nu poate fi șters'), findsOneWidget);
    await _apasa(tester, find.text('Renunță'));
    await tester.pageBack();
    await _settle(tester);

    // ── Ștergere fișă ─────────────────────────────────────────────────────
    await _apasa(tester, find.byIcon(Icons.folder_open_outlined));
    await _apasa(tester, find.text('Ferma Solar SRL'));
    await _apasa(tester, find.byType(PopupMenuButton<String>));
    await _apasa(tester, find.text('Șterge fișa'));
    await _apasa(tester, find.text('Șterge'));
    expect(find.text('Registrul este gol'), findsOneWidget);
  });
}
