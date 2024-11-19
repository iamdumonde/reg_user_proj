class User {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String address;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.mobile,
      required this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
    );
  }
}
