import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:image_picker/image_picker.dart';

class GetWordParams {
  final int? id;
  List<int>? topic = [];
  List<int>? type = [];
  final int? level;
  final int? specialization;
  final int? page;
  final String? sort;
  final String? key;

  GetWordParams(
      {this.id,
      this.type,
      this.page,
      this.sort = 'asc',
      this.topic,
      this.level,
      this.specialization,
      this.key});
}

class LookUpDictionaryParams {
  final String key;

  LookUpDictionaryParams({required this.key});
}

class LookUpByImageParams {
  final XFile file;

  LookUpByImageParams({required this.file});
}

class CreateWordParams {
  List<dynamic> topicId = [];
  final int levelId;
  final int specializationId;
  // final int typeId;
  final String content;
  List<WordMeaning> meanings = [];
  // final String meaning;
  final String? note;
  final String phonetic;
  List<String> examples = [];
  List<String> synonyms = [];
  List<String> antonyms = [];
  List<XFile> pictures = [];

  final String accessToken;

  CreateWordParams(
      {required this.topicId,
      required this.levelId,
      required this.specializationId,
      // required this.typeId,
      required this.content,
      required this.meanings,
      // required this.meaning,
      required this.phonetic,
      required this.examples,
      required this.antonyms,
      required this.synonyms,
      this.note,
      required this.pictures,
      required this.accessToken});
}

class UpdateWordParams {
  final int wordId;
  List<dynamic> topicId = [];
  final int levelId;
  final int specializationId;
  // final int typeId;
  final String content;
  List<WordMeaning> meanings = [];
  // final String meaning;
  final String? note;
  final String phonetic;
  List<String> examples = [];
  List<String> synonyms = [];
  List<String> antonyms = [];
  List<XFile> pictures = [];
  List<String> oldPictures = [];

  final String accessToken;

  UpdateWordParams(
      {required this.wordId,
      required this.topicId,
      required this.levelId,
      required this.specializationId,
      // required this.typeId,
      required this.content,
      required this.meanings,
      // required this.meaning,
      required this.phonetic,
      required this.examples,
      required this.antonyms,
      required this.synonyms,
      this.note,
      required this.pictures,
      required this.oldPictures,
      required this.accessToken});
}

class DeleteWordParams {
  final int wordId;
  final String accessToken;

  DeleteWordParams({required this.accessToken, required this.wordId});
}
