/// Rezultatul unei verificări de dimensionare: valoarea, limita, verdictul și
/// referința normativă. Orice număr afișat utilizatorului poartă ipoteza și
/// sursa lui (CLAUDE.md, „Reguli de cod").
enum NivelVerdict { conform, atentie, neconform, informativ }

class Verdict {
  final String cod;
  final String titlu;
  final NivelVerdict nivel;
  final String detaliu;
  final String referinta;

  const Verdict({
    required this.cod,
    required this.titlu,
    required this.nivel,
    required this.detaliu,
    required this.referinta,
  });

  bool get esteOk => nivel != NivelVerdict.neconform;

  @override
  String toString() => '[$nivel] $titlu — $detaliu ($referinta)';
}
