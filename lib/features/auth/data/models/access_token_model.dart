import 'package:ctue_app/features/auth/business/entities/access_token_entity.dart';

import '../../../../../core/constants/constants.dart';
// import '../../business/entities/user_entity.dart';

class AccessTokenModel extends AccessTokenEntity {
  AccessTokenModel({
    required String accessToken,
  }) : super(
          accessToken: accessToken,
        );

  factory AccessTokenModel.fromJson({required Map<String, dynamic> json}) {
    return AccessTokenModel(
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kAccessToken: accessToken,
    };
  }
}
