import 'dart:convert';

import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/features/contribute/data/models/contri_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class ContributionLocalDataSource {
  Future<void> cacheContributionByUser(
      {required ResponseDataModel<ContributionResModel>? contributionResModel});
  Future<ResponseDataModel<ContributionResModel>> getLastContributionByUser();

  Future<void> cacheContributionByAdmin(
      {required ResponseDataModel<ContributionResModel>? contributionResModel});
  Future<ResponseDataModel<ContributionResModel>> getLastContributionByAdmin();
}

const cachedContributionByUser = 'CACHED_CONTRIBUTION_BY_USER';
const cachedContributionByAdmin = 'CACHED_CONTRIBUTION_BY_ADMIN';

class ContributionLocalDataSourceImpl implements ContributionLocalDataSource {
  final SharedPreferences sharedPreferences;

  ContributionLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ResponseDataModel<ContributionResModel>> getLastContributionByUser() {
    final jsonString = sharedPreferences.getString(cachedContributionByUser);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<ContributionResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonContribution) =>
              ContributionResModel.fromJson(json: jsonContribution)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheContributionByUser(
      {required ResponseDataModel<ContributionResModel>?
          contributionResModel}) async {
    if (contributionResModel != null) {
      sharedPreferences.setString(
        cachedContributionByUser,
        json.encode(
          contributionResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ResponseDataModel<ContributionResModel>> getLastContributionByAdmin() {
    final jsonString = sharedPreferences.getString(cachedContributionByAdmin);

    if (jsonString != null) {
      return Future.value(ResponseDataModel<ContributionResModel>.fromJson(
          json: json.decode(jsonString),
          fromJsonD: (jsonContribution) =>
              ContributionResModel.fromJson(json: jsonContribution)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheContributionByAdmin(
      {required ResponseDataModel<ContributionResModel>?
          contributionResModel}) async {
    if (contributionResModel != null) {
      sharedPreferences.setString(
        cachedContributionByAdmin,
        json.encode(
          contributionResModel.toJson(toJsonD: (json) => json.toJson()),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
