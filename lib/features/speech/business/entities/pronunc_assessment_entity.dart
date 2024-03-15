import 'package:ctue_app/features/user/business/entities/user_entity.dart';

class PronuncAssessmentEntity {
  final int id;
  final int userId;
  final String label;
  final int score;
  List<PhonemeAssessmentEntity> phonemeAssessments = [];
  final UserEntity? userEntity;

  PronuncAssessmentEntity(
      {required this.id,
      required this.userId,
      required this.label,
      required this.score,
      required this.phonemeAssessments,
      this.userEntity});
}

class PhonemeAssessmentEntity {
  final int id;
  final String label;
  final int score;

  PhonemeAssessmentEntity(
      {required this.id, required this.label, required this.score});
}
