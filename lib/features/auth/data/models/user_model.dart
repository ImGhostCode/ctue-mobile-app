import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/auth/business/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.name,
      super.avt,
      required super.isDeleted,
      required super.createdAt,
      required super.updatedAt});

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      id: json['User']['id'],
      name: json['User']['name'],
      avt: json['User']['avt'],
      isDeleted: json['User']['isDeleted'],
      createdAt: DateTime.parse(json['User']['createdAt']),
      updatedAt: DateTime.parse(json['User']['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kName: name,
      kAvt: avt,
      kIsDeleted: isDeleted,
      kCreatedAt: createdAt,
      kUpdatedAt: updatedAt
    };
  }
}
