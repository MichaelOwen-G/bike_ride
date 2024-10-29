
class Rental {
  String name;
  int payPerHr;

  Rental({required this.payPerHr, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'payPerHr': payPerHr,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      name: map['name'] as String,
      payPerHr: map['payPerHr'] as int,
    );
  }
}