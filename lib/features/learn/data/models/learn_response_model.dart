import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/learn/business/entities/learn_response_entity.dart';
import 'package:ctue_app/features/learn/data/models/user_learned_word_model.dart';

class LearnResModel extends LearnResEntity {
  LearnResModel({required super.data, super.total, super.totalPages});

  factory LearnResModel.fromJson({required Map<String, dynamic> json}) {
    return LearnResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<UserLearnedWordModel>(
                (account) => UserLearnedWordModel.fromJson(json: account))
            .toList() as List<UserLearnedWordModel>);
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kTotalPages: totalPages,
      kData: (data as List<dynamic>).map((e) => e.toJson()).toList()
    };
  }
}
