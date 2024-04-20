import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/specialization/data/models/specialization_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class SpecializationLocalDataSource {
  Future<void> cacheSpecialization(
      {required ResponseDataModel<List<SpecializationModel>>?
          specializationModel});
  Future<ResponseDataModel<List<SpecializationModel>>> getLastSpecialization();
}

const cachedSpecialization = 'CACHED_SPECIALIZATION';

class SpecializationLocalDataSourceImpl
    implements SpecializationLocalDataSource {
  final SharedPreferences sharedPreferences;

  SpecializationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<List<SpecializationModel>>> getLastSpecialization() {
    final jsonString = sharedPreferences.getString(cachedSpecialization);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<List<SpecializationModel>>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (item) => item
              ?.map<SpecializationModel>(
                  (json) => SpecializationModel.fromJson(json: json))
              .toList()));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSpecialization(
      {required ResponseDataModel<List<SpecializationModel>>?
          specializationModel}) async {
    if (specializationModel != null) {
      sharedPreferences.setString(
        cachedSpecialization,
        json.encode(Map.from({
          "data": specializationModel.data.map((e) => e.toJson()).toList(),
          "statusCode": specializationModel.statusCode,
          "message": specializationModel.message
        })),
      );
    } else {
      throw CacheException();
    }
  }
}
