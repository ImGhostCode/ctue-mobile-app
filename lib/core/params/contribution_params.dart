import 'package:image_picker/image_picker.dart';

class CreateWordConParams {
  final String type;
  final Content content;
  final String accessToken;
  CreateWordConParams(
      {required this.type, required this.content, required this.accessToken});
}

class CreateSenConParams {
  final String type;
  final Content content;
  final String accessToken;
  CreateSenConParams(
      {required this.type, required this.content, required this.accessToken});
}

class Content {
  List<dynamic> topicId = [];
  final int? levelId;
  final int? specializationId;
  final int? typeId;
  final String content;
  List<WordMeaning>? meanings = [];
  final String? meaning;
  final String? note;
  final String? phonetic;
  List<String>? examples = [];
  List<String>? synonyms = [];
  List<String>? antonyms = [];
  List<XFile>? pictures = [];
  List<String>? oldPictures = [];

  Content(
      {required this.topicId,
      this.levelId,
      this.specializationId,
      this.typeId,
      required this.content,
      this.meanings,
      this.meaning,
      this.phonetic,
      this.examples,
      this.antonyms,
      this.synonyms,
      this.note,
      this.pictures,
      this.oldPictures});
}

class WordMeaning {
  final int typeId;
  final String meaning;

  WordMeaning({required this.typeId, required this.meaning});
}

class GetAllConParams {
  final String type;
  final int status;
  final int page;
  final String accessToken;
  GetAllConParams(
      {required this.type,
      required this.status,
      required this.page,
      required this.accessToken});
}

class GetAllConByUserParams {
  final int userId;
  final int? page;
  final String accessToken;

  GetAllConByUserParams(
      {required this.userId, required this.accessToken, this.page});
}

class VerifyConParams {
  final int contributionId;
  final bool isWord;
  final int status;
  final String? feedback;
  final String accessToken;

  VerifyConParams(
      {required this.contributionId,
      required this.accessToken,
      required this.isWord,
      required this.status,
      this.feedback});
}
