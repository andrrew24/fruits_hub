class UserEntity {
  final String email;
  final String uid;
  final String fullName;

  UserEntity({required this.email, required this.uid, required this.fullName});

  Map<String, dynamic> toMap() {
    return {'email': email, 'uid': uid, 'fullName': fullName};
  }

  UserEntity copyWith({
    String? email,
    String? uid,
    String? fullName,
  }) {
    return UserEntity(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
    );
  }
}
