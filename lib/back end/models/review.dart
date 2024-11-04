
class Review {
  String id, userId; // this userId is the id of the userModel
  String description;

  Review({
    this.id = '',
    required this.userId,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userId': this.userId,
      'description': this.description,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      userId: map['userId'] as String,
      description: map['description'] as String,
    );
  }
}