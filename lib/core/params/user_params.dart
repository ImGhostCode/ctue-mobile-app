import 'package:image_picker/image_picker.dart';

class GetUserParams {
  final String accessToken;

  GetUserParams({required this.accessToken});
}

class UpdateUserParams {
  final int id;
  final XFile? avt;
  final String? name;
  final String accessToken;

  UpdateUserParams(
      {required this.id, this.avt, this.name, required this.accessToken});
}
