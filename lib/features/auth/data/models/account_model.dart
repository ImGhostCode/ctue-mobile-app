import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';

class AccountModel extends AccountEntity {
  AccountModel(
      {required super.email,
      required super.userId,
      required super.authType,
      required super.accountType,
      required super.isBan,
      required super.feedback,
      required super.isDeleted,
      super.user});

  factory AccountModel.fromJson({required Map<String, dynamic> json}) {
    return AccountModel(
      email: json[kEmail],
      userId: json[kUserId],
      authType: json[kAuthType],
      accountType: json[kAccountType],
      isBan: json[kIsBan],
      feedback: json[kFeedback],
      isDeleted: json[kIsDeleted] ?? false,
      user: UserModel.fromJson(json: json[kUser]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kEmail: email,
      kUserId: userId,
      kAuthType: authType,
      kAccountType: accountType,
      kIsBan: isBan,
      kFeedback: feedback,
      kIsDeleted: isDeleted,
      kUser: (user as UserModel).toJson(),
    };
  }
}
