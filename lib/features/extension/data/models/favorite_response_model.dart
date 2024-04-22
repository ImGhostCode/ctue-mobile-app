import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/extension/business/entities/favorite_response_entity.dart';
import 'package:ctue_app/features/extension/data/models/favorite_model.dart';

class FavoriteResModel extends FavoriteResEntity {
  FavoriteResModel({required super.data, super.total, super.totalPages});

  factory FavoriteResModel.fromJson({required Map<String, dynamic> json}) {
    return FavoriteResModel(
        total: json[kTotal],
        totalPages: json[kTotalPages],
        data: json[kData]
            .map<FavoriteModel>((favo) => FavoriteModel.fromJson(json: favo))
            .toList() as List<FavoriteModel>);
  }

  Map<String, dynamic> toJson() {
    return {
      kTotal: total,
      kTotalPages: totalPages,
      kData: (data as List<dynamic>).map((e) => e.toJson()).toList()
    };
  }
}
