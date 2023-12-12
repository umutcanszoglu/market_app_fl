// ignore_for_file: public_member_api_docs, sort_constructors_first
class Carts {
  String id;
  String name;
  String picture;
  String price;
  String count;
  String username;
  Carts({
    required this.id,
    required this.name,
    required this.picture,
    required this.price,
    required this.count,
    required this.username,
  });

  factory Carts.fromJson(Map<String, dynamic> json) {
    return Carts(
      id: json["sepet_yemek_id"] as String,
      name: json["yemek_adi"] as String,
      picture: json["yemek_resim_adi"] as String,
      price: json["yemek_fiyat"] as String,
      count: json["yemek_siparis_adet"] as String,
      username: json["kullanici_adi"] as String,
    );
  }

  Carts copyWith({
    String? id,
    String? name,
    String? picture,
    String? price,
    String? count,
    String? username,
  }) {
    return Carts(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      price: price ?? this.price,
      count: count ?? this.count,
      username: username ?? this.username,
    );
  }
}
