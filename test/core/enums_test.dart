import 'package:electroapp/core/models/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StareLucrare — fluxul de stări', () {
    test('din lead se poate trece doar la releveu, arhivat sau anulat', () {
      expect(StareLucrare.lead.urmatoare, [
        StareLucrare.releveu,
        StareLucrare.arhivat,
        StareLucrare.anulat,
      ]);
    });

    test('din dimensionare se poate înainta sau reveni un pas', () {
      final u = StareLucrare.dimensionare.urmatoare;
      expect(u, contains(StareLucrare.oferta));
      expect(u, contains(StareLucrare.releveu));
      expect(u, isNot(contains(StareLucrare.atr)));
      expect(u, isNot(contains(StareLucrare.lead)));
    });

    test('exploatare este ultima stare activă', () {
      expect(StareLucrare.exploatare.urmatoare, [
        StareLucrare.certificat,
        StareLucrare.arhivat,
        StareLucrare.anulat,
      ]);
    });

    test('stările terminale nu au tranziții', () {
      expect(StareLucrare.arhivat.urmatoare, isEmpty);
      expect(StareLucrare.anulat.urmatoare, isEmpty);
      expect(StareLucrare.arhivat.esteActiva, isFalse);
    });

    test('codurile persistate sunt unice și stabile', () {
      final coduri = StareLucrare.values.map((s) => s.cod).toSet();
      expect(coduri.length, StareLucrare.values.length);
      expect(StareLucrare.dinCod('pif'), StareLucrare.pif);
      expect(StareLucrare.dinCod('inexistent'), StareLucrare.lead);
    });
  });

  group('enumerările de domeniu', () {
    test('dinCod are valoare implicită sigură', () {
      expect(TipClient.dinCod(null), TipClient.persoanaFizica);
      expect(OperatorDistributie.dinCod('deer'), OperatorDistributie.deer);
      expect(OperatorDistributie.dinCod('x'), OperatorDistributie.altul);
      expect(TipBransament.dinCod('tri'), TipBransament.trifazat);
      expect(SchemaLegarePamant.dinCod('tn_c_s'), SchemaLegarePamant.tnCS);
    });

    test('toate codurile sunt unice per enumerare', () {
      for (final lista in [
        TipClient.values.map((e) => e.cod),
        TipLucrare.values.map((e) => e.cod),
        OperatorDistributie.values.map((e) => e.cod),
        NivelTensiune.values.map((e) => e.cod),
        SchemaLegarePamant.values.map((e) => e.cod),
        TipContor.values.map((e) => e.cod),
        DestinatieCladire.values.map((e) => e.cod),
      ]) {
        expect(lista.toSet().length, lista.length);
      }
    });
  });
}
