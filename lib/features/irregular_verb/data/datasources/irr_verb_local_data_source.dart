import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class IrrVerbLocalDataSource {
  Future<void> cacheIrrVerb(
      {required ResponseDataModel<IrrVerbResModel>? irrVerbResModel});
  Future<ResponseDataModel<IrrVerbResModel>> getLastIrrVerb();
}

const cachedIrrVerb = 'CACHED_IRR_VERB';

class IrrVerbLocalDataSourceImpl implements IrrVerbLocalDataSource {
  final SharedPreferences sharedPreferences;

  IrrVerbLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<IrrVerbResModel>> getLastIrrVerb() {
    final jsonString = sharedPreferences.getString(cachedIrrVerb);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<IrrVerbResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonIrrVerb) =>
              IrrVerbResModel.fromJson(json: jsonIrrVerb)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheIrrVerb(
      {required ResponseDataModel<IrrVerbResModel>? irrVerbResModel}) async {
    if (irrVerbResModel != null) {
      sharedPreferences.setString(
        cachedIrrVerb,
        json.encode(
          irrVerbResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
