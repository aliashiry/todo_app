class Users {
  static const String collectionName = "user";
  String? id;
  String? name;
  String? email;

  Users({
    required this.id,
    required this.name,
    required this.email,
  });

  Users.fromFireStore(Map<String, dynamic> data)
      : this(
          name: data['name'] as String,
          email: data['email'] as String,
          id: data['id'] as String,
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
