class User {
  String id, userId; // this userId is the uid for the FirebaseAuthenticated user credentials
  String name, phoneNumber;
  AccountType accountType;
  List<String> favouriteBike;

  User({
    this.id = '',
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.accountType,
    required this.favouriteBike,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userId': this.userId,
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'accountType': this.accountType.name,
      'favouriteBike': this.favouriteBike,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      accountType: AccountType.values.byName(map['accountType'] ),
      favouriteBike: map['favouriteBike'].cast<String>(),
    );
  }
}

enum AccountType {ANONYMOUS, PERMANENT}