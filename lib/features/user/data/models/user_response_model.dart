import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/auth/data/models/account_model.dart';
import 'package:ctue_app/features/user/business/entities/user_response_entity.dart';

class UserResModel extends UserResEntity {
  UserResModel({required super.data, super.total, super.totalPages});

  factory UserResModel.fromJson({required Map<String, dynamic> json}) {
    return UserResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<AccountModel>(
                (account) => AccountModel.fromJson(json: account))
            .toList() as List<AccountModel>);
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kTotalPages: totalPages,
      kData: (data as List<dynamic>).map((e) => e.toJson()).toList()
    };
  }
}
