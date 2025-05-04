class User {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email});

  String get capitalisedFirstName => _capitalise(firstName);
  String get capitalisedLastName => _capitalise(lastName);

  String _capitalise(String name) {
    if (name.isEmpty) return name;

    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
    );
  }

  static User empty() {
    return User(
      firstName: '',
      lastName: '',
      phoneNumber: '',
      email: '',
      id: 0,
    );
  }
}
