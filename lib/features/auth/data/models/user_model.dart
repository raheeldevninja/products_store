import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {

  const factory UserModel({
    required String uid,
    required String name,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return UserModel(
      uid: doc.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }

}

extension UserModelX on UserModel {
  /// Convert to Firestore document
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  /// Convert model -> entity
  User toEntity() => User(uid: uid, name: name, email: email);

  /// Convert entity -> model
  static UserModel fromEntity(User user) {
    return UserModel(uid: user.uid, name: user.name, email: user.email);
  }
}