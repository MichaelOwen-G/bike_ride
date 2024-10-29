

class Bike {
  String name;
  String id;
  double rating;
  List<String> reviews;
  int payPerHr;

  Bike({
    required this.name,
    required this.id,
    required this.rating,
    required this.reviews,
    required this.payPerHr,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'id': this.id,
      'rating': this.rating,
      'reviews': this.reviews,
      'payPerHr': this.payPerHr,
    };
  }

  factory Bike.fromMap(Map<String, dynamic> map) {
    return Bike(
      name: map['name'] as String,
      id: map['id'] as String,
      rating: map['rating'] as double,
      reviews: map['reviews'] as List<String>,
      payPerHr: map['payPerHr'] as int,
    );
  }
}