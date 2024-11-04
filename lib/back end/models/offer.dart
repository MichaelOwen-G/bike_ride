
class Offer {
  String id, title;
  int pricePerHour;
  String description;
  DateTime startDate, endDate;
  Frequency frequency;

  Offer({
    this.id = '',
    required this.title,
    required this.pricePerHour,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.frequency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'pricePerHour': this.pricePerHour,
      'description': this.description,
      'startDate': this.startDate.toIso8601String(),
      'endDate': this.endDate.toIso8601String(),
      'frequency': this.frequency.name,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'] as String,
      title: map['title'] as String,
      pricePerHour: map['pricePerHour'] as int,
      description: map['description'] as String,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      frequency: Frequency.values.byName(map['frequency']),
    );
  }
}

enum Frequency {ONCE, EVERY}