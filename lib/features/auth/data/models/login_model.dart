import 'package:ctue_app/features/auth/business/entities/login_entity.dart';

import '../../../../../core/constants/constants.dart';
// import '../../business/entities/user_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({String? accessToken, String? feedback})
      : super(accessToken: accessToken, feedback: feedback);

  factory LoginModel.fromJson({required Map<String, dynamic> json}) {
    return LoginModel(
      accessToken: json[kAccessToken],
      feedback: json[kFeedback],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kAccessToken: accessToken,
      kFeedback: feedback,
    };
  }
}
