
class BikeBook{
  String id, rentalId, bikeId;
  bool active;
  DateTime bookedOn; // timestamp

  BikeBook({
    this.id = '',
    required this.rentalId,
    required this.bikeId,
    required this.active,
    required this.bookedOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'rentalId': this.rentalId,
      'bikeId': this.bikeId,
      'active': this.active,
      'bookedOn': this.bookedOn.toIso8601String(),
    };
  }

  factory BikeBook.fromMap(Map<String, dynamic> map) {
    return BikeBook(
      id: map['id'] as String,
      rentalId: map['rentalId'] as String,
      bikeId: map['bikeId'] as String,
      active: map['active'] as bool,
      bookedOn: DateTime.parse(map['bookedOn']),
    );
  }
}