import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/type/data/models/type_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class TypeLocalDataSource {
  Future<void> cacheType(
      {required ResponseDataModel<List<TypeModel>>? typeModel});
  Future<ResponseDataModel<List<TypeModel>>> getLastType();
}

const cachedType = 'CACHED_TYPE';

class TypeLocalDataSourceImpl implements TypeLocalDataSource {
  final SharedPreferences sharedPreferences;

  TypeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<List<TypeModel>>> getLastType() {
    final jsonString = sharedPreferences.getString(cachedType);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<TypeModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (item) => item
              ?.map<TypeModel>((json) => TypeModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheType(
      {required ResponseDataModel<List<TypeModel>>? typeModel}) async {
    if (typeModel != null) {
      sharedPreferences.setString(
        cachedType,
        json.encode(Map.from({
          "data": typeModel.data.map((e) => e.toJson()).toList(),
          "statusCode": typeModel.statusCode,
          "message": typeModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }
}
