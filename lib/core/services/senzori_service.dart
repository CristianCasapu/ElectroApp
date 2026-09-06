import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

import 'log_service.dart';

/// Citirea busolei și a inclinometrului pentru azimutul și înclinarea unui
/// plan de montaj: telefonul se așază pe suprafață (sau se ține paralel cu ea).
class CitireSenzori {
  /// Azimutul suprafeței față de sud: 0 = sud, −90 = est, +90 = vest.
  final double azimutFataDeSud;

  /// Azimutul geografic (0 = nord), după corecția de declinație.
  final double azimutGeografic;
  final double inclinareGrade;
  final bool busolaDisponibila;

  const CitireSenzori({
    required this.azimutFataDeSud,
    required this.azimutGeografic,
    required this.inclinareGrade,
    required this.busolaDisponibila,
  });
}

class SenzoriService {
  /// Declinația magnetică medie în România (2026): busola arată nordul
  /// magnetic, iar azimutul geografic e cu ~6° mai mare.
  static const declinatieRoGrade = 6.0;

  StreamSubscription<AccelerometerEvent>? _accel;
  StreamSubscription<MagnetometerEvent>? _magnet;

  double _ax = 0, _ay = 0, _az = 9.81;
  double _mx = 0, _my = 0, _mz = 0;
  bool _areMagnetometru = false;

  final _controller = StreamController<CitireSenzori>.broadcast();
  Stream<CitireSenzori> get citiri => _controller.stream;

  bool get activ => _accel != null;

  void porneste() {
    if (_accel != null) return;
    log.debug('senzori', 'Pornesc busola și inclinometrul');
    _accel =
        accelerometerEventStream(
          samplingPeriod: const Duration(milliseconds: 100),
        ).listen(
          (e) {
            // filtru trece-jos: mâna tremură, acoperișul nu
            _ax = _ax * 0.8 + e.x * 0.2;
            _ay = _ay * 0.8 + e.y * 0.2;
            _az = _az * 0.8 + e.z * 0.2;
            _emite();
          },
          onError: (Object e) =>
              log.warn('senzori', 'Accelerometru indisponibil', '$e'),
        );
    _magnet =
        magnetometerEventStream(
          samplingPeriod: const Duration(milliseconds: 100),
        ).listen(
          (e) {
            _areMagnetometru = true;
            _mx = _mx * 0.8 + e.x * 0.2;
            _my = _my * 0.8 + e.y * 0.2;
            _mz = _mz * 0.8 + e.z * 0.2;
          },
          onError: (Object e) {
            _areMagnetometru = false;
            log.warn('senzori', 'Magnetometru indisponibil', '$e');
          },
        );
  }

  Future<void> opreste() async {
    await _accel?.cancel();
    await _magnet?.cancel();
    _accel = null;
    _magnet = null;
  }

  Future<void> inchide() async {
    await opreste();
    await _controller.close();
  }

  void _emite() {
    if (_controller.isClosed) return;
    _controller.add(
      calculeaza(
        ax: _ax,
        ay: _ay,
        az: _az,
        mx: _mx,
        my: _my,
        mz: _mz,
        areMagnetometru: _areMagnetometru,
      ),
    );
  }

  /// Înclinarea față de orizontală și azimutul suprafeței pe care stă
  /// telefonul, cu ecranul în sus. Separată de senzori pentru a fi testabilă.
  ///
  ///   înclinare = unghiul dintre axa Z a telefonului și verticală
  ///   azimut    = direcția de coborâre a pantei (unde „privesc" modulele)
  static CitireSenzori calculeaza({
    required double ax,
    required double ay,
    required double az,
    required double mx,
    required double my,
    required double mz,
    required bool areMagnetometru,
  }) {
    final norma = sqrt(ax * ax + ay * ay + az * az);
    final inclinare = norma < 0.5
        ? 0.0
        : acos((az / norma).clamp(-1.0, 1.0)) * 180 / pi;

    if (!areMagnetometru || (mx == 0 && my == 0 && mz == 0)) {
      return CitireSenzori(
        azimutFataDeSud: 0,
        azimutGeografic: 0,
        inclinareGrade: inclinare,
        busolaDisponibila: false,
      );
    }

    // compensarea înclinării: proiectăm câmpul magnetic în planul orizontal
    final n = norma == 0 ? 1 : norma;
    final gx = ax / n, gy = ay / n, gz = az / n;
    final estX = my * gz - mz * gy;
    final estY = mz * gx - mx * gz;
    final estZ = mx * gy - my * gx;
    final normaEst = sqrt(estX * estX + estY * estY + estZ * estZ);
    if (normaEst < 1e-6) {
      return CitireSenzori(
        azimutFataDeSud: 0,
        azimutGeografic: 0,
        inclinareGrade: inclinare,
        busolaDisponibila: false,
      );
    }
    final ex = estX / normaEst, ey = estY / normaEst;
    // direcția de coborâre a pantei, proiectată pe orizontală
    final pantaX = -gx, pantaY = -gy;
    final nordX = gy * ex - gx * ey; // componenta nord a versorului
    var heading = atan2(pantaX * ex + pantaY * ey, pantaX * -ey + pantaY * ex);
    heading = heading * 180 / pi;
    if (nordX.isNaN) heading = 0;
    var geografic = (heading + declinatieRoGrade) % 360;
    if (geografic < 0) geografic += 360;
    // 0 = sud: azimutul PV se măsoară față de sud, pozitiv spre vest
    var fataDeSud = geografic - 180;
    if (fataDeSud > 180) fataDeSud -= 360;
    if (fataDeSud < -180) fataDeSud += 360;

    return CitireSenzori(
      azimutFataDeSud: fataDeSud,
      azimutGeografic: geografic,
      inclinareGrade: inclinare,
      busolaDisponibila: true,
    );
  }

  /// Denumirea orientării, pentru afișare: „sud", „sud-est"…
  static String directie(double azimutFataDeSud) {
    final a = azimutFataDeSud;
    if (a.abs() <= 22.5) return 'sud';
    if (a > 22.5 && a <= 67.5) return 'sud-vest';
    if (a > 67.5 && a <= 112.5) return 'vest';
    if (a > 112.5 && a <= 157.5) return 'nord-vest';
    if (a < -22.5 && a >= -67.5) return 'sud-est';
    if (a < -67.5 && a >= -112.5) return 'est';
    if (a < -112.5 && a >= -157.5) return 'nord-est';
    return 'nord';
  }
}
