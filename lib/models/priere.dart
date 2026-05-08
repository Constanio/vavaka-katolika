class Priere {
  final int id;
  final String titre;
  final String categorie;
  final String contenu;

  Priere({
    required this.id,
    required this.titre,
    required this.categorie,
    required this.contenu,
  });

  factory Priere.fromJson(Map<String, dynamic> json) {
    return Priere(
      id: json['id'] as int,
      titre: json['titre'] as String,
      categorie: json['categorie'] as String,
      contenu: json['contenu'] as String,
    );
  }
}