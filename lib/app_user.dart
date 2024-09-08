class AppUser {
  final String name;
  final String phone;
  final String email;
  final String address;

  AppUser(this.name, this.phone, this.email, this.address);

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
      };

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(map['name'], map['phone'], map['email'], map['address']);
  }
}
