import 'package:electroapp/core/models/profil_firma.dart';
import 'package:electroapp/core/utils/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatNumar / parseNumar', () {
    test('elimină zerourile inutile și folosește virgula', () {
      expect(formatNumar(5), '5');
      expect(formatNumar(5.5), '5,5');
      expect(formatNumar(10.25), '10,25');
      expect(formatNumar(null), '—');
    });

    test('acceptă virgulă sau punct la introducere', () {
      expect(parseNumar('7,5'), 7.5);
      expect(parseNumar('7.5'), 7.5);
      expect(parseNumar(' '), isNull);
      expect(parseNumar('abc'), isNull);
      expect(parseIntreg('32'), 32);
      expect(parseIntreg('32.5'), isNull);
    });
  });

  group('ProfilFirma', () {
    test('serializarea este reversibilă', () {
      const p = ProfilFirma(
        denumire: 'Electro SRL',
        cui: 'RO123',
        atestatTip: 'Bi',
        electricianNume: 'Ion Popescu',
        electricianGrad: 'IIB',
      );
      final refacut = ProfilFirma.fromMap(p.toMap());
      expect(refacut.denumire, 'Electro SRL');
      expect(refacut.cui, 'RO123');
      expect(refacut.atestatTip, 'Bi');
      expect(refacut.electricianGrad, 'IIB');
      expect(refacut.esteCompletat, isTrue);
      expect(const ProfilFirma().esteCompletat, isFalse);
    });
  });
}
