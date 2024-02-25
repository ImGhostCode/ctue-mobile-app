import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';

class TypeModel extends TypeEntity {
  TypeModel({required super.id, required super.name, super.isWord});

  factory TypeModel.fromJson({required Map<String, dynamic> json}) {
    return TypeModel(
        id: json['id'], name: json['name'], isWord: json['isWord']);
  }

  Map<String, dynamic> toJson() {
    return {kId: id, kName: name, kisWord: isWord};
  }
}
