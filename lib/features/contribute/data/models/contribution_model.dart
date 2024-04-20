import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/user/data/models/user_model.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';

class ContributionModel extends ContributionEntity {
  ContributionModel(
      {required super.id,
      required super.content,
      required super.type,
      required super.status,
      required super.userId,
      required super.createdAt,
      required super.updatedAt,
      super.isDeleted,
      super.feedback,
      super.user});

  factory ContributionModel.fromJson({required Map<String, dynamic> json}) {
    return ContributionModel(
      id: json[kId],
      content: json[kContent],
      isDeleted: json[kIsDeleted],
      type: json[kContriType],
      userId: json[kUserId],
      feedback: json[kFeedback] ?? '',
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
      user: json[kUser] != null ? UserModel.fromJson(json: json[kUser]) : null,
      status: json[kStatus],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kContent: content,
      kIsDeleted: isDeleted,
      kContriType: type,
      kUserId: userId,
      kFeedback: feedback,
      kCreatedAt: createdAt.toString(),
      kUpdatedAt: updatedAt.toString(),
      kUser: (user as UserModel?)?.toJson(),
      kStatus: status
    };
  }
}
