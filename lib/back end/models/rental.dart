
class Rental {
  String name, id;
  int pricePerHour; // in ksh
  String openingTime, closingTime; // in 24Hr system
  String backgroundImage, avatar; // firebase storage bucket path
  List<int> ratings; // out of 5
  List<double> location; // length 2 of latitude, longitude

  Rental({
    required this.name,
    this.id = '',
    required this.pricePerHour,
    required this.openingTime,
    required this.closingTime,
    required this.backgroundImage,
    required this.avatar,
    required this.ratings,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'id': this.id,
      'pricePerHour': this.pricePerHour,
      'openingTime': this.openingTime,
      'closingTime': this.closingTime,
      'backgroundImage': this.backgroundImage,
      'avatar': this.avatar,
      'ratings': this.ratings,
      'location': this.location,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      name: map['name'] as String,
      id: map['id'] as String,
      pricePerHour: map['pricePerHour'] as int,
      openingTime: map['openingTime'] as String,
      closingTime: map['closingTime'] as String,
      backgroundImage: map['backgroundImage'] as String,
      avatar: map['avatar'] as String,
      ratings: map['ratings'].cast<int>(),
      location: map['ratings'].cast<int>(),
    );
  }
}