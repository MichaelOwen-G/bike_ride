

class Bike {
  String name, id, bikeModel, bikePicture;
  double rating;
  int pricePerHour, bookingPrice, bookDuration; // book duration in minutes
  AvailabilityStatus availabilityStatus;
  List<int> ratings;

  Bike({
    required this.name,
    this.id = '',
    required this.rating,
    required this.pricePerHour,
    required this.bikeModel,
    required this.bikePicture,
    required this.availabilityStatus,
    required this.bookingPrice,
    required this.bookDuration,
    required this.ratings,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'id': this.id,
      'rating': this.rating,
      'pricePerHour': this.pricePerHour,
      'bikeModel': this.bikeModel,
      'bikePicture': this.bikePicture,
      'availabilityStatus': this.availabilityStatus.name,
      'bookingPrice': this.bookingPrice,
      'bookDuration': this.bookDuration,
      'ratings': this.ratings,
    };
  }

  factory Bike.fromMap(Map<String, dynamic> map) {
    return Bike(
      name: map['name'] as String,
      id: map['id'] as String,
      rating: map['rating'] as double,
      pricePerHour: map['pricePerHour'] as int,
      bikeModel: map['bikeModel'] as String,
      bikePicture: map['bikePicture'] as String,
      availabilityStatus: AvailabilityStatus.values.byName(map['availabilityStatus']),
      bookingPrice: map['bookingPrice'] as int,
      bookDuration: map['bookDuration'] as int,
      ratings: map['ratings'].cast<int>(),
    );
  }
}


enum AvailabilityStatus {
  BOOKED,
  ON_SESSION,
  AVAILABLE,
}

