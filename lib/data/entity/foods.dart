// ignore_for_file: public_member_api_docs, sort_constructors_first
class Foods {
  String id;
  String name;
  String picture;
  String price;
  Foods({
    required this.id,
    required this.name,
    required this.picture,
    required this.price,
  });

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(
      id: json["yemek_id"] as String,
      name: json["yemek_adi"] as String,
      picture: json["yemek_resim_adi"] as String,
      price: json["yemek_fiyat"] as String,
    );
  }
}
