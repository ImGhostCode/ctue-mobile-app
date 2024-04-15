import 'package:image_picker/image_picker.dart';

class CreVocaSetParams {
  final String title;
  final int? topicId;
  final int? specId;
  final XFile? picture;
  List<int> words = [];
  final String accessToken;

  CreVocaSetParams(
      {required this.title,
      this.topicId,
      this.specId,
      this.picture,
      required this.words,
      required this.accessToken});
}

class DownloadVocaSetParams {
  final int? id;
  final String accessToken;

  DownloadVocaSetParams({required this.accessToken, this.id});
}

class GetVocaSetStatisParams {
  final int? id;
  final String accessToken;

  GetVocaSetStatisParams({required this.accessToken, this.id});
}

class GetVocaSetParams {
  final int? id;
  final String? key;
  final int? topicId;
  final int? specId;
  final String accessToken;
  final int? page;

  GetVocaSetParams(
      {required this.accessToken,
      this.key,
      this.specId,
      this.topicId,
      this.page,
      this.id});
}

class UpdateVocaSetParams {
  final int id;
  final String? title;
  final int? topicId;
  final int? specId;
  final String? oldPicture;
  final XFile? picture;
  final bool? isPublic;
  List<int>? words;
  List<int>? oldWords;
  final String accessToken;

  UpdateVocaSetParams(
      {required this.accessToken,
      this.title,
      this.oldPicture,
      this.picture,
      this.isPublic,
      this.words,
      this.oldWords,
      this.specId,
      this.topicId,
      required this.id});
}

class RemoveVocaSetParams {
  final int id;
  final bool isDownloaded;
  final String accessToken;

  RemoveVocaSetParams(
      {required this.accessToken,
      required this.isDownloaded,
      required this.id});
}
