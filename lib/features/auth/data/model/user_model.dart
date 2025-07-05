import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.uid,
    required super.fullName,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      uid: user.uid,
    );
  }
}
