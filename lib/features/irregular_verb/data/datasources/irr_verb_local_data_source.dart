import 'dart:convert';

import 'package:ctue_app/features/irregular_verb/data/models/irr_verb_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class IrrVerbLocalDataSource {
  Future<void> cacheIrrVerb({required IrrVerbModel? templateToCache});
  Future<IrrVerbModel> getLastIrrVerb();
}

const cachedIrrVerb = 'CACHED_TEMPLATE';

class IrrVerbLocalDataSourceImpl implements IrrVerbLocalDataSource {
  final SharedPreferences sharedPreferences;

  IrrVerbLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<IrrVerbModel> getLastIrrVerb() {
    final jsonString = sharedPreferences.getString(cachedIrrVerb);

    if (jsonString != null) {
      return Future.value(IrrVerbModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheIrrVerb({required IrrVerbModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedIrrVerb,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
