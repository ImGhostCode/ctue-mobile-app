class IrrVerbParams {
  int? id;
  int? page;
  String? sort;
  String? key;
  IrrVerbParams({this.id, this.page, this.sort, this.key});
}

class CreateIrrVerbParams {
  final String v1;
  final String v2;
  final String v3;
  final String meaning;

  final String accessToken;

  CreateIrrVerbParams(
      {required this.v1,
      required this.v2,
      required this.v3,
      required this.meaning,
      required this.accessToken});
}

class UpdateIrrVerbParams {
  final int irrVerbId;
  final String v1;
  final String v2;
  final String v3;
  final String meaning;

  final String accessToken;

  UpdateIrrVerbParams(
      {required this.irrVerbId,
      required this.v1,
      required this.v2,
      required this.v3,
      required this.meaning,
      required this.accessToken});
}

class DeleteIrrVerbParams {
  final int irrVerbId;
  final String accessToken;

  DeleteIrrVerbParams({required this.accessToken, required this.irrVerbId});
}
