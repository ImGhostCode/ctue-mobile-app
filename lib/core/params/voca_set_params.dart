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
