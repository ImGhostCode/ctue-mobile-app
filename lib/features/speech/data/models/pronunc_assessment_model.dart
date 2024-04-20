import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/speech/business/entities/pronunc_assessment_entity.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';

class PronuncAssessmentModel extends PronuncAssessmentEntity {
  PronuncAssessmentModel(
      {required super.id,
      required super.userId,
      required super.label,
      required super.score,
      required super.phonemeAssessments,
      super.userEntity});

  factory PronuncAssessmentModel.fromJson(
      {required Map<String, dynamic> json}) {
    return PronuncAssessmentModel(
        id: json[kId],
        userId: json[kUserId],
        label: json[kLabel],
        score: json[kScore],
        phonemeAssessments: json[kPhonemeAssessment]
            .map<PhonemeAssessmentModel>(
                (phoneme) => PhonemeAssessmentModel.fromJson(json: phoneme))
            .toList() as List<PhonemeAssessmentModel>,
        userEntity:
            json[kUser] != null ? UserModel.fromJson(json: json[kUser]) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kUserId: userId,
      kLabel: label,
      kScore: score,
      kPhonemeAssessment:
          (phonemeAssessments as List<dynamic>).map((e) => e.toJson()).toList(),
      kUser: (userEntity as UserModel?)?.toJson()
    };
  }
}

class PhonemeAssessmentModel extends PhonemeAssessmentEntity {
  PhonemeAssessmentModel({
    required super.id,
    required super.label,
    required super.score,
  });

  factory PhonemeAssessmentModel.fromJson(
      {required Map<String, dynamic> json}) {
    return PhonemeAssessmentModel(
      id: json[kId],
      label: json[kLabel],
      score: json[kScore],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kLabel: label,
      kScore: score,
    };
  }
}
